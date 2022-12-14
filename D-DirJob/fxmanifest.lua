fx_version 'adamant'

game 'gta5'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

	'@es_extended/locale.lua',
    'client/cl_boss_job.lua',
    'client/client_job.lua',
    'client/function.lua',
    'shared/config.lua',
    'client/Accueil.lua',
    'client/cl_Fabric.lua'
}


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
    'server/server_job.lua',
    'shared/config.lua',
}