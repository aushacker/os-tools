#!/bin/bash

function cleanup() {
  echo "cleanup"
  exit 0
}

trap cleanup INT TERM

while true; do

  echo "Hello world!"
  sleep 5

done
