#!/bin/bash

cd /home/gitlab-runner


if [ -d "/home/gitlab-runner/rpi-image-gen" ]; then
    echo "Repository /home/gitlab-runner/rpi-image-gen already exists remove it"
    sudo rm -rf "/home/gitlab-runner/rpi-image-gen"
fi


echo "Cloning rpi-image-gen repo"
git clone https://github.com/raspberrypi/rpi-image-gen.git

cd /home/gitlab-runner/rpi-image-gen

echo "Installing rpi-image-gen dependencies"
sudo ./install_deps.sh

echo "Starting rpi-image-gen build"

#./rpi-image-gen build -c $CI_PROJECT_DIR/rpi-antidron-build-options/config/antidron.yaml 

./rpi-image-gen build -S $CI_PROJECT_DIR/rpi-antidron-build-options -c $CI_PROJECT_DIR/rpi-antidron-build-options/config/dron-model_01.yaml

echo "Copy created image to job build directory $CI_PROJECT_DIR"
sudo cp /home/gitlab-runner/rpi-image-gen/work/image-dron_$RELEASE/dron_$RELEASE.img $CI_PROJECT_DIR/dron_$RELEASE.img
#echo "Removing rpi-image-gen workspace"
#rm -Rf /mnt/rpi-image-gen
