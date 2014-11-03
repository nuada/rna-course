class { 'apt': }

apt::source { 'cran':
	location    => 'http://r.meteo.uni.wroc.pl/bin/linux/ubuntu',
	release     => "$lsbdistcodename/",
	repos       => '',
	key         => '51716619E084DAB9',
	key_server  => 'keyserver.ubuntu.com',
	include_src => false
}

package {
	'bowtie': ensure => present;
	'build-essential': ensure => present;
	'cifs-utils': ensure => present;
	'curl': ensure => present;
	'cutadapt': ensure => present, provider => pip, require => Package['python-pip'];
	'fastqc': ensure => present;
	'git': ensure => present;
	'ipython': ensure => present;
	'libcurl4-openssl-dev': ensure => present;
	'libjpeg62': ensure => present;
	'libxml2-dev': ensure => present;
	'openjdk-7-jdk': ensure => present;
	'python-dev': ensure => present;
	'python-pip': ensure => present;
	'r-base': ensure => latest, require => Apt::Source['cran'];
	'rsync': ensure => present;
	'samtools': ensure => present;
	'trimmomatic': ensure => present;
	'wget': ensure => present;
}

bioc {
	'annotate': ;
	'AnnotationDbi': ;
	'baySeq': ;
	'Biobase': ;
	'Biostrings': ;
	'BSgenome.Hsapiens.UCSC.hg19': ;
	'chimera': notify => Exec['setup-chimera'];
	'DESeq': ;
	'EDASeq': ;
	'edgeR': ;
	'goseq': ;
	'IRanges': ;
	'MiRaGE': ;
	'miRNApath': ;
	'miRNAtap': ;
	'miRNAtap.db': ;
	'org.Hs.eg.db': ;
	'org.Mm.eg.db': ;
	'RankProd': ;
	'Rbowtie': ;
	'RmiR': ;
	'RmiR.Hs.miRNA': ;
	'Roleswitch': ;
	'Rsamtools': ;
	'R.utils': ;
	'TxDb.Hsapiens.UCSC.hg19.knownGene': ;
}

exec { 'setup-chimera':
	refreshonly => true,
	command     => "Rscript -e 'library(chimera)' -e 'oncofuseInstallation()' -e 'gapfillerInstallation(\"unix64\")'",
	path        => ['/bin', '/usr/bin']
}

deb { 'rstudio':
	url     => 'http://download1.rstudio.org/rstudio-0.98.1083-amd64.deb',
	version => '0.98.1083',
	require => [Package['wget'], Package['libjpeg62'], Package['r-base']]
}

# SHRiMP
exec { 'shrimp':
	command => 'wget -O /tmp/SHRiMP_2_2_3.lx26.x86_64.tar.gz http://compbio.cs.toronto.edu/shrimp/releases/SHRiMP_2_2_3.lx26.x86_64.tar.gz; \
		tar zx -C /opt -f /tmp/SHRiMP_2_2_3.lx26.x86_64.tar.gz; \
		rm -f /tmp/SHRiMP_2_2_3.lx26.x86_64.tar.gz; \
		ln -s /opt/SHRiMP_2_2_3/bin/* /usr/bin',
	creates => '/opt/SHRiMP_2_2_3',
	path    => ['/bin', '/usr/bin']
}
