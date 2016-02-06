class ssh {
	# or just use
	# require ssh::params
	include ssh::params, ssh::install, ssh::config, ssh::service
}
