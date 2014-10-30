define bioc ($package = $title, $mirror = 'http://bioconductor.statistik.tu-dortmund.de') {
	exec { "install-bioconductor-${package}":
		command => "Rscript -e \"options(BioC_mirror='${mirror}')\" \
			-e \"source('http://bioconductor.org/biocLite.R')\" \
			-e \"biocLite('${package}')\"",
		unless  => "Rscript -e 'library(${package})'",
		path    => ['/bin', '/usr/bin'],
		require => Package['r-base'],
		timeout => 0
	}
}
