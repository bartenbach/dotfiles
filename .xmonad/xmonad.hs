--------------------------------------------------------------------------------
--                            ~/.xmonad/xmonad.hs                             --
--                                  by proxa                                  --
--------------------------------------------------------------------------------

---------------
{-# Imports #-}
---------------
import XMonad hiding ((|||))

import XMonad.Layout.Tabbed
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace (onWorkspace)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName

import XMonad.Util.EZConfig (additionalKeys, removeKeys)

import System.Exit (exitWith, ExitCode(ExitSuccess))
import qualified XMonad.StackSet as W

-----------------
{-# Mod keys #-}
-----------------
xMod         = mod1Mask
xShiftMod    = xMod .|. shiftMask
xKillMask    = xMod .|. controlMask

------------------
{-# Workspaces #-}
------------------
xWorkspaces =  "1":"2":"3":"4":[]

-------------
{-# Theme #-}
-------------
xTheme = defaultTheme { activeColor         = "#000"
                      , activeBorderColor   = "#FF0000"
                      , activeTextColor     = "#FF0000"
                      , inactiveColor       = "#000"
                      , inactiveTextColor   = "#000"
                      , inactiveBorderColor = "#000"
                      , urgentColor         = "#000"
                      , urgentTextColor     = "#63B8FF"
                      , urgentBorderColor   = "#63B8FF"
                      , decoHeight          = 12
                      , fontName            = "-windows-proggyoptis-medium-r-normal--9-80-96-96-c-60-iso8859-1"
                      }

---------------
{-# Borders #-}
---------------
xBorderWidth = 2
xBorderColor = "#000000"
xBorderFocus = "#FF0000"

-------------
{-# Mouse #-}
-------------
xMouseFocus :: Bool
xMouseFocus = False


--------------------
{-# Applications #-}
--------------------
data ShellCommands = URxvtc
                   | DMenu
                   | XMonadRecompile

instance Show ShellCommands where
  show URxvtc          = "urxvtc"
  show DMenu           = "dmenu_run -p dmenu -fn -xos4-terminus-medium-r-normal--0-0-72-72-c-0-iso8859-1 -nb black -nf gray -sb white -sf black -i"
  show XMonadRecompile = "xmonad --recompile; xmonad --restart"

launch = spawn . show

--------------------
{-# Key Bindings #-}
--------------------
xKeys = [ ((m .|. xMod, k), windows $ f i)
             | (i, k) <- zip (xWorkspaces) [xK_1 .. xK_5]
             , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
        ++
        [ ((m .|. xMod, key), screenWorkspace sc >>= flip whenJust (windows . f))
             | (key, sc) <- zip [xK_e, xK_w] [0..]
             , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
        ++
        [ ((xMod,      xK_c),         kill)
        , ((xMod,      xK_Return),    launch URxvtc)
        , ((xMod,      xK_r),         launch DMenu)
        , ((xMod,      xK_q),         launch XMonadRecompile)
        , ((xMod,      xK_space),     sendMessage NextLayout)
        , ((xMod,      xK_j),         sendMessage Shrink)
        , ((xMod,      xK_k),         sendMessage Expand)
        , ((xMod,      xK_h),         windows W.focusUp)
        , ((xMod,      xK_l),         windows W.focusDown)
        , ((xShiftMod, xK_h),         windows W.swapUp)
        , ((xShiftMod, xK_l),         windows W.swapDown)
        , ((xKillMask, xK_BackSpace), io (exitWith ExitSuccess))]

xNoKeys = [ (xMod, xK_comma)
          , (xMod, xK_ampersand)
          , (xMod, xK_dollar)
          , (xMod, xK_t)]

-------------------
{-# Layout Hook #-}
-------------------
xLayout = tab ||| tile ||| Grid ||| Full
  where
    tab     = tabbed shrinkText xTheme
    tile    = Tall nmaster delta ratio
    grid    = GridRatio (4/4)
    nmaster = 1
    ratio   = 1/2
    delta   = 1/100

-------------------
{-# Manage Hook #-}
-------------------
fileDialog = "GtkFileChooserDialog"
popUp      = "pop-up"
role       = "WM_WINDOW_ROLE"

isProp x y = stringProperty x =? y
isClass x  = className =? x

xManage = composeAll [ isClass "Gimp"            --> doFloat
                     , isClass "desktop_window"  --> doIgnore
                     , isClass "kdesktop"        --> doIgnore
                     , isClass "xmessage"        --> doCenterFloat
                     , isProp role popUp         --> doCenterFloat
                     , isProp role fileDialog    --> doCenterFloat
                     , isDialog                  --> doCenterFloat
                     , isFullscreen              --> doFullFloat
                     , transience'
                     ]

------------
{-# Main #-}
------------
main = xmonad xConfig

xConfig = defaultConfig { modMask            = xMod
                        , terminal           = show URxvtc
                        , focusFollowsMouse  = xMouseFocus
                        , borderWidth        = xBorderWidth
                        , normalBorderColor  = xBorderColor
                        , focusedBorderColor = xBorderFocus
                        , workspaces         = xWorkspaces
                        , handleEventHook    = fullscreenEventHook
                        , layoutHook         = xLayout
                        , manageHook         = xManage
                        , startupHook        = setWMName "L3GD"
                        }
                        `additionalKeys` xKeys
                        `removeKeys` xNoKeys
