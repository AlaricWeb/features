#!/usr/bin/env sh

if [ !"$(command -v zsh)" ]; then
    apk add zsh
    apk add git 
fi


echo "Helloworld";