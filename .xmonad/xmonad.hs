{-# xmonad.hs - Haskell configuration file for XMonad #-}
import XMonad hiding ((|||))
import System.Exit (exitWith, ExitCode(ExitSuccess))
import XMonad.Layout.Tabbed
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.Layout.Grid
import XMonad.Util.Themes (deiflTheme, theme)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Util.EZConfig (additionalKeys)
import qualified XMonad.StackSet as W

myMod = mod1Mask
myShiftMod = myMod .|. shiftMask
killXMask = myMod .|. controlMask

myWorkspaces = ["1","2","3:media","4","5","6","7","8","9"]

myTheme = deiflTheme

myBorderWidth        = 2
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#ff0000"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False


data Applications = MyTerminal
                  | Screenshot
                  | ScreenshotArea
                  | MyMenu

instance Show Applications where
  show MyTerminal     = "urxvtc"
  show Screenshot     = "scrot -q100 '%m-%d-%Y.png' -e 'mv $f ~/img/scrots'"
  show ScreenshotArea = "scrot -q100 -s '%m-%d-%Y.png' -e 'mv $f ~/img/scrots'"
  show MyMenu         = "dmenu_run"


launch = spawn . show

myKeys =
    [ ((myMod, xK_Return),          launch MyTerminal)
    , ((myMod, xK_p),               launch MyMenu)
    , ((myMod, xK_c),               kill)
    , ((myMod, xK_space),           sendMessage NextLayout)
    , ((myMod, xK_Up),              windows W.focusUp)
    , ((myMod, xK_Down),            windows W.focusDown)
    , ((myMod, xK_Left),            windows W.focusUp)
    , ((myMod, xK_Right),           windows W.focusDown)
    , ((myMod, xK_j),               windows W.focusUp)
    , ((myMod, xK_semicolon),       windows W.focusDown)
    , ((myMod, xK_k),               windows W.focusDown)
    , ((myMod, xK_dollar),          windows W.swapMaster)
    , ((myMod, xK_h),               sendMessage Shrink)
    , ((myMod, xK_l),               sendMessage Expand)
    , ((myMod, xK_t),               withFocused $ windows . W.sink)
    , ((myMod, xK_comma),           sendMessage (IncMasterN 1)) 
    , ((myMod, xK_ampersand),       sendMessage (IncMasterN (-1)))
    , ((myMod, xK_F12),             spawn "eject -T /dev/sr0")
    , ((myMod, xK_q),               spawn "xmonad --recompile; xmonad --restart")
    , ((myShiftMod, xK_j),          windows W.swapDown)
    , ((myShiftMod, xK_semicolon),  windows W.swapUp) 
    , ((myShiftMod, xK_Print),      launch ScreenshotArea)
    , ((myMod, xK_Print),           launch Screenshot)
    , ((killXMask, xK_BackSpace),   io (exitWith ExitSuccess)) 
    ]
    ++

    [((m .|. myMod, k), windows $ f i)
        | (i, k) <- zip (myWorkspaces) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    [((m .|. myMod, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myLayout = tiled ||| tabbed shrinkText (theme myTheme) ||| Grid ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

-- Goofy Java workaround, seems fixed..
-- mediaLayout = noBorders $ Full
-- myLayout = onWorkspace "3:media" mediaLayout $ mainLayout

myManageHook = composeAll
    [ className =? "MPlayer"                     --> doFloat
    , className =? "Gimp"                        --> doFloat
--    More goofy Java shit.  Seems fixed.    
--    , className =? "jetbrains-idea-ce"           --> doFloat
--    , className =? "net-minecraft-LauncherFrame" --> doFloat
--    , className =? "sun-awt-X11-XFramePeer"      --> doFloat
    , resource  =? "desktop_window"              --> doIgnore
    , resource  =? "kdesktop"                    --> doIgnore 
    ]

main = xmonad defaults

defaults = defaultConfig {
        modMask = myMod,
        terminal = show MyTerminal,
        focusFollowsMouse = myFocusFollowsMouse,
        borderWidth = myBorderWidth,
        workspaces = myWorkspaces,
        startupHook = setWMName "LG3D",
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook = myLayout,
        manageHook = myManageHook
    } `additionalKeys` myKeys
