#!/bin/bash

function start_session() {
  tmux new-session -d -s "$1"
  tmux send-keys "$1" C-m
  tmux detach -s "$1"
}

function loadwallet() {
  eval "$1-cli" loadwallet "$1"
}

start_session bitcoind
start_session litecoind
start_session 'dashd --logtimestamps'

sleep 10

loadwallet bitcoin
loadwallet litecoin
loadwallet dash
