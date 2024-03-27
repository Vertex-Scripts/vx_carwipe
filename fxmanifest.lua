fx_version "cerulean"
game "gta5"
lua54 "yes"

author "Vertex Scripts"
version "0.0.0"

server_scripts {
	"src/server.lua"
}

client_scripts {
	"src/client.lua"
}

shared_scripts {
	"@ox_lib/init.lua",
	"config.lua"
}
