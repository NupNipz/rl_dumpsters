local ESX = exports["es_extended"]:getSharedObject()
local SearchedDumpsters = {1}
local Searching = false

exports.ox_target:addModel(rlConfig.Dumpsters, {
    {
        name = "rl_dumsters:SearchDumpster",
        icon = "fa-solid fa-dumpster",
        label = "Search Dumpsters",
        distance = 1.5,
        canInteract = function()
            return not Searching
        end,
        onSelect = function(Table)
            TriggerEvent("rl_dumpsters:Client:SearchDumpster", Table.entity)
        end
    }
})

RegisterNetEvent("rl_dumpsters:Client:SearchDumpster")
AddEventHandler(
    "rl_dumpsters:Client:SearchDumpster", 
    function(Entity)
        if not Searching then
            for Index = 1, #SearchedDumpsters do
                if SearchedDumpsters[Entity] == nil then
                    Searching = true
                    Notify("You started searching the dumpster", "info")
                    if lib.progressBar({
                        duration = math.random(9000, 11000),
                        label = "Searching Dumpster...",
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            car = true,
                            move = true,
                        },
                        anim = {
                            dict = "amb@prop_human_bum_bin@base",
                            clip = "base",
                        },
                    }) then 
                        TriggerServerEvent("rl_dumpsters:Server:SearchedDumpsters", Entity)
                        SearchedDumpsters[Entity] = Entity
                        Searching = false
                    end
                else
                    Notify("This dumpster has already been searched", "error")
                end
            end
        end
    end
)


RegisterNetEvent("rl_dumpster:Client:RemoveTimer")
AddEventHandler(
    "rl_dumpster:Client:RemoveTimer", 
    function(Entity)
        if SearchedDumpsters[Entity] ~= nil then
            SearchedDumpsters[Entity] = nil
        end
    end
)

function Notify(Text, Type)
    lib.notify({ 
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