fx_version 'cerulean'
games { 'gta5' }

author 'GMD Scripts & Design'
version '2.0'

data_file 'DLC_ITYP_REQUEST' 'stream/*.ydd'
data_file 'DLC_ITYP_REQUEST' 'stream/*.ytf'
data_file 'DLC_ITYP_REQUEST' 'stream/*.ymt'
data_file 'DLC_ITYP_REQUEST' 'stream/*ytd'
data_file 'PED_METADATA_FILE' 'stream/peds.meta'
data_file 'DLC_ITYP_REQUEST' 'stream/BzZzi_prop/bz_prop_gift2.ytyp'

lua54 'yes'

shared_scripts {
	'config.lua',
	'@ox_lib/init.lua'
}

files {
	'stream/peds.meta'
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
  }

client_scripts {
	'client/client.lua',
	'client/ox_lib.lua'
}

dependencies {
	'es_extended',
	'oxmysql'
  }
  