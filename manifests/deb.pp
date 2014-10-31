define deb ($url, $package = $title, $version) {
	exec { "install-${package}-deb":
		command => "wget '${url}' -qO /tmp/${package} && dpkg -i /tmp/${package} && rm /tmp/${package}",
		unless  => "dpkg -l ${package} | grep ^ii | grep \"\\<${version}\\>\" 2>&1 > /dev/null",
		path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin']
	}
}
