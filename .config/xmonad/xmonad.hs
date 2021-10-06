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
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier(ModifiedLayout)
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
xBorderWidth = 5

---------------
--{-# Mouse #-}
---------------
xMouseFocus :: Bool
xMouseFocus =  False

--------------------
--{-# Workspaces #-}
--------------------
xWorkspaces = ["1","2","3","4","5","6","7"]

---------------------------
--{-# Color Definitions #-}
---------------------------
data XColor = Red
            | Black
            | Yellow
            | Orange
            | DarkOrange
            | DarkSlateGray

instance Show XColor where
    show Red    = "#FF0000"
    show Black  = "#000"
    show Yellow = "#FFFF00"
    show Orange  = "#d69131"
    show DarkOrange  = "#68502e"
    show DarkSlateGray = "#2f4f4f"

----------------------
--{-# Applications #-}
----------------------
data ShellCommands = URxvtc
                   | DMenu
                   | XMonadRecompile
		   | ProxySwitcher

instance Show ShellCommands where
  show URxvtc          = "urxvt256c -e zsh"
  show DMenu           = "dmenu_run -b -fn \"terminus\" -i"
  show XMonadRecompile = "~/.xmonad/xmonad-x86_64-linux --recompile; ~/.xmonad/xmonad-x86_64-linux --restart"
  show ProxySwitcher   = "echo \"none\ncontractor\neast\" | dmenu -p 'Select proxy:' | ~/.functions/proxy"

launch = spawn . show

---------------
--{-# Theme #-}
---------------
xFont  = "terminus"

xTheme = defaultTheme { activeColor         = show Orange
                      , activeBorderColor   = show Orange
                      , activeTextColor     = show Black
                      , fontName            = show xFont
                      , inactiveColor       = show Black
                      , inactiveTextColor   = show Black
                      , inactiveBorderColor = show DarkOrange
                      , urgentColor         = show Yellow
                      , urgentTextColor     = show Black
                      , urgentBorderColor   = show DarkOrange
                      , decoHeight          = 12
                      }

----------------------
--{-# Key Bindings #-}
----------------------
xMod      = mod4Mask
yMod      = mod3Mask
xShiftMod = xMod .|. shiftMask
xKillMask = xMod .|. controlMask

xWorkspaceKeys = [((m .|. xMod, k), windows $ f i) 
                 | (i, k) <- zip xWorkspaces [xK_1 .. xK_5]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
                 ++
                 [((m .|. xMod, key), screenWorkspace sc >>= flip whenJust (windows . f))
                 | (key, sc) <- zip [xK_w, xK_e] [0..]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

xKeys = [ ((xMod,      xK_Escape),    kill)
        , ((xMod,      xK_Return),    Main.launch URxvtc)
        , ((xMod,      xK_r),         Main.launch DMenu)
        , ((xMod,      xK_c),         Main.launch XMonadRecompile)
        , ((xMod,      xK_p),         Main.launch ProxySwitcher)
        , ((xMod,      xK_b),         withFocused toggleBorder)
        , ((xMod,      xK_space),     sendMessage NextLayout)
        , ((yMod,      xK_l),         sendMessage Shrink)
        , ((yMod,      xK_h),         sendMessage Expand)
        , ((xMod,      xK_k),         windows W.focusUp)
        , ((xMod,      xK_j),         windows W.focusDown)
        , ((xMod,      xK_t),         sendMessage ToggleStruts)
        , ((xMod,      xK_s),         withFocused $ windows . W.sink)
        , ((xShiftMod, xK_j),         windows W.swapUp)
        , ((xShiftMod, xK_k),         windows W.swapDown)
        , ((xKillMask, xK_BackSpace), io (exitWith ExitSuccess))]

xNoKeys = [ (xMod, xK_comma)
          , (xMod, xK_ampersand)
          , (xMod, xK_dollar)  
          , (xMod, xK_p)
          ]

---------------------
--{-# Layout Hook #-}
----------------------
xSpacing = spacingRaw True (Border 15 15 15 15) True (Border 15 15 15 15) True
xLayout = tile ||| tab ||| Grid ||| fullscreenFull Full
  where
    tab     = tabbed shrinkText xTheme
    tile    = Tall nmaster delta ratio
    nmaster = 1
    delta   = 3/100
    ratio   = 1/2

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
                     , isClass "feh"             --> doFloat
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
myConfig = defaultConfig { modMask            = xMod
                         , terminal           = show URxvtc
                         , focusFollowsMouse  = xMouseFocus
                         , clickJustFocuses   = False
                         , borderWidth        = xBorderWidth
                         , normalBorderColor  = show DarkSlateGray
                         , focusedBorderColor = show DarkOrange
                         , workspaces         = xWorkspaces
                         , layoutHook         = avoidStruts $ xSpacing $ xLayout
                         , manageHook         = xManage <+> manageDocks <+> fullscreenManageHook
                         , startupHook        = xStartupHook
                         , handleEventHook    = fullscreenEventHook
                         } 
                         `removeKeys` xNoKeys
                         `additionalKeys` xKeys

----------
-- Main
----------
main = xmonad myConfig
