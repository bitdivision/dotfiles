#!/bin/bash

#Start ncmpcpp (mpd client) on workspace 1 full-screen
#i3-msg workspace 2
#i3-msg exec "urxvt -e ncmpcpp"

#Start 2 instances of irssi on ws #3 split screen connecting to i3 and clojure
#i3-msg workspace 3
#i3-msg exec urxvt -e "irssi --connect=irc.twice-irc.de --nick=naminator"
#i3-msg exec urxvt -e "irssi --connect=irc.freenode.net --nick=naminator"
#Problem is that there is no way to split irssi vertically so we have to use seperate windows really. This means that we need a way to connect to different servers on startup solely using the terminal and not within irssi. There are ways to connect automatically to a channel when the --connect flag is used but this means only 1 channel per server per window. Also channels are hidden when connected to on startup.

i3-msg workspace 1

