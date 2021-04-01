-- these settings cause abuot a thousand "errors", really warnings {-# OPTIONS_GHC -Wall -Werror -fno-warn-missing-signatures #-}

--{- imports
--{- xmonad & others
import           XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
--}
--{- util
import XMonad.Util.EZConfig  (additionalKeysP, removeKeysP, checkKeymap, mkKeymap)
import XMonad.Util.SpawnOnce ( spawnOnce )
import XMonad.Util.NamedWindows
import XMonad.Util.Run
import qualified XMonad.StackSet as U
--}
--{- actions
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS       ( prevWS, nextWS)
import XMonad.Actions.CycleRecentWS ( cycleRecentWS )
import XMonad.Actions.GridSelect
--}
--{- hooks
import XMonad.Hooks.EwmhDesktops ( ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks  ( avoidStruts, docks, ToggleStruts(..))
import XMonad.Hooks.DynamicLog   ( statusBar, ppCurrent, ppHidden, ppTitle, ppOrder, ppSep, xmobarPP, xmobarColor, wrap)
import XMonad.Hooks.SetWMName    ( setWMName )
import XMonad.Hooks.UrgencyHook
--}
--{- layouts
import XMonad.Layout.NoBorders ( smartBorders )
import XMonad.Layout.Renamed   ( Rename(..), renamed)
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Grid
--}
--{- prompt
import XMonad.Prompt
import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt.AppendFile
import XMonad.Prompt.Input
import XMonad.Prompt.Man
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.Theme
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Prompt.XMonad
--}
--}
--{- my programs
myTerminal :: String
myTerminal = "st"
--}
--{- xmobar
myXmobarPP =
 xmobarPP
 { ppCurrent = xmobarColor (mfg!!0) "" -- currently focused workspace
 , ppHidden  = xmobarColor (mfg!!1) "" -- currently nonempty but unfocusued workspace
 , ppTitle   = xmobarColor (mfg!!0) "" -- title of currently focused program
 , ppSep     = " | "
 , ppOrder   = \(ws:l:t:ex) -> [ws, l] ++ ex ++ [t]
 }
--}
--{- colors
mfg = ["#EEFFFF","#6C6C6C"]
--}
--{- notifications
-- data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

-- instance UrgencyHook LibNotifyHook where
    -- urgencyHook LibNotifyUrgencyHook w = do
    -- name     <- getName w
    -- Just idx <- fmap (U.findTag w) $ gets windowset
    -- safeSpawn "notify-send" [show name, "workspace " ++ idx]
--}
--{-
myPromptConfig :: XPConfig
myPromptConfig = def
                 { position = CenteredAt { xpCenterY = 0.0222222222222222222222222222222222222222222222, xpWidth = 0.9895833333333 }
                 , promptBorderWidth = 1
                 , alwaysHighlight = True
                 , height = 28
                 , historySize = 256
                 , font = "xft:Iosevka:pixelsize=14:antialiase=true:autohinting=true:Regular"
                 , bgColor = "#11100f"
                 , fgColor = "#EEFFFF"
                 , bgHLight = "#EEFFFF"
                 , fgHLight = "#11100f"
                 , borderColor = "#EEFFFF"
                 , autoComplete = Nothing
                 , showCompletionOnTab = False
                 , defaultPrompter = id
                 , sorter = const id 
                 , maxComplRows = Just 10
                 , promptKeymap = defaultXPKeymap
                 , historyFilter = id
                 , defaultText = []
                 }

--}
--{- workspaces
myWorkspaces :: [String]
myWorkspaces =
 [ "I"
 , "II"
 , "III"
 , "IV"
 , "V"
 , "VI"
 , "VII"
 , "VIII"
 , "IX"
 , "X"
 ]
--}
--{- grid
myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x11,0x10,0x0f) -- lowest inactive bg
                  (0x11,0x10,0x0f) -- highest inactive bg
                  (0xee,0xff,0xff)  -- active bg
                  (0xee,0xff,0xff) -- inactive fg
                  (0x11,0x10,0x0f) -- active fg

myGridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 30
    , gs_cellwidth    = 200
    , gs_cellpadding  = 8
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = "xft:Iosevka:pixelsize=14:antialias=true:autohinting=true:Regular"
    }
--}
--{- hooks
--{- startuphook
myStartupHook :: X ()
myStartupHook = do
  setWMName "xmonad"
  spawnOnce "feh --bg-fill ~/.wallpaper.jpg"
--}
--{- layouthook
myLayoutHook = smartBorders . avoidStruts $ myMainLayout
myMainLayout = tiled
  where
    tiled = spacing 10 $ Grid ||| Tall 1 (3/100) (1/2) ||| spiral (6/7) ||| Full
--}
--{- handleeventhook
myHandleEventHook = fullscreenEventHook <+> handleEventHook def
--}
--}
--{- keybinds
myKeys = 
 [ ("M-<Return>"    , spawn myTerminal)
 , ("M-t"           , withFocused $ windows . \w -> W.float w $ mfloatMolds'!!0)
 , ("M-S-c"         , kill1)
 , ("M-c"           , kill)
 , ("M-<space>"     , sendMessage NextLayout)
 , ("M-S-<space>"   , sendMessage ToggleStruts)
 , ("M-s"           , goToSelected $ myGridConfig myColorizer)
 , ("M-S-s"         , bringSelected $ myGridConfig myColorizer)
 , ("M-n"           , refresh)
 , ("M-j"           , windows W.focusDown)
 , ("M-k"           , windows W.focusUp)
 , ("M-S-j"         , windows W.swapDown)
 , ("M-S-k"         , windows W.swapUp)
 , ("M-m"           , windows W.focusMaster)
 , ("M-S-<Return>"  , windows W.swapMaster)
 , ("M-h"           , sendMessage Shrink)
 , ("M-l"           , sendMessage Expand)
 , ("M-S-t"         , withFocused $ windows . W.sink)
 , ("M-S-l"         , spawn "slock")
 -- , ("M-p"           , spawn $ "dmenu_run -fn \"Iosevka\" -nb \"#11100F\" -nf \"#d2d0ce\" -sf \"#11100F\" -sb \"" ++ mfg!!0 ++"\"")
 -- , ("M-S-e"         , AL.launchApp myPromptConfig)
 , ("M-S-x"         , shellPrompt myPromptConfig)
 , ("M-p"           , shellPrompt myPromptConfig)
 , ("M-x"           , manPrompt myPromptConfig)
 , ("M-S-p"         , xmonadPrompt myPromptConfig)
 -- , ("M-S-<Up>"      , spawn "playerctl play")
 -- , ("M-S-<Down>"    , spawn "playerctl pause")
 -- , ("M-S-<Right>"   , spawn "playerctl next")
 -- , ("M-S-<Left>"    , spawn "playerctl previous")
 -- , ("M-C-<Right>"   , spawn "amixer sset Master 5%+")
 -- , ("M-C-<Left>"    , spawn "amixer sset Master 5%-")
 -- , ("M-C-<Down>"    , spawn "amixer sset Master mute")
 -- , ("M-C-<Up>"      , spawn "amixer sset Master unmute")
 , ("M-o"           , spawn "flameshot gui")
 , ("M-,"           , prevWS)
 , ("M-."           , nextWS)
 , ("M-<Tab>"       , cycleRecentWS [xK_Tab] xK_Tab xK_Tab)
 ]
 -- use <> instead of ++, looks cooler, and is more general, so better for
 -- learning Haskell w/
 <> concat [
  [ (concat ["M-",m, show k], withNthWorkspace f i) | (m, f) <-
   [ ("",     W.greedyView ) -- view workspace
   , ("M1-",  W.view       ) -- view workspace #2
   , ("S-",   W.shift      ) -- shift to workspace
   , ("C-S-", copy         ) -- copy to workspace
   ]
  ]
  | (i, k) <- (zip [9, 0 .. 8] [0..9])
 ]
    where --{-
        b = W.RationalRect
        -- make x and y equal to padding, where the window always left and top aligns
        l = \x y w h -> b x y (min (w-x) $ 1-x-x) (min (h-y) $ 1-y-y)
        -- same as l, but with bottom right anchored x & y
        r = \x y w h -> b (max x $ 1-w) (max y $ 1-h) (max 0.01 (min (w-x) $ 1-x-x)) $ max 0.01 (min (h-y) $ 1-y-y)
        mfloatMolds' =
         [ b 0.05 0.05 0.5  0.5 -- full  mold
         , l 0.05 0.05 0.5  1    -- left  mold
         , r 0.05 0.05 0.5  1    -- right mold
         , b 0    0    1    1    -- fullscreen float
         , r 0.05 0.05 0.5  0.5  -- popup player float
         , r 0.05 0.05 0.25 0.25 -- popup player float #2
         , l 0.05 0.05 0.5  0.5  -- popup player float #3
         , l 0.05 0.05 0.25 0.25 -- popup player float #4
         ]
--}
--}
--{- main
main :: IO ()
main =
 xmonad
 .   ewmh
 .   docks
 =<< statusBar "xmobar" myXmobarPP (\x -> (XMonad.modMask x, xK_r)) myConfig
--}
--{- config
myConfig = def
 { terminal           = myTerminal
 , focusedBorderColor = mfg!!0
 , normalBorderColor  = mfg!!1
 , modMask            = mod4Mask
 , borderWidth        = 2
 , focusFollowsMouse  = False
 , handleEventHook    = myHandleEventHook
 , layoutHook         = myLayoutHook
 , startupHook        = myStartupHook
 , workspaces         = myWorkspaces
 -- , keys = myKeys
 }
 `removeKeysP` [ a | (a,b) <- myKeys]
 `additionalKeysP` myKeys
--}

