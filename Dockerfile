FROM ubuntu:20.04

# set environment vars
ENV HADOOP_HOME /opt/hadoop
ENV HIVE_HOME /opt/hive
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# install packages
RUN \
  apt-get update && apt-get install -y \
  ssh \
  rsync \
  vim \
  openjdk-8-jdk


##########
# HADOOP #
##########

# copy over and extract hadoop, set JAVA_HOME in hadoop-env.sh, update path
COPY ./archives/hadoop-3.3.2.tar.gz /
RUN \
  tar -xzf hadoop-3.3.2.tar.gz && \
  mv hadoop-3.3.2 $HADOOP_HOME && \
  echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
  echo "PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc

# create ssh keys
RUN \
  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod 0600 ~/.ssh/authorized_keys

# copy hadoop configs
ADD configs/*xml $HADOOP_HOME/etc/hadoop/

# copy ssh config
ADD configs/ssh_config /root/.ssh/config
RUN chmod 0600 /root/.ssh/config

########
# HIVE #
########

# copy over and extract hadoop, set JAVA_HOME in hadoop-env.sh, update path
COPY ./archives/apache-hive-3.1.2-bin.tar.gz /
RUN \
  tar -xzf apache-hive-3.1.2-bin.tar.gz && \
  mv apache-hive-3.1.2-bin $HIVE_HOME && \
  echo "export HIVE_HOME=$HIVE_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
  echo "PATH=$PATH:$HIVE_HOME/bin" >> ~/.bashrc

##################
# START SERVICES #
##################

# copy script to start hadoop
ADD start-hadoop.sh start-hadoop.sh

# expose various ports
EXPOSE 8088 50070 50075 50030 50060

STOPSIGNAL SIGINT

# start hadoop
CMD bash start-hadoop.sh
