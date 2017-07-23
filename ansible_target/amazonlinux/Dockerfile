FROM amazonlinux:latest

MAINTAINER mahmoud abdelkader <m@m.com>

ENV user ec2-user
ENV group ec2-user
ENV work /work

RUN \
    yum clean all \
    && yum install -y epel-release \
    && yum upgrade -y \
    && yum groupinstall -y "Development Tools" \
    && yum install -y bash-completion \
                      curl initscripts \
                      less \
                      sudo tree unzip vim wget \
                      openssh-server \
                      rsyslog \

    # add local user
    && groupadd ${user} \
    && useradd ${user} -g ${group} -m -s /bin/bash \
    && echo "%${group} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/00-${group} \
    && chmod 400 /etc/sudoers.d/00-${group} \

    # create work directory
    && mkdir ${work} \
    && chown -R ${user}:${group} ${work}

# Various options to make SSH access easier when testing Ansible playbooks
RUN \
  su - ${user} -c "mkdir ~/.ssh" && \
  sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
  # https://www.daveperrett.com/articles/2010/09/14/ssh-authentication-refused/
  sed -i -re "s/^(\#?)(StrictModes).*/StrictModes no/g" /etc/ssh/sshd_config && \
  # sed -i "s/StrictModes.*/StrictModes no/g" /etc/ssh/sshd_config && \
  touch /home/${user}/.Xauthority

COPY docker-entrypoint.sh /
CMD ["/docker-entrypoint.sh"]

EXPOSE 22
