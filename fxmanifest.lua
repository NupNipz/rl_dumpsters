fx_version "cerulean"
game "gta5"
lua54 "yes"

dependencies {
    "ox_lib",
    "rl_lib",
    "ox_target",
}

shared_scripts {
    "@ox_lib/init.lua",
    "Config.lua",
}

client_scripts{
    "Client/Client.lua",
} 

server_script {
    "@oxmysql/lib/MySQL.lua",
    "Server/Server.lua",
}