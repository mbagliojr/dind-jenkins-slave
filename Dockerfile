FROM jpetazzo/dind
MAINTAINER mbagliojr

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && \
  apt-get install -qqy software-properties-common && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -qqy oracle-java8-installer && \
  apt-get clean

RUN apt-get install -y make
RUN wget -q https://github.com/docker/fig/releases/download/1.0.1/fig-Linux-x86_64 -O /usr/local/bin/fig && chmod +x /usr/local/bin/fig
RUN wget -q https://github.com/docker/compose/releases/download/1.16.1/docker-compose-Linux-x86_64 -O /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN wget -q https://github.com/harbur/captain/releases/download/v0.7.0/captain-Linux-x86_64 -O /usr/local/bin/captain && chmod +x /usr/local/bin/captain
RUN wget -q https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.4/swarm-client-3.4.jar
CMD java -jar swarm-client-3.4.jar -master http://$MASTER_PORT_8080_TCP_ADDR:$MASTER_PORT_8080_TCP_PORT $EXTRA_PARAMS
