import XMonad

import XMonad.Layout.Tabbed
import XMonad.Layout.Grid
--import XMonad.Layout.Mirror
import XMonad.Layout.NoBorders
import XMonad.Util.Themes

-- Themes: defaultTheme,smallClean,robertTheme,deiflTheme,oxymor00nTheme
-- Theme options - noBorders
customlayoutHook = Full ||| tabbed shrinkText (theme deiflTheme) ||| Grid ||| Tall 1 0.03 0.68

main = xmonad $ defaultConfig
    { terminal = "urxvtc",
      layoutHook = customlayoutHook }
