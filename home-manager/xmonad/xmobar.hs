 Config {
  font =
  "xft:Iosevka:pixelsize=14:antialiase=true:autohinting=true:Regular"
  , position = Static { xpos = 10 , ypos = 10, width = 1900, height = 28 }
  , bgColor = "#11100f"
  , borderColor = "#EEFFFF"
  , border = FullB
  , fgColor = "#d2d0ce"
  , lowerOnStart = False
  , pickBroadest = False
  , persistent = True
  , hideOnStart = False
  , iconRoot = "."
  , allDesktops = True
  , overrideRedirect = True
  , commands =
    [ Run Date "%r | %a, %b %d %Y" "date" 1
    -- , Run Weather "EPGD" ["-t", "Gdańsk: <fn=2><skyConditionS></fn> <tempC>° <windKmh>Km/h "]  36
    , Run Com "/etc/nixos/home-manager/xmonad/weather.sh" [] "weather" 10
    , Run StdinReader
    ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = " %StdinReader% }{ %weather% | %date% "
  }
