#!/bin/bash
if [ "$1" = "/vagrant" ]; then
    echo "Using Vagrant, so creating symlinks for Puppet ..."
    if [[ -e "/etc/puppet/manifests" ]]; then
        for file in /vagrant/puppet/manifests/*.pp; do
            [ ! -e /etc/puppet/manifests/${file##*/} ] && ln -s /vagrant/puppet/manifests/${file##*/} /etc/puppet/manifests/${file##*/}
        done
    else
        ln -s /vagrant/puppet/manifests /etc/puppet/manifests
    fi

    if [[ -e "/etc/puppet/hieradata" ]]; then
        for file in /vagrant/puppet/hieradata/*.yaml; do
            [ ! -e /etc/puppet/hieradata/${file##*/} ] && ln -s /vagrant/puppet/hieradata/${file##*/} /etc/puppet/hieradata/${file##*/}
        done
    else
        [ ! -e /etc/puppet/hieradata ] && ln -s /vagrant/puppet/hieradata /etc/puppet/hieradata
    fi

    [ ! -e /etc/puppet/hiera.yaml ] && ln -s /vagrant/puppet/hiera.yaml /etc/puppet/hiera.yaml
    [ ! -e /etc/puppet/Puppetfile ] && ln -s /vagrant/puppet/Puppetfile /etc/puppet/Puppetfile
else
    if [ "$(pwd)" = "/etc/puppet"]; then
        echo "Not using Vagrant, and everything is a-okay!"
    else
        echo "Not using Vagrant, this file should be run from /etc/puppet directory ..."
    fi
fi
puppet apply /etc/puppet/manifests/deps.pp
cd /etc/puppet/
librarian-puppet install
if [ ! "$1" = "/vagrant"]; then 
    puppet apply /etc/puppet/manifests/default.pp
fi
