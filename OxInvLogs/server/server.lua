function sendDiscordWebhook2(description)
   local Webhook = "https://discord.com/api/webhooks/" -- Link webhooks

   local data = {embeds = {{title = "Inventoriaus logai", description = description, color = 229954}}}

   PerformHttpRequest(Webhook, function(statusCode)
   if statusCode ~= 204 then
      print("Error sending Discord webhook")
   end
   end, "POST", json.encode(data), {["Content-Type"] = "application/json"})
end

AddEventHandler('onResourceStop', function(resource)
if resource ~= GetCurrentResourceName() then return end
if GetResourceState('ox_inventory') ~= 'started' then return end
exports.ox_inventory:removeHooks()
end)

AddEventHandler('onResourceStart', function(resource)
if resource ~= GetCurrentResourceName() then return end
if GetResourceState('ox_inventory') ~= 'started' then
   print('ox_inventory is not started')
else
   exports.ox_inventory:registerHook('swapItems', function(payload)
   local player = GetPlayerName(payload.source)
   local laikas = os.date("%Y/%m/%d %X")
   if payload.fromType == "stash" then
      sendDiscordWebhook2(player .. " pasiėmė " .. payload.count .. "x " .. payload.fromSlot.label .. " iš daiktadėžės (" .. exports.ox_inventory:GetInventory(payload.fromInventory, false).label .. ").\n\nLaikas: " .. laikas)
   elseif payload.toType == "stash" and payload.fromType ~= "stash" then
      sendDiscordWebhook2(player .. " įdėjo " .. payload.count .. "x " .. payload.fromSlot.label .. " į daiktadėžę (" .. exports.ox_inventory:GetInventory(payload.toInventory, false).label .. ").\n\nLaikas: " .. laikas)
      end
   end, {
   })
end
end)


function sendDiscordWebhook(description)
   local Webhook = "https://discord.com/api/webhooks/" -- Link webhooks

   local data = {embeds = {{title = "Inventoriaus logai", description = description, color = 229954}}}

   PerformHttpRequest(Webhook, function(statusCode)
   if statusCode ~= 204 then
      print("Error sending Discord webhook")
   end
   end, "POST", json.encode(data), {["Content-Type"] = "application/json"})
end

AddEventHandler('onResourceStop', function(resource)
if resource ~= GetCurrentResourceName() then return end
if GetResourceState('ox_inventory') ~= 'started' then return end
exports.ox_inventory:removeHooks()
end)

AddEventHandler('onResourceStart', function(resource)
if resource ~= GetCurrentResourceName() then return end
if GetResourceState('ox_inventory') ~= 'started' then
   print('ox_inventory is not started')
else
   exports.ox_inventory:registerHook('swapItems', function(payload)
   local player = GetPlayerName(payload.source)
   local laikas = os.date("%Y/%m/%d %X")
   if payload.toType == "trunk" and payload.fromType ~= "trunk" then
      sendDiscordWebhook(player .. " įdėjo " .. payload.count .. "x " .. payload.fromSlot.label .. " į mašinos (" .. string.gsub(payload.toInventory, "trunk", "") .. ") bagazinę.\n\nLaikas: " .. laikas)
   elseif payload.toType == "glovebox" and payload.fromType ~= "glovebox" then
      sendDiscordWebhook(player .. " įdėjo " .. payload.count .. "x " .. payload.fromSlot.label .. " į mašinos (" .. string.gsub(payload.toInventory, "glove", "") .. ") bardačioką.\n\nLaikas: " .. laikas)
   elseif payload.toType == "drop" and payload.fromType ~= "drop" then
      sendDiscordWebhook(player .. " išmetė " .. payload.count .. "x " .. payload.fromSlot.label .. " ant žemės.\n\nLaikas: " .. laikas)
   elseif payload.toType == "player" then
      if payload.fromType == "glovebox" then
         sendDiscordWebhook(player .. " pasiėmė " .. payload.count .. "x " .. payload.fromSlot.label .. " iš mašinos (" .. string.gsub(payload.fromInventory, "trunk", "") .. ") bardačioko.\n\nLaikas: " .. laikas)
      elseif payload.fromType == "trunk" then
         sendDiscordWebhook(player .. " pasiėmė " .. payload.count .. "x " .. payload.fromSlot.label .. " iš mašinos (" .. string.gsub(payload.fromInventory, "glove", "") .. ") bagažinės.\n\nLaikas: " .. laikas)
      elseif payload.fromType == "drop" then
         sendDiscordWebhook(player .. " pasiėmė " .. payload.count .. "x " .. payload.fromSlot.label .. " nuo žemės.\n\nLaikas: " .. laikas)
      elseif payload.fromType == "player" and payload.action == "give" then
         sendDiscordWebhook(player .. " davė " .. payload.count .. "x " .. payload.fromSlot.label .. " žaidėjui " .. GetPlayerName(payload.toInventory) .. ".\n\nLaikas: " .. laikas)
      end
   end
   end, {
   })
end
end)