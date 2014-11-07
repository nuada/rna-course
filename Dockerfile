FROM ubuntu:14.04
MAINTAINER Piotr Radkowski <piotr.radkowski@uj.edu.pl>

ENV DEBIAN_FRONTEND noninteractive

# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
RUN echo 'force-unsafe-io' | tee /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' | tee /etc/apt/apt.conf.d/no-cache

RUN apt-get -q update

ADD manifests /tmp/manifests
ADD apply /tmp/apply
RUN /tmp/apply && rm -rf /tmp/{apply,manifests}

RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

ENV HOME /root
WORKDIR /root
CMD ["bash"]
