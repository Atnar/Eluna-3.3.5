local npcEntry = 15167

local teleportCoords = {
    Paladin = { mapID = 1, x = -6997.338867, y = -3767.298096, z = 48.938232 },   -- Tanaris
    Warrior = { mapID = 0, x = -8833.380859, y = 626.347961, z = 94.086700 },    -- Stormwind
    DK = { mapID = 0, x = 2340.330078, y = -5695.520020, z = 426.027 },         -- Eastern Plaguelands
}

local items = {
    Paladin = { 49623, 50363, 10034, 10035, 10036 },
    Warrior = { 50715, 50607, 50639, 50679, 50620 },
    DK = { 50668, 50717, 50709, 50721, 50675 }
}

local function giveItems(player, class)
    for _, itemID in ipairs(items[class]) do
        if not player:HasItem(itemID) then
            player:AddItem(itemID, 1)
        end
    end
end

local function teleportPlayer(player, class)
    local coords = teleportCoords[class]
    player:Teleport(coords.mapID, coords.x, coords.y, coords.z, 0)
end

local function onGossipHello(event, player, creature)
    print("onGossipHello triggered")
    player:GossipMenuAddItem(0, "Paladin", 1, 1)
    player:GossipMenuAddItem(0, "Warrior", 1, 2)
    player:GossipMenuAddItem(0, "DK", 1, 3)
    player:GossipSendMenu(1, creature)
end

local function onGossipSelect(event, player, creature, sender, intid, code)
    print("onGossipSelect triggered with intid: " .. intid)
    if intid == 1 then
        player:SendUnitSay("Paladin!", 0)
        giveItems(player, "Paladin")
        teleportPlayer(player, "Paladin")
    elseif intid == 2 then
        player:SendUnitSay("Warrior!", 0)
        giveItems(player, "Warrior")
        teleportPlayer(player, "Warrior")
    elseif intid == 3 then
        player:SendUnitSay("DK!", 0)
        giveItems(player, "DK")
        teleportPlayer(player, "DK")
    end
    player:GossipComplete()
end

RegisterCreatureGossipEvent(npcEntry, 1, onGossipHello)
RegisterCreatureGossipEvent(npcEntry, 2, onGossipSelect)
