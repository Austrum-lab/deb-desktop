#!/bin/bash

# Install some main tools to a system

readarray -t list < base_tools.txt

for i in ${list[@]}
do
  tools="${tools} ${i}"
done

apt install ${tools}
