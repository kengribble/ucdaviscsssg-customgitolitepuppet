class gitolitepuppet::config inherits gitolitepuppet {
	file { '/var/repos/local/VREF/puppet-update':
		ensure => file,
		owner => 'gitolite3',
		group => 'gitolite3',
		mode => 0755,
		content => template('gitolitepuppet/puppet-update.erb'),
	}
	file { '/var/repos/local/hooks/repo-specific/puppet-post-receive':
		ensure => file,
		owner => 'gitolite3',
		group => 'gitolite3',
		mode => 0755,
		content => template('gitolitepuppet/puppet-post-receive.erb'),
	}
	file { '/var/repos/.gitolite.rc':
		ensure => file,
		owner => 'gitolite3',
		group => 'gitolite3',
		mode => 0600,
		content => template('gitolitepuppet/gitolite.rc.erb'),
	}
}
