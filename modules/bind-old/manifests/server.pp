class bind::server{
	service { "bind9":
	hasstatus => true,
	hasrestart => true,
	enable => true,
	}
}

class bind::server::enabled inherits bind::server {
	Service["bind9"] { ensure => running, enable => true }
}
class bind::server::disabled inherits bind::server {
        Service["bind9"] { ensure => stopped, enable => false }
}

