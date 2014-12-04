FROM ubuntu:14.04
MAINTAINER Piotr Radkowski <piotr.radkowski@uj.edu.pl>

ENV DEBIAN_FRONTEND noninteractive

# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
RUN echo 'force-unsafe-io' | tee /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' | tee /etc/apt/apt.conf.d/no-cache

RUN apt-get -q update
RUN bash -c 'source /etc/lsb-release && \
	apt-get install -yq wget && \
	wget http://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb && \
	dpkg -i puppetlabs-release-${DISTRIB_CODENAME}.deb && \
	rm -rf puppetlabs-release-${DISTRIB_CODENAME}.deb && \
	apt-get -q update && \
	apt-get install -qy puppet'
RUN puppet module install puppetlabs/apt
ADD manifests /tmp/manifests
RUN puppet apply --verbose /tmp/manifests && rm -rf /tmp/manifests

# Install skewer
RUN wget -O /usr/bin/skewer 'http://sourceforge.net/projects/skewer/files/Binaries/skewer-0.1.120-linux-x86_64/download'

RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

ENV HOME /root
WORKDIR /root
CMD ["bash"]
