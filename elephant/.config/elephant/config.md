# Elephant
A service providing various datasources which can be triggered to perform actions.

Run `elephant -h` to get an overview of the available commandline flags and actions.
## Elephant Configuration
`~/.config/elephant/elephant.toml`
#### ElephantConfig
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|auto_detect_launch_prefix|bool|true|automatically detects uwsm, app2unit or systemd-run|
|overload_local_env|bool|false|overloads the local env|
|ignored_providers|[]string|<empty>|providers to ignore|
|git_on_demand|bool|true|sets up git repositories on first query instead of on start|s
|before_load|[]common.Command||commands to run before starting to load the providers|
#### Command
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|must_succeed|bool|false|will try running this command until it completes successfully|
|command|string||command to execute|


## Provider Configuration
### Elephant Bluetooth

Simple bluetooth management. Connect/Disconnect. Pair/Remove. Trust/Untrust.

#### Requirements

- `bluetoothctl`


`~/.config/elephant/bluetooth.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|

### Elephant Desktop Applications

Run installed desktop applications.

#### Features

- history
- pin items
- alias items
- auto-detect `uwsm`/`app2unit`


`~/.config/elephant/desktopapplications.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|launch_prefix|string||overrides the default app2unit or uwsm prefix, if set.|
|locale|string||to override systems locale|
|action_min_score|int|20|min score for actions to be shown|
|show_actions|bool|false|include application actions, f.e. 'New Private Window' for Firefox|
|show_generic|bool|true|include generic info when show_actions is true|
|show_actions_without_query|bool|false|show application actions, if the search query is empty|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
|only_search_title|bool|false|ignore keywords, comments etc from desktop file when searching|
|icon_placeholder|string|applications-other|placeholder icon for apps without icon|
|aliases|map[string]string||setup aliases for applications. Matched aliases will always be placed on top of the list. Example: 'ffp' => '<identifier>'. Check elephant log output when activating an item to get its identifier.|
|blacklist|[]string|<empty>|blacklist desktop files from being parsed. Regexp.|
|window_integration|bool|false|will enable window integration, meaning focusing an open app instead of opening a new instance|
|ignore_pin_with_window|bool|true|will ignore pinned apps that have an opened window|
|window_integration_ignore_actions|bool|true|will ignore the window integration for actions|
|wm_integration|bool|false|Moves apps to the workspace where they were launched at automatically. Currently Niri only.|
|score_open_windows|bool|true|Apps that have open windows, get their score halved. Requires window_integration.|
|single_instance_apps|[]string|["discord"]|application IDs that don't ever spawn a new window. |

### Elephant Files

Find files/folders.

#### Features

- preview text/images/pdf
- open files, folders
- drag&drop files into other programs
- copy file/path
- support for localsend

#### Example `ignored_dirs`

```toml
ignored_dirs = ["/home/andrej/Documents/", "/home/andrej/Videos"]
```

#### Requirements

- `fd`


`~/.config/elephant/files.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|launch_prefix|string||overrides the default app2unit or uwsm prefix, if set.|
|ignored_dirs|[]string||ignore these directories. regexp based.|
|ignore_previews|[]main.IgnoredPreview||paths will not have a preview|
|ignore_watching|[]string||paths will not be watched|
|search_dirs|[]string|$HOME|directories to search for files|
|fd_flags|[]string|['--ignore-vcs', '--type,' ,'file', '--type,' 'directory']|flags for fd|
|watch_buffer|int|2000|time in millisecnds elephant will gather changed paths before processing them|
|watch_dirs|[]string|[]|watch these dirs, even if watch = false|
|watch|bool|true|watch indexed directories|
#### IgnoredPreview
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|path|string||path to ignore preview for|
|placeholder|string||text to display instead|


### Elephant Menus

Create custom menus.

#### Features

- seamless menus
- create submenus
- define multiple actions per entry
- dynamic menus with Lua

#### How to create a menu

Default location for menu definitions is `~/.config/elephant/menus/`. Simply place a file in there, see examples below.

#### Actions for submenus/dmenus

Submenus/Dmenus will automatically get an action `open`.

#### Examples

```toml
name = "other"
name_pretty = "Other"
icon = "applications-other"

[[entries]]
text = "Color Picker"
keywords = ["color", "picker", "hypr"]
actions = { "cp_use" = "wl-copy $(hyprpicker)" }
icon = "color-picker"

[[entries]]
icon = "zoom-in"
text = "Zoom Toggle"
actions = { "zoom_use" = "hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float) | if . > 1 then 1 else 1.5 end')" }

[[entries]]
text = "Volume"
async = "echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
icon = "audio-volume-high"

[entries.actions]
"volume_raise" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"
"volume_lower" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
"volume_mute" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0"
"volume_unmute" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1"
"volume_set" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ %VALUE%"

[[entries]]
keywords = ["disk", "drive", "space"]
text = "Disk"
actions = { "disk_copy" = "wl-copy '%VALUE%'" }
async = """echo $(df -h / | tail -1 | awk '{print "Used: " $3 " - Available: " $4 " - Total: " $2}')"""
icon = "drive-harddisk"

