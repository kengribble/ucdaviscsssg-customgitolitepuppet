class gitolitepuppet::config inherits gitolitepuppet {
	file { '/var/repos/local/VREF/puppet-update':
		ensure => file,
		owner => 'gitolite3',
		group => 'gitolite3',
		mode => 0755,
		content => epp('gitolitepuppet/puppet-update.epp'),
	}
	file { '/var/repos/local/hooks/repo-specific/puppet-post-receive':
		ensure => file,
		owner => 'gitolite3',
		group => 'gitolite3',
		mode => 0755,
		content => epp('gitolitepuppet/puppet-post-receive.epp'),
	}
	file { '/var/repos/.gitolite.rc':
		ensure => file,
		owner => 'gitolite3',
		group => 'gitolite3',
		mode => 0600,
		content => epp('gitolitepuppet/gitolite.rc.epp'),
	}
}
