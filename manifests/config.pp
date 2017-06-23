class gitolitepuppet::config inherits gitolitepuppet {
	file { ['/var/repos/local', 
		'/var/repos/local/VREF',
		'/var/repos/local/hooks',
		'/var/repos/local/hooks/repo-specific',]:
		ensure => directory,
		owner  => $gitolite::user_name,
		group  => $gitolite::group_name,
	}
	file { '/var/repos/local/VREF/puppet-update':
		ensure => file,
		owner  => $gitolite::user_name,
		group  => $gitolite::group_name,
		mode => '0755',
		content => epp('gitolitepuppet/puppet-update.epp'),
		require => File["/var/repos/local/VREF"],
	}
	file { '/var/repos/local/hooks/repo-specific/puppet-post-receive':
		ensure => file,
		owner  => $gitolite::user_name,
		group  => $gitolite::group_name,
		mode => '0755',
		content => epp('gitolitepuppet/puppet-post-receive.epp'),
		require => File["/var/repos/local/hooks/repo-specific"],
	}
        sudoers::allowed_command { "pupadm":
          group   => 'pupadm',
          command => "/bin/su - puppet *",
          require_password => false,
          comment => "pupadm can use pup",
        }
        ssh_keygen { 'puppet':
          home => '/var/puppet',
          bits => '4096',
          comment => 'puppet',
          before => File['/var/repos/.gitolite/keydir/puppet.pub'],
        }
        file { '/var/repos/.gitolite/keydir/puppet.pub':
          ensure => file,
          source => '/var/puppet/.ssh/id_rsa.pub',
          mode => '0600',
          owner => 'gitolite3',
          group => 'gitolite3',
        }	
}
