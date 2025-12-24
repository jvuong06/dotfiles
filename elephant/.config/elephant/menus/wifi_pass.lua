Name = "wifi_pass"
NamePretty = "Enter Password"
Icon = "dialog-password"
Cache = false
HideFromProviderlist = true
Parent = "wifi_opts"
AsyncActions = {"open"}

function GetEntries(query)
    local ssid = lastMenuValue("wifi_opts")
    local entries = {}

    if query == "" then
        table.insert(entries, {
            Text = "Type Password for " .. ssid,
            Subtext = "Enter password in the search bar above...",
            Icon = "dialog-password",
            Score = 100
        })
    else
        table.insert(entries, {
            Text = "Connect to " .. ssid,
            Subtext = "Password: " .. query, -- Visual feedback
            Icon = "network-wireless-encrypted-symbolic",
            Value = ssid,
            Actions = { open = "lua:ConnectWithPass" },
            Score = 100
        })
    end

    return entries
end

function ConnectWithPass(ssid, args, query)
    if query == "" then return end
    
    os.execute("notify-send 'Elephant' 'Connecting to " .. ssid .. "...'")
    local cmd = string.format("nmcli device wifi connect '%s' password '%s' &", ssid, query)
    os.execute(cmd)
end
