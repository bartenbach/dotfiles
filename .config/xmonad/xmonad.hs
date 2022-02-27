--------------------------------------------------------------------------------
--                        ~/.config/xmonad/xmonad.hs                          --
--------------------------------------------------------------------------------

------------------
-- {-# Imports #-}
------------------
import System.Exit (exitWith, ExitCode(ExitSuccess))
import XMonad.Actions.NoBorders
import XMonad.Actions.SinkAll
import XMonad.Actions.SpawnOn
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.Fullscreen
import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig (additionalKeys,removeKeys)
import XMonad.Util.Loggers
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce
import XMonad hiding ((|||))
import qualified XMonad.Hooks.EwmhDesktops as E
import qualified XMonad.StackSet as W

---------------------------
--{-# Color Definitions #-}
---------------------------
red    = "#FF0000"
black  = "#000"
yellow = "#FFFF00"
magenta = "#FF007f"

---------------------------
--{-# Shell commands    #-}
---------------------------
xTerm = "alacritty"
xBrowser = "qutebrowser"
xLaunch = "rofi -show run"
xSsh = "rofi -show ssh"
xRecompile = "xmonad --recompile && xmonad --restart"
xClipboardScreenshot = "shart --clipboard"
xPersistentScreenshot = "shart"
xPasswordSelect = "passmenu"

----------------------
--{-# Key Bindings #-}
----------------------
modm      = mod4Mask
xShiftMod = modm .|. shiftMask
xKillMask = modm .|. controlMask

xWorkspaces = ["1:irc","2:org","3:src","4:web","5:doc","6:ext"]
xWorkspaceKeys = [((m .|. modm, k), windows $ f i)
                     | (i, k) <- zip (xWorkspaces) [xK_1 .. xK_9]
                     , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
                 ++
                 [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
                     | (key, sc) <- zip [xK_e, xK_w] [0..]
                     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

xKeys = [
        --  applications and scripts
          ((modm,      xK_Return),    spawn xTerm)
        , ((modm,      xK_r),         spawn xLaunch)
        , ((modm,      xK_q),         spawn xBrowser)
        , ((modm,      xK_x),         spawn xRecompile)
        , ((modm,      xK_z),         spawn xSsh)
        , ((0,         xK_F4),        spawn xClipboardScreenshot)
        , ((0,         xK_F5),        spawn xPersistentScreenshot)
        , ((modm,      xK_p),         spawn xPasswordSelect)

        -- scratchpads
        , ((modm,      xK_t),         namedScratchpadAction scratchpads "taskwarrior")
        , ((modm,      xK_a),         namedScratchpadAction scratchpads "term")
        , ((modm,      xK_c),         namedScratchpadAction scratchpads "calcurse")

        -- window management
        , ((modm,      xK_space),     sendMessage NextLayout)
        , ((modm,      xK_h),         sendMessage Shrink)
        , ((modm,      xK_l),         sendMessage Expand)
        , ((modm,      xK_m),         sendMessage Toggle)
        , ((modm,      xK_plus),      sendMessage MagnifyMore)
        , ((modm,      xK_minus),     sendMessage MagnifyLess)
        , ((modm,      xK_s),         withFocused $ windows . W.sink)
        , ((modm,      xK_k),         windows W.focusUp)
        , ((modm,      xK_j),         windows W.focusDown)
        , ((xShiftMod, xK_j),         windows W.swapUp)
        , ((xShiftMod, xK_k),         windows W.swapDown)
        , ((xShiftMod, xK_m),         windows W.swapMaster)
        , ((xShiftMod, xK_n),         windows W.shiftMaster)

        -- kill
        , ((modm,      xK_Delete),    kill)
        , ((xKillMask, xK_BackSpace), io (exitWith ExitSuccess))
        ]
        ++ xWorkspaceKeys

xNoKeys = [ (modm, xK_comma)
          , (modm, xK_ampersand)
          , (modm, xK_dollar)
          ]

---------------------
--{-# Layout Hook #-}
----------------------
xSpacing = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True
xLayout = avoidStruts $ magnifierOff(tiled ||| Grid) ||| fullscreenFull Full
  where
    tiled    = Tall nmaster delta ratio
    nmaster  = 1
    ratio    = 1/2
    delta    = 3/100

---------------------
--{-# Startup Hook #-}
---------------------
xStartupHook :: X ()
xStartupHook = do
    spawnOnOnce "1:irc" "alacritty -e weechat"
    spawnOnOnce "2:org" "alacritty -e calcurse"
    spawnOnOnce "2:org" "alacritty -e taskwarrior-tui"
    spawnOnOnce "2:org" "alacritty -e neomutt"
    spawnOnOnce "5:doc" "alacritty -e nvim -c VimwikiIndex"

---------------------
--{-# Manage Hook #-}
---------------------
fileDialog = "GtkFileChooserDialog"
role       = "WM_WINDOW_ROLE"

isProp x y = stringProperty x =? y
isClass x  = className        =? x

xManage = composeAll [ isClass "Gimp"            --> doFloat
                     , isClass "qutebrowser"     --> doShiftAndGo "4:web"
                     , isClass "zoom"            --> doShift "6:ext"
                     , isClass "quteSelect"      --> doRectFloat (W.RationalRect 0.05 0.05 0.9 0.9)
                     , isProp role fileDialog    --> doRectFloat (W.RationalRect 0.05 0.05 0.9 0.9)
                     , isClass "Xmessage"        --> doFullFloat
                     , isProp role "pop-up"      --> doFullFloat
                     , isDialog                  --> doCenterFloat
                     , transience'
                     ]
                  where
                     doShiftAndGo ws = doF (W.greedyView ws) <+> doShift ws

scratchpads :: [NamedScratchpad]
scratchpads = [
    NS "calcurse"
       "alacritty --class tw_calcurse,tw_calcurse -e calcurse"
       (className =? "tw_calcurse")
       (customFloating $ W.RationalRect 0.2 0.2 0.6 0.6),

    NS "taskwarrior"
       "alacritty --class tw_scratchpad,tw_scratchpad -e ~/.cargo/bin/taskwarrior-tui"
       (className =? "tw_scratchpad")
       (customFloating $ W.RationalRect 0.2 0.2 0.6 0.6),

    NS "term"
       "alacritty --class term_scratchpad,term_scratchpad"
       (className =? "term_scratchpad")
       (customFloating $ W.RationalRect 0.1 0.1 0.8 0.8)
  ]

--------------
--{-# Main #-}
--------------
myConfig = def { modMask            = modm
               , terminal           = xTerm
               , focusFollowsMouse  = False
               , clickJustFocuses   = True
               , borderWidth        = 8
               , normalBorderColor  = black
               , focusedBorderColor = magenta
               , workspaces         = xWorkspaces
               , layoutHook         = avoidStruts $ xSpacing $ xLayout
               , manageHook         = xManage
                                      <+> manageDocks
                                      <+> fullscreenManageHook
                                      <+> manageSpawn
                                      <+> namedScratchpadManageHook scratchpads
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

mySB = statusBarProp "xmobar" (pure myXmobarPP)
main :: IO ()
main = xmonad
     . docks
     . E.ewmhFullscreen
     . E.ewmh
     . withSB mySB
     $ myConfig
