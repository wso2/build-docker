# ------------------------------------------------------------------------
#
# Copyright 2020 WSO2, Inc. (http://wso2.com)
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

FROM ubuntu:bionic

RUN \
    apt-get -q update \
    && apt-get install -y \
       ant \
       curl \
       dbus-x11 \
       git \
       openssh-server \
       software-properties-common \
       ttf-ancient-fonts \
       unzip \
       wget \
       xvfb \
       zip \
       sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /var/run/sshd

#add maven versions here

RUN \
    mkdir -p /build/software/maven \
    && wget -P /build/software/maven https://archive.apache.org/dist/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz \
    && tar -xvzf /build/software/maven/apache-maven-3.0.5-bin.tar.gz --directory /build/software/maven \
    && rm /build/software/maven/apache-maven-3.0.5-bin.tar.gz

RUN \
    wget -P /build/software/maven https://archive.apache.org/dist/maven/maven-3/3.2.2/binaries/apache-maven-3.2.2-bin.tar.gz \
    && tar -xvzf /build/software/maven/apache-maven-3.2.2-bin.tar.gz --directory /build/software/maven \
    && rm /build/software/maven/apache-maven-3.2.2-bin.tar.gz

RUN \
    wget -P /build/software/maven https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
    && tar -xvzf /build/software/maven/apache-maven-3.3.9-bin.tar.gz --directory /build/software/maven \
    && rm /build/software/maven/apache-maven-3.3.9-bin.tar.gz

RUN \
    wget -P /build/software/maven https://archive.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz \
    && tar -xvzf /build/software/maven/apache-maven-3.5.4-bin.tar.gz --directory /build/software/maven \
    && rm /build/software/maven/apache-maven-3.5.4-bin.tar.gz

RUN \
    wget -P /build/software/maven https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz \
    && tar -xvzf /build/software/maven/apache-maven-3.6.3-bin.tar.gz --directory /build/software/maven \
    && rm /build/software/maven/apache-maven-3.6.3-bin.tar.gz

RUN \
    wget -P /build/software/maven https://archive.apache.org/dist/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz \
    && tar -xvzf /build/software/maven/apache-maven-3.8.6-bin.tar.gz --directory /build/software/maven \
    && rm /build/software/maven/apache-maven-3.8.6-bin.tar.gz

RUN \
    wget -P /build/software/maven https://archive.apache.org/dist/maven/maven-2/2.2.1/binaries/apache-maven-2.2.1-bin.tar.gz \
    && tar -xvzf /build/software/maven/apache-maven-2.2.1-bin.tar.gz --directory /build/software/maven \
    && rm /build/software/maven/apache-maven-2.2.1-bin.tar.gz


RUN mkdir -p /build/software/java

#add java versions here

COPY OpenJDK11U-jdk_x64_linux_hotspot_11.0.4_11.tar.gz /build/software/java

RUN \
    tar -xvzf /build/software/java/OpenJDK11U-jdk_x64_linux_hotspot_11.0.4_11.tar.gz --directory /build/software/java \
    && rm /build/software/java/OpenJDK11U-jdk_x64_linux_hotspot_11.0.4_11.tar.gz

COPY amazon-corretto-11.0.4.11.1-linux-x64.tar.gz /build/software/java

RUN \
    tar -xvzf /build/software/java/amazon-corretto-11.0.4.11.1-linux-x64.tar.gz --directory /build/software/java \
    && rm /build/software/java/amazon-corretto-11.0.4.11.1-linux-x64.tar.gz

RUN \
    wget -P /build/software/java https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.7%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz \
    && tar -xvzf /build/software/java/OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz --directory /build/software/java \
    && rm /build/software/java/OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz

RUN \
    wget -P /build/software/java https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.7_7.tar.gz \
    && tar -xvzf /build/software/java/OpenJDK17U-jdk_x64_linux_hotspot_17.0.7_7.tar.gz --directory /build/software/java \
    && rm /build/software/java/OpenJDK17U-jdk_x64_linux_hotspot_17.0.7_7.tar.gz

COPY jdk-8u171-linux-x64.tar.gz /build/software/java

RUN \
    tar -xvzf /build/software/java/jdk-8u171-linux-x64.tar.gz --directory /build/software/java \
    && rm /build/software/java/jdk-8u171-linux-x64.tar.gz \
    && mkdir -p /build/software/jce \
    && wget -P /build/software/jce --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -o /build/software/jce/jce_policy-8.zip -d /build/software/jce \
    && mv /build/software/java/jdk1.8.0_171/jre/lib/security/policy/unlimited/local_policy.jar /build/software/java/jdk1.8.0_171/jre/lib/security/policy/unlimited/local_policy-original.jar \
    && mv /build/software/java/jdk1.8.0_171/jre/lib/security/policy/unlimited/US_export_policy.jar /build/software/java/jdk1.8.0_171/jre/lib/security/policy/unlimited/US_export_policy-original.jar \
    && cp /build/software/jce/UnlimitedJCEPolicyJDK8/local_policy.jar /build/software/java/jdk1.8.0_171/jre/lib/security/policy/unlimited/ \
    && cp /build/software/jce/UnlimitedJCEPolicyJDK8/US_export_policy.jar /build/software/java/jdk1.8.0_171/jre/lib/security/policy/unlimited/ \
    && rm  /build/software/jce/jce_policy-8.zip \
    && rm -r /build/software/jce/UnlimitedJCEPolicyJDK8

