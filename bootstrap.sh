#!/usr/bin/env bash

apt-get update
apt-get install -y git
apt-get install -y zip
apt-get install -y slurm-llnl
/usr/sbin/create-munge-key
mkdir -p /usr/local/bin/java
mkdir -p /home/vagrant/removed
