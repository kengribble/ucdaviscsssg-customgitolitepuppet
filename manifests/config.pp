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
        group { 'pup':
             gid => 1013,
             before => User['pup'],
        }
        user { 'pup':
              comment => "Pup For gitolite-puppet",
              uid => 1012,
              gid => 'pup',
              shell => "/bin/bash",
              home => '/var/pup',
              before => Group['pupadm'],
        }
        group { 'pupadm':
             gid => 1012,
             members => ['gribble', 'gitolite3'], 
        }
	file { ['/var/pup',
                '/var/pup/.ssh',]:
                ensure => directory,
                owner => 'pup',
                group => 'pup',
        }
        ssh_keygen { 'pup':
          home => '/var/pup',
          bits => '4096',
          comment => 'pup',
          before => File['/var/repos/.gitolite/keydir/pup.pub'],
          require => File['/var/pup/.ssh'],
        }
        sudoers::allowed_command{ "pupadm":
          group   => "pupadm",
          command => "/bin/su - pup *",
          require_password => false,
          comment => "pupadm can use pup",
        }
        file { '/var/repos/.gitolite/keydir/pup.pub':
          ensure => file,
          source => '/var/pup/.ssh/id_rsa.pub',
          mode => '0600',
          owner  => $gitolite::user_name,
          group  => $gitolite::group_name,
        }	
}
