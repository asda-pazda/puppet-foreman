class bind {
	# service { "bind":
	# 	require => [ Package["bind"], Package["bind-libs"] ]
	# }
	# include bind::server
	include bind::install, bind::config, bind::server
}
