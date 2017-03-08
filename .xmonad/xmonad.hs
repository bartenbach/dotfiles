--------------------------------------------------------------------------------
--                            ~/.xmonad/xmonad.hs                             --
--                                  by proxa                                  --
--------------------------------------------------------------------------------

------------------
-- {-# Imports #-}
------------------
import XMonad hiding ((|||))
import XMonad.Actions.NoBorders
import XMonad.Layout.Tabbed (tabbed, Theme(..), defaultTheme, shrinkText)
import XMonad.Layout.MagicFocus
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Fullscreen
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog, doFullFloat, 
                                          doCenterFloat, transience')
import XMonad.Util.EZConfig (additionalKeys,removeKeys)
import System.Exit (exitWith, ExitCode(ExitSuccess))
import qualified XMonad.StackSet as W

-------------------
-- {-# Mod Keys #-}
-------------------

-----------------
--{-# Borders #-}
-----------------
xBorderWidth = 0
xBorderColor = show Black
xBorderFocus = show Red

---------------
--{-# Mouse #-}
---------------
xMouseFocus :: Bool
xMouseFocus =  False

--------------------
--{-# Workspaces #-}
--------------------
xWorkspaces = "1":"2":"3":"4":"5":"6":[]

---------------------------
--{-# Color Definitions #-}
---------------------------
data XColor = Red
            | Black
            | Yellow

instance Show XColor where
    show Red    = "#FF0000"
    show Yellow = "#FFFF00"
    show Black  = "#000"

----------------------
--{-# Applications #-}
----------------------
data ShellCommands = URxvtc
                   | DMenu
                   | XMonadRecompile

instance Show ShellCommands where
  show URxvtc          = "urxvtc"
  show DMenu           = "dmenu_run -p dmenu -fn \"xos4 terminus\" -nb black -nf gray -sb white -sf black -i"
  show XMonadRecompile = "xmonad --recompile;xmonad --restart"

launch = spawn . show

---------------
--{-# Theme #-}
---------------
-- I didn't even have this font...what does it do?  where is this font rendered?
xFont  = "-windows-proggytinysz-medium-r-normal--8-80-96-96-c-60-iso8859-1"

xTheme = defaultTheme { activeColor         = show Black
                      , activeBorderColor   = show Red
                      , activeTextColor     = show Red
                      , inactiveColor       = show Black
                      , inactiveTextColor   = show Black
                      , inactiveBorderColor = show Black
                      , urgentColor         = show Black
                      , urgentTextColor     = show Yellow
                      , urgentBorderColor   = show Yellow
                      , fontName            = xFont
                      , decoHeight          = 12
                      }

----------------------
--{-# Key Bindings #-}
----------------------
xMod      = mod4Mask
xShiftMod = xMod .|. shiftMask
xKillMask = xMod .|. controlMask

xWorkspaceKeys = [((m .|. xMod, k), windows $ f i) 
                 | (i, k) <- zip (xWorkspaces) [xK_1 .. xK_5]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
                 ++
                 [((m .|. xMod, key), screenWorkspace sc >>= flip whenJust (windows . f))
                 | (key, sc) <- zip [xK_w, xK_e] [0..]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

xKeys = [ ((xMod,      xK_Escape),    kill)
        , ((xMod,      xK_Return),    Main.launch URxvtc)
        , ((xMod,      xK_r),         Main.launch DMenu)
        , ((xMod,      xK_c),         Main.launch XMonadRecompile)
        , ((xMod,      xK_b),         withFocused toggleBorder)
        , ((xMod,      xK_space),     sendMessage NextLayout)
        , ((xMod,      xK_j),         sendMessage Shrink)
        , ((xMod,      xK_k),         sendMessage Expand)
        , ((xMod,      xK_h),         windows W.focusUp)
        , ((xMod,      xK_l),         windows W.focusDown)
        , ((xMod,      xK_t),         sendMessage ToggleStruts)
        , ((xMod,      xK_s),         withFocused $ windows . W.sink)
        , ((xShiftMod, xK_j),         windows W.swapUp)
        , ((xShiftMod, xK_k),         windows W.swapDown)
        , ((xKillMask, xK_BackSpace), io (exitWith ExitSuccess))]

xNoKeys = [ (xMod, xK_comma)
          , (xMod, xK_ampersand)
          , (xMod, xK_dollar)  ]

---------------------
--{-# Layout Hook #-}
----------------------
xLayout = avoidStruts(tile ||| tab ||| Grid ||| fullscreenFull Full)
  where
    tab     = tabbed shrinkText xTheme
    tile    = Tall nmaster delta ratio
    nmaster = 1
    delta   = 3/100
    ratio   = 1/2

---------------------
--{-# Startup Hook #-}
---------------------
--xStartupHook = setWMName "LG3D"  -- because Java...

---------------------
--{-# Manage Hook #-}
---------------------
fileDialog = "GtkFileChooserDialog"
popUp      = "pop-up"
role       = "WM_WINDOW_ROLE"

isProp x y = stringProperty x =? y
isClass x  = className        =? x

xManage = composeAll [ isClass "Gimp"            --> doFloat
                     , isClass "feh"             --> doFloat
                     , isClass "desktop_window"  --> doIgnore
                     , isClass "kdesktop"        --> doIgnore
                     , isClass "xmessage"        --> doCenterFloat 
                     , isClass "MPlayer"         --> doCenterFloat
                     , isClass "nvidia-settings" --> doCenterFloat
                     , isClass "PCSXR"           --> doFullFloat
                     , isProp role popUp         --> doFullFloat
                     , isProp role fileDialog    --> doCenterFloat
                     , isDialog                  --> doCenterFloat
                     , isFullscreen              --> (doF W.focusDown <+> doFullFloat)
                     , transience'
                     ]

--------------
--{-# Main #-}
--------------
myConfig = defaultConfig { modMask            = xMod
                              , terminal           = show URxvtc
                              , focusFollowsMouse  = xMouseFocus
                              , borderWidth        = xBorderWidth
                              , normalBorderColor  = xBorderColor
                              , focusedBorderColor = xBorderFocus
                              , workspaces         = xWorkspaces
                              , layoutHook         = xLayout
                              , manageHook         = xManage <+> manageDocks <+> fullscreenManageHook
                     --         , startupHook        = xStartupHook
                              , handleEventHook    = fullscreenEventHook
                              } 
                              `additionalKeys` xKeys
                              `removeKeys` xNoKeys

----------
-- Main
----------
main = xmonad myConfig
