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
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Themes
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
xBorderWidth = 3
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
    ratio   = 1/2
    delta   = 3/100

-------------------
{-# Manage Hook #-}
-------------------
fileDialog = "GtkFileChooserDialog"
popUp      = "pop-up"
role       = "WM_WINDOW_ROLE"

isProp x y = stringProperty x =? y
isClass x  = className =? x

xManage = composeAll
    [ isClass "Gimp"                                 --> doFloat
    , isClass "desktop_window"                       --> doIgnore
    , isClass "kdesktop"                             --> doIgnore
    , isClass "xmessage"                             --> doCenterFloat 
    , isClass "MPlayer"                              --> doCenterFloat
  --  , isClass "feh"                                  --> doFloat
    , isClass "nvidia-settings"                      --> doCenterFloat
    , isClass "Chromium" <&&> isProp role popUp      --> doCenterFloat
    , isClass "Chromium" <&&> isProp role fileDialog --> doCenterFloat
    , isDialog                                       --> doCenterFloat
    , isFullscreen                                   --> doFullFloat
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
