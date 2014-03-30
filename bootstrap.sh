#!/usr/bin/env bash

apt-get update
apt-get install -y git
apt-get install -y zip
apt-get install -y slurm-llnl
apt-get install -y r-base-core
apt-get install -y environment-modules
/usr/sbin/create-munge-key
mkdir -p /usr/local/bin/java


