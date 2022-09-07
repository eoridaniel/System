#!/bin/bash

function createpp(){
    mkdir -p ~/Projects/$1
    cd ~/Projects/$1
    git init
    mkdir venv
    touch main.py
    python3 -m venv ~/Documents/Projects/$1/venv
    clear
    git add .
    git commit -m "Initialize project."
    openpp $1
}

function openpp(){
    cd ~/Projects/$1
    code .
    source venv/bin/activate
}

function closepp(){
    deactivate
    cd
}