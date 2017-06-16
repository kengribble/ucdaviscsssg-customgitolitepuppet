class gitolitepuppet::config inherits gitolitepuppet {
	file { ['/var/repos/local', 
		'/var/repos/local/VREF',
		'/var/repos/local/hooks,
		'/var/repos/local/hooks/repo-specific,']:
		ensure => directory,
		owner => 'gitolite3',
		group => 'gitolite3',
	}
	file { '/var/repos/local/VREF/puppet-update':
		ensure => file,
		owner => "gitolite3",
		group => "gitolite3",
		mode => '0755',
		content => epp('gitolitepuppet/puppet-update.epp'),
		require => File["/var/repos/local/VREF"],
	}
	file { '/var/repos/local/hooks/repo-specific/puppet-post-receive':
		ensure => file,
		owner => "gitolite3",
		group => "gitolite3",
		mode => '0755',
		content => epp('gitolitepuppet/puppet-post-receive.epp'),
		require => File["/var/repos/local/hooks/repo-specific"],
	}
}
