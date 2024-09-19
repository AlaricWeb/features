#!/bin/sh

set -e 

apt update
PHP_VERSION="7.4"
apt install -y software-properties-common

add-apt-repository ppa:ondrej/php

apt install -y "php$($PHP_VERSION)"

