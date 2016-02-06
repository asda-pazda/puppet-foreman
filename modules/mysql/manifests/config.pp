class mysql::config { 
	file { "/etc/mysql/my.cnf": 
	ensure => present, 
	source => "puppet:///modules/mysql/my.cnf", 
	owner => "root", 
	group => "root", 
	require => Class["mysql::install"], 
	notify => Class["mysql::service"], 
	} 
	file { "/var/lib/mysql": 
	group => "mysql", 
	owner => "mysql", 
	recurse => true, 
	require => File["/etc/mysql/my.cnf"], 
	} 
}
