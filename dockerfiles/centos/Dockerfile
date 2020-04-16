# ------------------------------------------------------------------------
#
# Copyright 2016 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

# ------------------------------------------------------------------------

# set base Docker image to centos7.7.1908 CentOS Docker image
FROM centos:centos7.7.1908
LABEL maintainer="WSO2 Docker Maintainers <dev@wso2.org>"

# install required packages
RUN yum -y update && yum install -y rpm-build sudo git unzip wget

RUN echo "net.ipv4.ip_local_port_range=15000 61000" >> /etc/sysctl.conf \
&& echo "net.ipv4.tcp_fin_timeout=30" >> /etc/sysctl.conf \
&& echo "*	soft	nofile	65535" >> /etc/security/limits.conf \
&& echo "*	hard	nofile	65535" >> /etc/security/limits.conf \
&& echo "*	soft	nproc	65535" >> /etc/security/limits.conf \
&& echo "*	hard	nproc	65535" >> /etc/security/limits.conf

RUN mkdir -p /home/jenkins

RUN mkdir -p /build/gpg-keys/.gnupg
ADD .gnupg /build/gpg-keys/.gnupg

ARG JENKINS_REMOTING_VERSION=3.5

# See https://github.com/jenkinsci/docker-slave/blob/2.62/Dockerfile#L32
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JENKINS_REMOTING_VERSION/remoting-$JENKINS_REMOTING_VERSION.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar \
  && chmod a+rwx /home/jenkins

EXPOSE 22

COPY ../../entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]
