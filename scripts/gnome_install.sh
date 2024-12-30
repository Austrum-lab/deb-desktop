#!/bin/bash

# Install gnome packages to a system

readarray -t list < gnome_packages.txt

for i in ${list[@]}
do
  gdmp="${gdmp} ${i}"
done

apt install ${gdmp}
