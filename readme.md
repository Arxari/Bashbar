
### <img src="https://github.com/user-attachments/assets/e1c4c54b-fb8f-4dca-ad0d-21e65107bb4c" height="200"> Bashbar
The most easily hackable status bar for Linux (probably)

A simple and straight to the point status bar for tiling window managers (notably Hyprland)

The point of Bashbar is to have a unique and easy to use status bar that anyone can configure with ease due to it's use of the Shell programming language

#### How to install
- git clone the repo
- put bashbar.conf into `~/.config/bashbar/bashbar.conf`
- make bashbar.sh and launchbashbar.sh executable
- add these lines to your hyprland.conf file

```
# Bashbar
windowrulev2 = float, class:kitty, title:^(bashbar)$
windowrulev2 = size 2560 40, class:kitty, title:^(bashbar)$    # Set fixed height (40) and full width (2560)
windowrulev2 = move 0 0, class:kitty, title:^(bashbar)$        # Move to top of the screen
windowrulev2 = pin, class:kitty, title:^(bashbar)$             # Keep the window on top
windowrulev2 = nofocus, class:kitty, title:^(bashbar)$         # Don't focus the window
windowrule = rounding 0, title:^(bashbar)(.*)$                 # Stop the bar from being rounded
```
- you can now starting using bashbar by executing launchbashbar.sh in your terminal

#### Configuration
Bashbar uses `bashbar.sh` for writing functions, functions are what is displayed on Bashbar and
`bashbar.conf` is used for defining which functions should be ran and the layout of the bar

##### Writing your own functions
Bashbar makes making custom functions easy thanks to the Shell programming language, to create a new function simply go to bashbar.sh and start defining the function with
```
function_name() {
```

under that you can write your own shell script which Bashbar will run
###### in the future Bashbar will make it easy to run pre-existing Shell scripts

below is an example script which checks for and displays disk usage
```
    df -h | awk '/^\/dev/{print $3"/"$2}'
```
you end a function with
```
}
```

so the complete function would look something like this
```
disk_usage() {
    df -h | awk '/^\/dev/{print $3"/"$2}'
}
```
to display the function in Bashbar, go into `bashbar.conf` and enable it by adding it into the layour format, like so

```
layout_format= disk_usage
```

**Congratilations, you have now created your first custom function!**
