# ------------------------------------------------------------------------
#
# Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein is strictly forbidden, unless permitted by WSO2 in accordance with
# the WSO2 Commercial License available at http://wso2.com/licenses.

# For specific language governing the permissions and limitations under this
# license, please see the license as well as any agreement you’ve entered into
# with WSO2 governing the purchase of this software and any associated services.
# ------------------------------------------------------------------------------

# set base Docker image to adoptopenjdk CentOS Docker image
FROM adoptopenjdk/openjdk8:x86_64-centos-jdk8u252-b09
LABEL maintainer="WSO2 Docker Maintainers <dev@wso2.org>"

# install required packages
RUN \
    yum -y update \
    && yum install -y \
        rpm-build \
        sudo \
        git \
        unzip \
        wget \
    && rm -rf /var/cache/yum/*

RUN \
    echo "net.ipv4.ip_local_port_range=15000 61000" >> /etc/sysctl.conf \
    && echo "net.ipv4.tcp_fin_timeout=30" >> /etc/sysctl.conf \
    && echo "*	soft	nofile	65535" >> /etc/security/limits.conf \
    && echo "*	hard	nofile	65535" >> /etc/security/limits.conf \
    && echo "*	soft	nproc	65535" >> /etc/security/limits.conf \
    && echo "*	hard	nproc	65535" >> /etc/security/limits.conf

RUN \
    mkdir -p /home/jenkins

ARG JENKINS_REMOTING_VERSION=3.5

# See https://github.com/jenkinsci/docker-slave/blob/2.62/Dockerfile#L32
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JENKINS_REMOTING_VERSION/remoting-$JENKINS_REMOTING_VERSION.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar \
  && chmod a+rwx /home/jenkins

EXPOSE 22

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]