COPY jdk-8u144-linux-x64.tar.gz /build/software/java

RUN \
    tar -xvzf /build/software/java/jdk-8u144-linux-x64.tar.gz --directory /build/software/java \
    && rm /build/software/java/jdk-8u144-linux-x64.tar.gz \
    && mkdir -p /build/software/jce \
    && wget -P /build/software/jce --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -o /build/software/jce/jce_policy-8.zip -d /build/software/jce \
    && mv /build/software/java/jdk1.8.0_144/jre/lib/security/local_policy.jar /build/software/java/jdk1.8.0_144/jre/lib/security/local_policy-original.jar \
    && mv /build/software/java/jdk1.8.0_144/jre/lib/security/US_export_policy.jar /build/software/java/jdk1.8.0_144/jre/lib/security/US_export_policy-original.jar \
    && cp /build/software/jce/UnlimitedJCEPolicyJDK8/local_policy.jar /build/software/java/jdk1.8.0_144/jre/lib/security/ \
    && cp /build/software/jce/UnlimitedJCEPolicyJDK8/US_export_policy.jar /build/software/java/jdk1.8.0_144/jre/lib/security/ \
    && rm  /build/software/jce/jce_policy-8.zip \
    && rm -r /build/software/jce/UnlimitedJCEPolicyJDK8

COPY jdk-8u45-linux-x64.tar.gz /build/software/java

RUN \
    tar -xvzf /build/software/java/jdk-8u45-linux-x64.tar.gz --directory /build/software/java \
    && rm /build/software/java/jdk-8u45-linux-x64.tar.gz \
    && mkdir -p /build/software/jce \
    && wget -P /build/software/jce --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -o /build/software/jce/jce_policy-8.zip -d /build/software/jce \
    && mv /build/software/java/jdk1.8.0_45/jre/lib/security/local_policy.jar /build/software/java/jdk1.8.0_45/jre/lib/security/local_policy-original.jar \
    && mv /build/software/java/jdk1.8.0_45/jre/lib/security/US_export_policy.jar /build/software/java/jdk1.8.0_45/jre/lib/security/US_export_policy-original.jar \
    && cp /build/software/jce/UnlimitedJCEPolicyJDK8/local_policy.jar /build/software/java/jdk1.8.0_45/jre/lib/security/ \
    && cp /build/software/jce/UnlimitedJCEPolicyJDK8/US_export_policy.jar /build/software/java/jdk1.8.0_45/jre/lib/security/ \
    && rm  /build/software/jce/jce_policy-8.zip \
    && rm -r /build/software/jce/UnlimitedJCEPolicyJDK8

RUN \
    add-apt-repository ppa:openjdk-r/ppa -y \
    && apt-get update \
    && apt-get install -y \
       openjdk-8-jdk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#add node versions here


RUN \
    wget -P /build/software/nodejs https://nodejs.org/dist/v8.8.1/node-v8.8.1-linux-x64.tar.xz \
    && tar -xvf /build/software/nodejs/node-v8.8.1-linux-x64.tar.xz --directory /build/software/nodejs \
    && rm /build/software/nodejs/node-v8.8.1-linux-x64.tar.xz

RUN \
    wget -P /build/software/nodejs https://nodejs.org/dist/v10.16.2/node-v10.16.2-linux-x64.tar.xz \
    && tar -xvf /build/software/nodejs/node-v10.16.2-linux-x64.tar.xz --directory /build/software/nodejs \
    && rm /build/software/nodejs/node-v10.16.2-linux-x64.tar.xz

RUN \
    wget -P /build/software/nodejs https://nodejs.org/dist/v12.20.1/node-v12.20.1-linux-x64.tar.xz \
    && tar -xvf /build/software/nodejs/node-v12.20.1-linux-x64.tar.xz --directory /build/software/nodejs \
    && rm /build/software/nodejs/node-v12.20.1-linux-x64.tar.xz

RUN \
    wget -P /build/software/nodejs https://nodejs.org/dist/v14.21.3/node-v14.21.3-linux-x64.tar.xz \
    && tar -xvf /build/software/nodejs/node-v14.21.3-linux-x64.tar.xz --directory /build/software/nodejs \
    && rm /build/software/nodejs/node-v14.21.3-linux-x64.tar.xz

