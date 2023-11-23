local ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("rl_dumpsters:Server:SearchedDumpsters")
AddEventHandler(
    "rl_dumpsters:Server:SearchedDumpsters", 
    function(Dumpster)
        local Source = source
        local Player = ESX.GetPlayerFromId(Source)
        if not Player then
            return 
        end
        StartTimer(Source, Dumpster)
        local Item, Amount = RandomItem()
        if Item ~= nil and Amount ~= nil then
            if exports.ox_inventory:CanCarryItem(Source, Item, Amount) then
                exports.ox_inventory:AddItem(
                    Source,
                    Item, 
                    Amount
                )
                Notify(Source, "You found: " .. Item .. " " ..Amount.. "x", "success")
            end
        else
            print("ERROR")
        end
    end
)

function Notify(Source, Text, Type)
    lib.notify(Source, { 
        title = "Dumpster", 
        description = Text,
        duration = 2500,
        position = "bottom",
        type = Type, 
        style = {
            backgroundColor = "#131121",    
            color = "#ffffff"
        },
    })
end

function RandomItem()
    local Chance, ChanceVal = math.random(), 0
    for Key, Value in pairs(rlConfig.ItemTable) do
        ChanceVal = ChanceVal + Value["Chance"]
        if Chance <= ChanceVal then
            local Item, Amount = Value["ItemName"], math.random(Value["Amount"][1], Value["Amount"][2])
            return Item, Amount
        end
    end 
    return nil
end

function StartTimer(Source, Dumpster)
    CreateThread(
        function()
            Wait(rlConfig.WaitTimer * 60 * 1000)
            TriggerClientEvent("rl_dumpster:Client:RemoveTimer", Source, Dumpster)
        end
    )
end