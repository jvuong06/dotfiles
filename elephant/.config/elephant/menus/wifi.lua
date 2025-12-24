Name = "wifi"
NamePretty = "Wi-Fi Networks"
Icon = "network-wireless"
Cache = false
HideFromProviderlist = false
FixedOrder = true -- Enforce manual sorting
Parent = "settings"

function GetEntries()
    local entries = {}
    local known = {}
    -- 1. Cache known networks
    local handle_known = io.popen("nmcli -t -f NAME connection show")
    if handle_known then
        for line in handle_known:lines() do known[line] = true end
        handle_known:close()
    end

    -- 2. Scan and parse
    local handle = io.popen("nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY dev wifi list 2>/dev/null")
    if handle then
        local seen = {}
        for line in handle:lines() do
            local in_use, ssid, signal, security = line:match("^([^:]*):([^:]+):(%d+):(.*)$")
            
            if ssid and ssid ~= "" and not seen[ssid] then
                seen[ssid] = true
                local signal_n = tonumber(signal)
                
                -- Determine Icon
                local icon = "network-wireless-signal-weak-symbolic"
                if signal_n > 75 then icon = "network-wireless-signal-excellent-symbolic"
                elseif signal_n > 50 then icon = "network-wireless-signal-good-symbolic"
                elseif signal_n > 25 then icon = "network-wireless-signal-ok-symbolic"
                end

                local entry = {
                    Text = ssid,
                    Subtext = "Signal: " .. signal .. "%",
                    Icon = icon,
                    Value = ssid,
                    SubMenu = "wifi_opts", -- Navigate to options
                    -- Internal fields for sorting
                    _is_connected = (in_use == "*"),
                    _is_known = known[ssid] or false,
                    _signal = signal_n
                }

                if entry._is_connected then
                    entry.Icon = "network-wireless-connected-symbolic"
                    entry.Subtext = "Connected  |  " .. entry.Subtext
                elseif entry._is_known then
                    entry.Subtext = "Known  |  " .. entry.Subtext
                end

                table.insert(entries, entry)
            end
        end
        handle:close()
    end

    -- 3. Manually Sort: Connected > Known > Signal Strength
    table.sort(entries, function(a, b)
        if a._is_connected ~= b._is_connected then return a._is_connected end
        if a._is_known ~= b._is_known then return a._is_known end
        return a._signal > b._signal
    end)

    return entries
end

