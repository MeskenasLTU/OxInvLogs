fx_version 'cerulean'
games { 'rdr3', 'gta5' }
lua54        'yes'
author 'OxInvLogs'
description 'OxInvLogs'
version '1.0.0'

shared_script '@es_extended/imports.lua'
shared_script '@ox_lib/init.lua'
shared_script '@mysql-async/lib/MySQL.lua'

client_scripts {
	--'client/*.lua',
}

server_scripts {
	'server/*.lua',
}
