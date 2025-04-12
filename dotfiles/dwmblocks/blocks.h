//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
    /*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {" ", "bash -c 'if [ -f /tmp/dwm-nmaster ]; then cat /tmp/dwm-nmaster; else echo \"1\"; fi'", 0, 11},
    {"󰁹  ", "echo \"$(cat /sys/class/power_supply/BAT1/capacity)%\"", 15, 0},
    {"  " , "curl -s 'wttr.in/Brisbane?format=%t'", 300, 0},
    {"  " , "date '+%d.%m'", 60, 0},
    {"  ", "date '+%H:%M'", 5, 0},
    {"", "volume=$(pamixer --get-volume); [ \"$(pamixer --get-mute)\" = \"true\" ] && echo \"  $volume  \" || echo \"  $volume  \"  ", 0, 10},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = "  ┇  ";
static unsigned int delimLen = 7;
