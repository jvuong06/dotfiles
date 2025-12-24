Name = "wifi_opts"
NamePretty = "Network Options"
Icon = "preferences-system-network"
Cache = false
HideFromProviderlist = true
Parent = "wifi"
FixedOrder = true

function GetEntries()
    local ssid = lastMenuValue("wifi")
    if ssid == "" then return {{ Text = "Error: No network selected", Icon = "dialog-error" }} end

    -- Check status
    local is_connected = false
    local handle_active = io.popen("nmcli -t -f NAME connection show --active")
    if handle_active then
        for line in handle_active:lines() do
            if line == ssid then is_connected = true end
        end
        handle_active:close()
    end

    local is_known = false
    local handle_known = io.popen("nmcli -t -f NAME connection show")
    if handle_known then
        for line in handle_known:lines() do
            if line == ssid then is_known = true end
        end
        handle_known:close()
    end

    local entries = {}

    -- LOGIC: Toggle Connect/Disconnect
    if is_connected then
        table.insert(entries, {
            Text = "Disconnect",
            Subtext = "Disconnect from " .. ssid,
            Icon = "network-wireless-offline-symbolic",
            Actions = { open = "lua:Disconnect" }
        })
    else
        -- Logic for Connect
        local connect_entry = {
            Text = "Connect",
            Icon = "network-wireless-aquiring-symbolic",
            Value = ssid
        }

        if is_known then
            connect_entry.Subtext = "Connect to " .. ssid
            connect_entry.Actions = { open = "lua:ConnectKnown" }
        else
            -- Route to Password Menu
            connect_entry.Subtext = "Connect to " .. ssid .. " (Requires Password)"
            connect_entry.SubMenu = "wifi_pass"
        end
        
        table.insert(entries, connect_entry)
    end

    -- Always show Forget if applicable
    if is_known or is_connected then
        table.insert(entries, {
            Text = "Forget",
            Subtext = "Delete saved profile",
            Icon = "edit-delete-symbolic",
            Value = ssid,
            Actions = { open = "lua:Forget" }
        })
    end

    return entries
end

-- ACTIONS (Async) --

function ConnectKnown(ssid)
    os.execute("notify-send 'Elephant' 'Connecting to " .. ssid .. "...'")
    os.execute("nmcli connection up id '" .. ssid .. "' &")
    -- The window stays open. You might want to refresh the view manually or let the user go back.
end

function Disconnect()
    os.execute("notify-send 'Elephant' 'Disconnecting...'")
    os.execute("nmcli device disconnect wlan0 &")
end

function Forget(ssid)
    os.execute("notify-send 'Elephant' 'Forgetting " .. ssid .. "'")
    os.execute("nmcli connection delete '" .. ssid .. "' &")
end
