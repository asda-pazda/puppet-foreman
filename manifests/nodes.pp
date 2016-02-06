node default {
    include puppet
}
class base {
    include puppet,ssh,sudo

    file { "/etc/hosts":
    audit => [ owner, group, mode ],
    }
}
node 'node1.fox.com' {
    include base
    include tftp
        
    network::interface{ 'eth1':
        method => 'dhcp',
    }

    network::interface{ 'eth2':
        address => "192.168.1.1",
        network => "192.168.1.0",
        broadcast => "192.168.1.255",
    }


    include dhcp::server

    dhcp::server::subnet { "192.168.1.0":
    netmask => '255.255.255.0',
    routers => '192.168.1.1',
    broadcast => "192.168.1.255",
    range_begin => "192.168.1.2",
    range_end => "192.168.1.200",
    domain_name => 'fox.com',
    dns_servers => ['8.8.8.8', '8.8.4.4']
    }
}

node 'node2.fox.com' {
    include base

    include dns::server

    # Forward Zone
    dns::zone { 'fox.com':
        soa => "ns1.fox.com",
        soa_email => 'admin.fox.com',
        nameservers => ["ns1"]
    }

    # Reverse Zone
    dns::zone { '1.168.192.IN-ADDR.ARPA':
        soa => "ns1.fox.com",
        soa_email => 'admin.fox.com',
        nameservers => ["ns1"]
    }

    dns::record::a {
        'web':
        zone => 'fox.com',
        data => ["192.168.1.3"];
        'node1':
        zone => 'fox.com',
        data => ["192.168.1.1"];
    }
    # TXT Record:
    dns::record::txt {'www':
        zone => 'fox.com',
        data => 'Hello World',
    }

}
node 'web.fox.com' {
    include base
    include mysql
    include apache
    
    apache::vhost { 'www.fox.com':
        port => 80,
        docroot => '/var/www',
        ssl => false,
        priority => 10,
        serveraliases => 'home.fox.com',
    }
   include postfix
}

node 'mail.fox.com' {
    include base
    include postfix
}
node 'master.fox.com' {
    include base
    include puppet::master
}
