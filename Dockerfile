FROM ubuntu:trusty
MAINTAINER FMBAH


RUN locale-gen en_US.UTF-8 &&\
    apt-get -q update &&\
    apt-get install awscli -y &&\
    apt-get install python git jwhois -y &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends openssh-server &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd


RUN apt-get -q update &&\
    apt-get install unzip -y &&\
    apt-get install wget -y &&\
    wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -P /tmp/ &&\
    wget https://releases.hashicorp.com/packer/1.2.5/packer_1.2.5_linux_amd64.zip -P /tmp/ &&\
    unzip /tmp/terraform_0.11.7_linux_amd64.zip -d /usr/local/bin/ &&\
    unzip /tmp/packer_1.2.5_linux_amd64.zip -d /usr/local/bin

RUN apt-get remove --purge ansible -y &&\
    apt-get install python3-software-properties -y &&\
    #apt-add-repository ppa:ansible/ansible -y &&\
    apt-get -q update &&\
    apt-get install ansible -y


ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install JDK 8 (latest edition)
RUN apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends software-properties-common &&\
    add-apt-repository -y ppa:openjdk-r/ppa &&\
    apt-get -q update &&\
    apt-get install -y openjdk-8-jdk &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends openjdk-8-jre-headless &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

RUN apt-get -q update &&\ 
    apt-get install maven -y 

RUN wget https://services.gradle.org/distributions/gradle-5.1-bin.zip -P /tmp/ &&\ 
    unzip -d /opt/gradle /tmp/gradle-*.zip &&\
    echo "export GRADLE_HOME=/opt/gradle/gradle-5.1" >> /etc/profile.d/gradle.sh &&\ 
    echo "export PATH=${GRADLE_HOME}/bin:${PATH}" >> /etc/profile.d/gradle.sh &&\ 
    /bin/bash -c "source /etc/profile.d/gradle.sh"


RUN useradd -m -d /home/jenkins -s /bin/sh jenkins && echo "jenkins:jenkins" | chpasswd
RUN sudo /var/lib/dpkg/info/ca-certificates-java.postinst configure # Fixed Some issues with java SSL problem https://stackoverflow.com/questions/6784463/error-trustanchors-parameter-must-be-non-empty

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]
