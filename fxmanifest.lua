fx_version 'cerulean'
games { 'gta5' }

author 'GMD Scripts & Design'
version '2.0'

data_file 'DLC_ITYP_REQUEST' 'stream/*.ydd'
data_file 'DLC_ITYP_REQUEST' 'stream/*.ytf'
data_file 'DLC_ITYP_REQUEST' 'stream/*.ymt'
data_file 'DLC_ITYP_REQUEST' 'stream/*ytd'
data_file 'PED_METADATA_FILE' 'stream/peds.meta'

lua54 'yes'

shared_scripts {
	'config.lua'
}

files {
	'stream/peds.meta'
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
  }

client_scripts {
	'client/client.lua'
}

dependencies {
	'es_extended',
	'oxmysql'
  }
  