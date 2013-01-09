--------------------------------------------------------------------------------
--                            ~/.xmonad/xmonad.hs                             --
--                                  by proxa                                  --
--------------------------------------------------------------------------------

---------------
{-# Imports #-}
---------------
-- Main
import XMonad hiding ((|||))

-- Layout
import XMonad.Layout.Tabbed
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace (onWorkspace)

-- Hooks
import XMonad.Hooks.ManageHelpers

-- Util
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Themes

-- Exit
import System.Exit (exitWith, ExitCode(ExitSuccess))

-- StackSet
import qualified XMonad.StackSet as W

-----------------
{-# Mod keys #-}
-----------------
myMod        = mod1Mask
myShiftMod   = myMod .|. shiftMask
killXMask    = myMod .|. controlMask

------------------
{-# Workspaces #-}
------------------
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

-------------
{-# Theme #-}
-------------
myTheme = defaultTheme { activeColor         = "#000000"
                       , activeBorderColor   = "#000000"
                       , activeTextColor     = "#000000"
                       , inactiveBorderColor = "#000000"
                       , decoHeight          = 16
                       }

---------------
{-# Borders #-}
---------------
myBorderWidth        = 3
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#ff0000"

-------------
{-# Mouse #-}
-------------
myFocusFollowsMouse  :: Bool
myFocusFollowsMouse  = False


--------------------
{-# Applications #-}
--------------------
data ShellCommands     = URxvtc
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
myKeys =
    [ ((myMod,       xK_c),               kill)
    , ((myMod,       xK_Return),          launch URxvtc)
    , ((myMod,       xK_p),               launch DMenu)
    , ((myMod,       xK_F12),             launch EjectCdrom)
    , ((myMod,       xK_q),               launch XMonadRecompile)
    , ((myMod,       xK_Print),           launch Screenshot)
    , ((myShiftMod,  xK_Print),           launch ScreenshotArea)
    , ((myMod,       xK_space),           sendMessage NextLayout)
    , ((myMod,       xK_h),               sendMessage Shrink)
    , ((myMod,       xK_l),               sendMessage Expand)
    , ((myMod,       xK_comma),           sendMessage (IncMasterN 1)) 
    , ((myMod,       xK_ampersand),       sendMessage (IncMasterN (-1)))
    , ((myMod,       xK_Up),              windows W.focusUp)
    , ((myMod,       xK_Down),            windows W.focusDown)
    , ((myMod,       xK_Left),            windows W.focusUp)
    , ((myMod,       xK_Right),           windows W.focusDown)
    , ((myMod,       xK_j),               windows W.focusUp)
    , ((myMod,       xK_semicolon),       windows W.focusDown)
    , ((myMod,       xK_k),               windows W.focusDown)
    , ((myMod,       xK_dollar),          windows W.swapMaster)
    , ((myShiftMod,  xK_semicolon),       windows W.swapUp) 
    , ((myShiftMod,  xK_j),               windows W.swapDown)
    , ((killXMask,   xK_BackSpace),       io (exitWith ExitSuccess)) 
    , ((myMod,       xK_t),               withFocused $ windows . W.sink)
    ]
    ++

    [((m .|. myMod, k), windows $ f i)
        | (i, k) <- zip (myWorkspaces) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    [((m .|. myMod, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-------------------
{-# Layout Hook #-}
-------------------
myLayout = tile ||| tabbed shrinkText myTheme ||| Grid ||| Full
  where
     tile    = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

-------------------
{-# Manage Hook #-}
-------------------
role = "WM_WINDOW_ROLE"

x_manageHook = composeAll
    [ className =? "Gimp"                                                                     --> doFloat
    , resource  =? "desktop_window"                                                           --> doIgnore
    , resource  =? "kdesktop"                                                                 --> doIgnore 
    , className =? "MPlayer"                                                                  --> doCenterFloat
    , className =? "feh"                                                                      --> doCenterFloat
    , className =? "nvidia-settings"                                                          --> doCenterFloat
    , className =? "Chromium" <&&> stringProperty "WM_WINDOW_ROLE" =? "pop-up"                --> doCenterFloat
    , className =? "Chromium" <&&> stringProperty "WM_WINDOW_ROLE" =? "GtkFileChooserDialog"  --> doCenterFloat
    , isDialog                                                                                --> doCenterFloat
    , isFullscreen                                                                            --> doFullFloat
    , transience'
    ]

------------
{-# Main #-}
------------
main = xmonad defaults

defaults = defaultConfig { modMask            = myMod
                         , terminal           = show URxvtc
                         , focusFollowsMouse  = myFocusFollowsMouse
                         , borderWidth        = myBorderWidth
                         , normalBorderColor  = myNormalBorderColor
                         , focusedBorderColor = myFocusedBorderColor
                         , workspaces         = myWorkspaces
                         , layoutHook         = myLayout
                         , manageHook         = x_manageHook
                         } `additionalKeys` myKeys
