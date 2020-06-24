FROM i386/ubuntu:18.04

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential codeblocks libmodbus-dev openssh-server mosquitto mosquitto-clients rsync libssl-dev && \
  apt-get install -y apt-transport-https dirmngr wget libzip-dev libmosquitto-dev libmosquittopp-dev libmbedtls-dev libcurl4-openssl-dev && \
  apt-get clean

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
  echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | tee /etc/apt/sources.list.d/mono-official-vs.list && \
  apt-get update && \
  apt-get install -y monodevelop

RUN echo "/usr/bin/codeblocks > /dev/null &" > /usr/local/bin/codeblocks; chmod +x /usr/local/bin/codeblocks

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

CMD ["/bin/bash"]

