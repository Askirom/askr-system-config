
#!/bin/bash

# Check if Alacritty is running
if pgrep -x "alacritty" > /dev/null; then
    # Use wmctrl to focus the Alacritty window
    wmctrl -xa alacritty || wmctrl -a Alacritty
else
    # Launch Alacritty
    alacritty &
fi
