node default{
    $deps = hiera('package', {})
    create_resources('package',$deps)
    exec{"librarian-puppet": command => "/usr/bin/gem install librarian-puppet"}
}
