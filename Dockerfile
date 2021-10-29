FROM centos:7

LABEL maintainer="<eball@linuxfoundation.org>"

SHELL ["/bin/bash", "-c"]

ENV SIGUL_IP
ENV SIGUL_URI

RUN echo $'[fedora-infra-sigul] \n\
name=Fedora builder packages for sigul \n\
baseurl=https://kojipkgs.fedoraproject.org/repos-dist/epel\$releasever-infra/latest/\$basearch/ \n\
enabled=1 \n\
gpgcheck=1 \n\
gpgkey=https://infrastructure.fedoraproject.org/repo/infra/RPM-GPG-KEY-INFRA-TAGS \n\
includepkgs=sigul* \n\
skip_if_unavailable=True' > /etc/yum.repos.d/fedora-infra-sigul.repo

RUN yum install -y -q sigul
