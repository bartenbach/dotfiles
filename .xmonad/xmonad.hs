import XMonad

import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.NoBorders
import XMonad.Util.Themes

-- Themes: defaultTheme,smallClean,robertTheme,deiflTheme,oxymor00nTheme
-- Theme options - noBorders
customlayoutHook = noBorders (Full ||| tabbed shrinkText (theme deiflTheme) ||| Accordion)

main = xmonad $ defaultConfig
    { terminal = "urxvtc",
      layoutHook = customlayoutHook }
