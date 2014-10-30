define deb ($url, $package = $title) {
	exec { "install-$package-deb":
		command => "wget '$url' -qO /tmp/$package && dpkg -i /tmp/$package && rm /tmp/$package",
		unless  => "dpkg -l $package 2>&1 > /dev/null",
		path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin']
	}
}
