class puppetconf {
	file { "/etc/puppet/puppet.conf":
		owner => "root",
		group => "root",
		mode => 0640,
		source => "puppet://$puppetserver/modules/puppetconf/etc/puppet/puppet.conf",
	}
}
