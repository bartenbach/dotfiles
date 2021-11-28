--------------------------------------------------------------------------------
--                        ~/.config/xmonad/xmonad.hs                          --
--------------------------------------------------------------------------------

------------------
-- {-# Imports #-}
------------------
import System.Exit (exitWith, ExitCode(ExitSuccess))
import XMonad.Actions.EasyMotion (selectWindow)
import XMonad.Actions.GridSelect
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing
import XMonad.Prompt.Pass
import XMonad.Util.Loggers
import XMonad.Util.EZConfig (additionalKeys,removeKeys)
import XMonad hiding ((|||))
import qualified XMonad.Layout.Magnifier as Mag
import qualified XMonad.Hooks.EwmhDesktops as E
import qualified XMonad.StackSet as W

---------------------------
--{-# Color Definitions #-}
---------------------------
red    = "#FF0000"
black  = "#000"
yellow = "#FFFF00"
orange  = "#d69131"
darkOrange  = "#68502e"
darkSlateGray = "#2f4f4f"
magenta = "#FF007f"
darkMagenta = "#711c91"

--xTerm = "st -f terminus:pixelsize=32"
xTerm = "alacritty"
xBrowser = "qutebrowser"
xLaunch = "dmenu_run -b -fn terminus -i"
xLock = "slock"
xMoji = "splatmoji type"
xFont  = "xft:xos4 terminus"

----------------------
--{-# Key Bindings #-}
----------------------
modm      = mod4Mask
xShiftMod = modm .|. shiftMask
xKillMask = modm .|. controlMask

xWorkspaces = ["1:irc","2:org","3:src","4:web","5:doc","6:ext"]
xWorkspaceKeys = [((m .|. modm, k), windows $ f i)
                 | (i, k) <- zip xWorkspaces [xK_1 .. xK_5]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
                 ++
                 [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
                 | (key, sc) <- zip [xK_w, xK_e] [0..]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

xKeys = [ ((modm,      xK_Delete),    kill)
        , ((modm,      xK_Return),    spawn xTerm)
        , ((modm,      xK_r),         spawn xLaunch)
        , ((modm,      xK_q),         spawn xBrowser)
        , ((modm,      xK_x),         spawn xLock)
        , ((modm,      xK_p),         passTypePrompt def)
        , ((modm,      xK_g),         goToSelected def)
        , ((modm,      xK_space),     sendMessage NextLayout)
        , ((modm,      xK_h),         sendMessage Shrink)
        , ((modm,      xK_l),         sendMessage Expand)
        , ((modm,      xK_k),         windows W.focusUp)
        , ((modm,      xK_j),         windows W.focusDown)
        , ((modm,      xK_f),         selectWindow def >>= (`whenJust` windows . W.focusWindow))
        , ((modm,      xK_m),         sendMessage Mag.Toggle)
        , ((modm,      xK_equal),     sendMessage Mag.MagnifyMore)
        , ((modm,      xK_minus),     sendMessage Mag.MagnifyLess)
        , ((modm,      xK_s),         withFocused $ windows . W.sink)
        , ((0,         xK_F4),        spawn "scrot")
        , ((0,         xK_F12),       spawn "xdotool key Shift+Insert")
        , ((xShiftMod, xK_f),         selectWindow def >>= (`whenJust` killWindow))
        , ((xShiftMod, xK_j),         windows W.swapUp)
        , ((xShiftMod, xK_k),         windows W.swapDown)
        , ((xShiftMod, xK_m),         windows W.swapMaster)
        , ((xShiftMod, xK_n),         windows W.shiftMaster)
        , ((xKillMask, xK_BackSpace), io (exitWith ExitSuccess))
        ]

xNoKeys = [ (modm, xK_comma)
          , (modm, xK_ampersand)
          , (modm, xK_dollar)
          ]

---------------------
--{-# Layout Hook #-}
----------------------
xSpacing = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True
xLayout = avoidStruts(Mag.magnifierOff(tiled) ||| Grid ||| fullscreenFull Full)
  where
    tiled    = Tall nmaster delta ratio
    nmaster  = 1
    ratio    = 1/2
    delta    = 3/100

---------------------
--{-# Startup Hook #-}
---------------------
xStartupHook = setWMName "LG3D"  -- because Java...

---------------------
--{-# Manage Hook #-}
---------------------
fileDialog = "GtkFileChooserDialog"
popUp      = "pop-up"
role       = "WM_WINDOW_ROLE"

isProp x y = stringProperty x =? y
isClass x  = className        =? x

xManage = composeAll [ isClass "Gimp"            --> doFloat
                     , isClass "qutebrowser"     --> doShiftAndGo "4:web"
                     , isClass "zoom"            --> doShift "5"
                     , isClass "zoom"            --> doFloat
                     , isClass "Xmessage"        --> doCenterFloat
                     , isProp role popUp         --> doFullFloat
                     , isProp role fileDialog    --> doCenterFloat
                     , isDialog                  --> doCenterFloat
                     , isFullscreen              --> (doF W.focusDown <+> doFullFloat)
                     , transience'
                     ]
          where
              doShiftAndGo ws = doF (W.greedyView ws) <+> doShift ws


--------------
--{-# Main #-}
--------------
myConfig = def { modMask            = modm
               , terminal           = xTerm
               , focusFollowsMouse  = False
               , clickJustFocuses   = True
               , borderWidth        = 10
               , normalBorderColor  = black
               , focusedBorderColor = magenta
               , workspaces         = xWorkspaces
               , layoutHook         = avoidStruts $ xSpacing $ xLayout
               , manageHook         = xManage <+> manageDocks <+> fullscreenManageHook
               , startupHook        = xStartupHook
               , handleEventHook    = fullscreenEventHook
               }
               `removeKeys` xNoKeys
               `additionalKeys` xKeys

myXmobarPP :: PP
myXmobarPP = def
    {
     ppCurrent         = wrap (blue "[") (blue "]") . white
    , ppHidden          = lowWhite . pad
    , ppHiddenNoWindows = lowWhite . pad
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, _] -> [ws]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue
    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""


main :: IO ()
main = xmonad
     . docks
     . E.ewmhFullscreen
     . E.ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig
