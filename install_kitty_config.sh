#!/usr/bin/env bash

mkdir $HOME/.config/kitty

echo "
background_opacity 0.95
font_size 12

include redsayer.conf



# BEGIN_KITTY_FONTS
font_family      family="JetBrainsMono Nerd Font"
bold_font        auto
italic_font      auto
bold_italic_font auto
# END_KITTY_FONTS
" > $HOME/.config/kitty/kitty.conf


echo "
# Color theme: Redsayer 
background #140000
foreground #b0b0b0
cursor #868686
selection_background #0000ff
selection_foreground #b0b0b0
url_color #7ad0c6

# black
#color0 #000000
color0 #b5b57d
color8 #4c3d3d

# red
color1 #c97f6f
color9 #ff0000

# green
color2 #44b340
color10 #8cde94

# yellow
color3 #ff8800
color11 #ff8800

# blue
color4 #00aeff
color12 #c1d1e3

# magenta
color5 #c97f6f
color13 #c97f6f

# cyan
color6 #7ad0c6
color14 #7ad0c6

# white
color7 #b0b0b0
color15 #ffffff
" > $HOME/.config/kitty/redsayer.conf
