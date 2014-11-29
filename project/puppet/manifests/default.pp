node default{

    # For shaftoe puppet-tor
    class{'tor':
        nickname => 'dfexit',
        contaxt => '0xFFFFFF ExitProject <please.dont@email.me>',
        enable_apt_repo => true,
        orport => 443,
        exit_relay => 'custom',
        exit_custom_rules => [
            'accept *:443',
            'accept *:80',
            'accept *:6667',
            'accept *:6697',
            'accept *:22',
            'accept *:25',
            'accept *:23',
            'accept *:26',
            'accept *:8888',
            'accept *:8080'
        ],
        custom_config => [
            'AccountingMax 30GB',
            'MaxAdvertisedBandwidth 5MB'
        ]
    }

    # luxflux puppet-openVPN server
    openvpn::server {'digitalforensics':
        country => 'NO',
        province => 'Oppland',
        city => 'Gjovik',
        organization => 'hig.no',
        email => 'please.dont@email.me',
        server => ${::ipaddress}
    }
}