RUN \
    wget -P /build/software/nodejs https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.xz \
    && tar -xvf /build/software/nodejs/node-v16.13.1-linux-x64.tar.xz --directory /build/software/nodejs \
    && rm /build/software/nodejs/node-v16.13.1-linux-x64.tar.xz

#add go versions here

RUN wget -P /build/software/go https://dl.google.com/go/go1.10.linux-amd64.tar.gz \
    && tar -xzf /build/software/go/go1.10.linux-amd64.tar.gz --directory /build/software/go && mv /build/software/go/go /build/software/go/go-1.10 && rm /build/software/go/go1.10.linux-amd64.tar.gz

RUN wget -P /build/software/go https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz \
    && tar -xzf /build/software/go/go1.12.5.linux-amd64.tar.gz --directory /build/software/go && mv /build/software/go/go /build/software/go/go-1.12.5 && rm /build/software/go/go1.12.5.linux-amd64.tar.gz

RUN wget -P /build/software/go https://dl.google.com/go/go1.13.linux-amd64.tar.gz \
    && tar -xzf /build/software/go/go1.13.linux-amd64.tar.gz --directory /build/software/go && mv /build/software/go/go /build/software/go/go-1.13 && rm /build/software/go/go1.13.linux-amd64.tar.gz

RUN wget -P /build/software/go https://dl.google.com/go/go1.14.linux-amd64.tar.gz \
    && tar -xzf /build/software/go/go1.14.linux-amd64.tar.gz --directory /build/software/go && mv /build/software/go/go /build/software/go/go-1.14 && rm /build/software/go/go1.14.linux-amd64.tar.gz

RUN wget -P /build/software/go https://dl.google.com/go/go1.20.linux-amd64.tar.gz \
    && tar -xzf /build/software/go/go1.20.linux-amd64.tar.gz --directory /build/software/go && mv /build/software/go/go /build/software/go/go-1.20 && rm /build/software/go/go1.20.linux-amd64.tar.gz

ENV GOPATH /build/software/go/go
ENV PATH $GOPATH/bin:/build/software/go/go-1.12.5/bin:$PATH
ENV PATH $GOPATH/bin:/build/software/go/go-1.13/bin:$PATH
ENV PATH $GOPATH/bin:/build/software/go/go-1.14/bin:$PATH
ENV PATH $GOPATH/bin:/build/software/go/go-1.20/bin:$PATH

RUN mkdir -p "$GOPATH/src/github.com/wso2" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN curl https://glide.sh/get | sh

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN \
    apt-get update  \
    && apt-get -y install \
       python3-pip \
    && pip3 --version \
    && apt-get -y install \
       build-essential \
       python3-dev \
    && pip3 install mkdocs==1.0.4 \
    && mkdocs --version \
    && pip3 install mkdocs-material==4.4.0 \
    && pip3 install pygments==2.4.2 \
    && apt-get -y install jq

RUN \
    apt-get -y update \
    && apt-get -y install \
       python-pip \
    && pip --version \
    && apt-get install -y \
       libxml2-dev \
       libxslt-dev \
    && pip3 install \
       beautifulsoup4 \
    && apt-get install -y \
       python-lxml

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf \
        awscliv2.zip  

COPY OpenJDK8U-jdk_x64_linux_hotspot_8u362b09.tar.gz /build/software/java

RUN \
    tar -xvzf /build/software/java/OpenJDK8U-jdk_x64_linux_hotspot_8u362b09.tar.gz --directory /build/software/java \
    && rm /build/software/java/OpenJDK8U-jdk_x64_linux_hotspot_8u362b09.tar.gz

ENV JAVA_HOME /build/software/java/jdk8u362-b09

RUN \
    wget -P /build/software/android https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip /build/software/android/sdk-tools-linux-4333796.zip -d /build/software/android/ \
    && rm /build/software/android/sdk-tools-linux-4333796.zip \
    && yes | /build/software/android/tools/bin/sdkmanager --licenses \
    && chmod 777 -R /build/software/android/ \
    && unset JAVA_HOME

ENV ANDROID_HOME /build/software/android

RUN rm /usr/bin/java \
    && ln -s /usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/java  /usr/bin/java

RUN \
    echo "net.ipv4.ip_local_port_range=15000 61000" >> /etc/sysctl.conf \
    && echo "net.ipv4.tcp_fin_timeout=30" >> /etc/sysctl.conf \
    && echo "*	soft	nofile	65535" >> /etc/security/limits.conf \
    && echo "*	hard	nofile	65535" >> /etc/security/limits.conf \
    && echo "*	soft	nproc	65535" >> /etc/security/limits.conf \
    && echo "*	hard	nproc	65535" >> /etc/security/limits.conf

RUN \
    mkdir -p /home/jenkins

RUN mkdir -p /build/gpg-keys/.gnupg
ADD .gnupg /build/gpg-keys/.gnupg

RUN export GPG_TTY=$(tty)

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