[[entries]]
text = "Mic"
async = "echo $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)"
icon = "audio-input-microphone"
actions = { "mic_set" = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ %VALUE%" }

[[entries]]
text = "System"
async = """echo $(echo "Memory: $(free -h | awk '/^Mem:/ {printf "%s/%s", $3, $2}') | CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{printf "%.1f%%", 100 - $8}')")"""
icon = "computer"

[[entries]]
text = "Today"
keywords = ["date", "today", "calendar"]
async = """echo $(date "+%H:%M - %d.%m. %A - KW %V")"""
icon = "clock"
actions = { "open_cal" = "xdg-open https://calendar.google.com" }

[[entries]]
text = "uuctl"
keywords = ["uuctl"]
icon = "applications-system"
submenu = "dmenu:uuctl"
```

```toml
name = "screenshots"
name_pretty = "Screenshots"
icon = "camera-photo"

[[entries]]
text = "View"
actions = { "view" = "vimiv ~/Pictures/" }

[[entries]]
text = "Annotate"
actions = { "annotate" = "wl-paste | satty -f -" }

[[entries]]
text = "Toggle Record"
actions = { "record" = "record" }

[[entries]]
text = "OCR"
keywords = ["ocr", "text recognition", "OCR"]
actions = { "ocr" = "wayfreeze --hide-cursor --after-freeze-cmd 'grim -g \"$(slurp)\" - | tesseract stdin stdout -l deu+eng | wl-copy; killall wayfreeze'" }

[[entries]]
text = "Screenshot Region"
actions = { "region" = "wayfreeze --hide-cursor --after-freeze-cmd 'IMG=~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && grim -g \"$(slurp)\" $IMG && wl-copy < $IMG; killall wayfreeze'" }

[[entries]]
text = "Screenshot Window"
actions = { "window" = "wayfreeze --after-freeze-cmd 'IMG=~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && grim $IMG && wl-copy < $IMG; killall wayfreeze'" }

[[entries]]
text = "other menu"
submenu = "other"
```

```toml
name = "bookmarks"
name_pretty = "Bookmarks"
icon = "bookmark"
action = "xdg-open %VALUE%"

[[entries]]
text = "Walker"
value = "https://github.com/abenz1267/walker"

[[entries]]
text = "Elephant"
value = "https://github.com/abenz1267/elephant"

[[entries]]
text = "Drive"
value = "https://drive.google.com"

[[entries]]
text = "Prime"
value = "https://www.amazon.de/gp/video/storefront/"
```

#### Lua Example

By default, the Lua script will be called on every empty query. If you don't want this behaviour, but instead want to cache the query once, you can set `Cache=true` in the menu's config.

Following global functions will be set:

- `lastMenuValue(<menuname>)` => gets the last used value of a menu
- `state()` => retrieves the state for this menu (string array/table)
- `setState(state)` => sets the state for this menu (string array/table)
- `jsonEncode` => encodes to json
- `jsonDecodes` => decodes from json

```lua
Name = "luatest"
NamePretty = "Lua Test"
Icon = "applications-other"
Cache = true
Action = "notify-send %VALUE%"
HideFromProviderlist = false
Description = "lua test menu"
SearchName = true

function GetEntries()
    local entries = {}
    local wallpaper_dir = "/home/andrej/Documents/ArchInstall/wallpapers"

    local handle = io.popen("find '" ..
        wallpaper_dir ..
        "' -maxdepth 1 -type f -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.gif' -o -name '*.bmp' -o -name '*.webp' 2>/dev/null")
    if handle then
        for line in handle:lines() do
            local filename = line:match("([^/]+)$")
            if filename then
                table.insert(entries, {
                    Text = filename,
                    Subtext = "wallpaper",
                    Value = line,
                    Actions = {
                        up = "notify-send up",
                        down = "notify-send down",
                    },
                    -- Preview = line,
                    -- PreviewType = "file",
                    -- Icon = line
                })
            end
        end
        handle:close()
    end

    return entries
end
```

You can call Lua functions as actions as well:

```Lua
Actions = {
    test = "lua:Test",
}

function Test(value, args, query)
    os.execute("notify-send '" .. value .. "'")
    os.execute("notify-send '" .. args .. "'")
    os.execute("notify-send '" .. query .. "'")
end
```


`~/.config/elephant/menus.toml`
#### MenuConfig
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|paths|[]string||additional paths to check for menu definitions.|

`~/.config/elephant/menus.toml`
#### Menu
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|name|string||name of the menu|
|name_pretty|string||prettier name you usually want to display to the user.|
|description|string||used as a subtext|
|icon|string||default icon|
|action|string||default menu action to use|
|actions|map[string]string||global actions|
|async_actions|[]string||set which actions should update the item on the client asynchronously|
|search_name|bool|false|wether to search for the menu name as well when searching globally|
|cache|bool||will cache the results of the lua script on startup|
|refresh_on_change|[]string||will enable cache and auto-refresh the cache if there's file changes on the specified files/folders|
|entries|[]common.Entry||menu items|
|terminal|bool||execute action in terminal or not|
|keywords|[]string||searchable keywords|
|fixed_order|bool||don't sort entries alphabetically|
|history|bool||make use of history for sorting|
|history_when_empty|bool||consider history when query is empty|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|parent|string||defines the parent menu|
|submenu|string||defines submenu to trigger on activation|
||string|||
#### Entry
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|text|string||text for entry|
|async|string||if the text should be updated asynchronously based on the action|
|subtext|string||sub text for entry|
|value|string||value to be used for the action.|
|actions|map[string]string||actions items can use|
|terminal|bool||runs action in terminal if true|
|icon|string||icon for entry|
|submenu|string||submenu to open, if has prefix 'dmenu:' it'll launch that dmenu|
|preview|string||filepath for the preview|
|preview_type|string||type of the preview: text, file [default], command|
|keywords|[]string||searchable keywords|
|state|[]string||state of an item, can be used to f.e. mark it as current|


### Elephant Providerlist

Lists all installed providers and configured menus.


`~/.config/elephant/providerlist.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|hidden|[]string|<empty>|hidden providers|

