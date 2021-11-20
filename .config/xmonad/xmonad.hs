--------------------------------------------------------------------------------
--                            ~/.xmonad/xmonad.hs                             --
--------------------------------------------------------------------------------

------------------
-- {-# Imports #-}
------------------
import XMonad hiding ((|||))
import qualified XMonad.Layout.Magnifier as Mag
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Actions.NoBorders
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing
import XMonad.Prompt.Pass
import XMonad.Util.Loggers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig (additionalKeys,removeKeys)
import System.Exit (exitWith, ExitCode(ExitSuccess))
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
xMoji = "splatmoji type"
xFont  = "xft:xos4 terminus"

----------------------
--{-# Key Bindings #-}
----------------------
xMod      = mod4Mask
xShiftMod = xMod .|. shiftMask
xKillMask = xMod .|. controlMask

xWorkspaces = ["1","2","3","4","5","6"]
xWorkspaceKeys = [((m .|. xMod, k), windows $ f i)
                 | (i, k) <- zip xWorkspaces [xK_1 .. xK_5]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
                 ++
                 [((m .|. xMod, key), screenWorkspace sc >>= flip whenJust (windows . f))
                 | (key, sc) <- zip [xK_w, xK_e] [0..]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

xKeys = [ ((xMod,      xK_Delete),    kill)
        , ((xMod,      xK_Return),    spawn xTerm)
        , ((xMod,      xK_r),         spawn xLaunch)
        , ((xMod,      xK_q),         spawn xBrowser)
        , ((xMod,      xK_p),         passTypePrompt def)
        , ((xMod,      xK_space),     sendMessage NextLayout)
        , ((xMod,      xK_l),         sendMessage Shrink)
        , ((xMod,      xK_h),         sendMessage Expand)
        , ((xMod,      xK_f),         sendMessage $ JumpToLayout "Full")
        , ((xMod,      xK_k),         windows W.focusUp)
        , ((xMod,      xK_j),         windows W.focusDown)
        , ((xMod,      xK_m),         sendMessage Mag.Toggle)
        , ((xMod,      xK_equal),     sendMessage Mag.MagnifyMore)
        , ((xMod,      xK_minus),     sendMessage Mag.MagnifyLess)
        , ((xMod,      xK_s),         withFocused $ windows . W.sink)
        , ((xShiftMod, xK_j),         windows W.swapUp)
        , ((xShiftMod, xK_k),         windows W.swapDown)
        , ((xShiftMod, xK_m),         windows W.swapMaster)
        , ((xShiftMod, xK_n),         windows W.shiftMaster)
        , ((xKillMask, xK_BackSpace), io (exitWith ExitSuccess))]

xNoKeys = [ (xMod, xK_comma)
          , (xMod, xK_ampersand)
          , (xMod, xK_dollar)
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
                     , isClass "zoom"            --> doShift "5"
                     , isClass "zoom"            --> doFloat
                     , isClass "Xmessage"        --> doCenterFloat
                     , isProp role popUp         --> doFullFloat
                     , isProp role fileDialog    --> doCenterFloat
                     , isDialog                  --> doCenterFloat
                     , isFullscreen              --> (doF W.focusDown <+> doFullFloat)
                     , transience'
                     ]

--------------
--{-# Main #-}
--------------
myConfig = def { modMask            = xMod
               , terminal           = xTerm
               , focusFollowsMouse  = False
               , clickJustFocuses   = True
               , borderWidth        = 5
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
     . E.ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig
