--------------------------------------------------------------------------------
--                            ~/.xmonad/xmonad.hs                             --
--                                  by proxa                                  --
--------------------------------------------------------------------------------

---------------
{-# Imports #-}
---------------
import XMonad hiding ((|||))
import XMonad.Layout.Tabbed (tabbed, Theme(..), defaultTheme, shrinkText)
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog, doFullFloat, 
                                          doCenterFloat, transience')
import XMonad.Util.EZConfig (additionalKeys)
import System.Exit (exitWith, ExitCode(ExitSuccess))
import qualified XMonad.StackSet as W

-----------------
{-# Mod Keys #-}
-----------------
xMod      = mod1Mask
xShiftMod = xMod .|. shiftMask
xKillMask = xMod .|. controlMask
---------------
{-# Borders #-}
---------------
xBorderWidth = 10
xBorderColor = show Black
xBorderFocus = show Red

-------------
{-# Mouse #-}
-------------
xMouseFocus :: Bool
xMouseFocus = False

------------------
{-# Workspaces #-}
------------------
xWorkspaces = "1":"2":"3":"4":[]

-------------------------
{-# Color Definitions #-}
-------------------------
data XColor = Red
            | Black
            | Yellow

instance Show XColor where
    show Red    = "#FF0000"
    show Yellow = "#FFFF00"
    show Black  = "#000"

--------------------
{-# Applications #-}
--------------------
data ShellCommands = URxvtc
                   | Screenshot
                   | ScreenshotArea
                   | DMenu
                   | EjectCdrom
                   | XMonadRecompile

instance Show ShellCommands where
  show URxvtc          = "urxvtc"
  show Screenshot      = "scrot -q100 '%m-%d-%Y.png' -e 'mv $f ~/img/scrots'"
  show ScreenshotArea  = "scrot -q100 -s '%m-%d-%Y.png' -e 'mv $f ~/img/scrots'"
  show DMenu           = "dmenu_run"
  show EjectCdrom      = "eject -T /dev/sr0"
  show XMonadRecompile = "xmonad --recompile;xmonad --restart"

launch = spawn . show

-------------
{-# Theme #-}
-------------
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

--------------------
{-# Key Bindings #-}
--------------------
xKeys = [((m .|. xMod, k), windows $ f i) 
            | (i, k) <- zip (xWorkspaces) [xK_1 .. xK_5]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
        ++
        [((m .|. xMod, key), screenWorkspace sc >>= flip whenJust (windows . f)) 
            | (key, sc) <- zip [xK_e, xK_w] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
        ++
        [ ((xMod,      xK_c),         kill)
        , ((xMod,      xK_Return),    launch URxvtc)
        , ((xMod,      xK_p),         launch DMenu)
        , ((xMod,      xK_F12),       launch EjectCdrom)
        , ((xMod,      xK_q),         launch XMonadRecompile)
        , ((xMod,      xK_Print),     launch Screenshot)
        , ((xShiftMod, xK_Print),     launch ScreenshotArea)
        , ((xMod,      xK_space),     sendMessage NextLayout)
        , ((xMod,      xK_h),         sendMessage Shrink)
        , ((xMod,      xK_l),         sendMessage Expand)
        , ((xMod,      xK_comma),     sendMessage (IncMasterN 1))
        , ((xMod,      xK_ampersand), sendMessage (IncMasterN (-1)))
        , ((xMod,      xK_Up),        windows W.focusUp)
        , ((xMod,      xK_Down),      windows W.focusDown)
        , ((xMod,      xK_Left),      windows W.focusUp)
        , ((xMod,      xK_Right),     windows W.focusDown)
        , ((xMod,      xK_j),         windows W.focusUp)
        , ((xMod,      xK_semicolon), windows W.focusDown)
        , ((xMod,      xK_k),         windows W.focusDown)
        , ((xMod,      xK_dollar),    windows W.swapMaster)
        , ((xShiftMod, xK_semicolon), windows W.swapUp)
        , ((xShiftMod, xK_j),         windows W.swapDown)
        , ((xKillMask, xK_BackSpace), io (exitWith ExitSuccess))
        , ((xMod,      xK_t),         withFocused $ windows . W.sink)]

-------------------
{-# Layout Hook #-}
-------------------
xLayout = tile ||| tab ||| Grid ||| Full
  where
    tab     = tabbed shrinkText xTheme
    tile    = Tall nmaster delta ratio
    nmaster = 1
    delta   = 3/100
    ratio   = 1/2

-------------------
{-# Manage Hook #-}
-------------------
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
                     , isProp role popUp         --> doCenterFloat
                     , isProp role fileDialog    --> doCenterFloat
                     , isDialog                  --> doCenterFloat
                     , isFullscreen              --> doFullFloat
                     , transience'
                     ]

------------
{-# Main #-}
------------
main = xmonad $ defaultConfig { modMask            = xMod
                              , terminal           = show URxvtc
                              , focusFollowsMouse  = xMouseFocus
                              , borderWidth        = xBorderWidth
                              , normalBorderColor  = xBorderColor
                              , focusedBorderColor = xBorderFocus
                              , workspaces         = xWorkspaces
                              , layoutHook         = xLayout
                              , manageHook         = xManage
                              } 
                              `additionalKeys` xKeys
