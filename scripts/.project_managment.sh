#!/bin/bash

function createpp(){
    mkdir -p ~/Documents/Projects/$1
    cd ~/Documents/Projects/$1
    git init
    git config --global user.name "Eőri Dániel"
    git config --global user.email "eori.dani@gamil.com"
    mkdir venv
    touch main.py
    python3 -m venv ~/Documents/Projects/$1/venv
    clear
    git add .
    git commit -m "Initialize project."
    openpp $1
}

function openpp(){
    cd ~/Documents/Projects/$1
    git config --global user.name "Eőri Dániel"
    git config --global user.email "eori.dani@gamil.com"
    code .
    source venv/bin/activate
}

function closepp(){
    deactivate
    cd
}