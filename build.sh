#!/bin/bash

# NOTE: This script should be modified as you see fit or just used as
# reference to running the disk-image-create command with the rpi4 element

set -eux

# https://stackoverflow.com/a/246128
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
VENV_DIR="${SCRIPT_DIR}/dib-venv"

if [[ ! -x "$(command -v disk-image-create)" ]]; then
    if [[ ! -d "${VENV_DIR}" ]]; then
        python3 -m venv "${VENV_DIR}"
        source "${VENV_DIR}/bin/activate"
        pip install -U diskimage-builder
        deactivate
    fi
    source "${VENV_DIR}/bin/activate"
fi

export http_proxy=http://192.168.0.254:3142
export DIB_CREATE_USERNAME=mgmt
export DIB_ADD_AUTHORIZED_SSH_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8/vEPvz4foBsFFi1i2mBrf8ZEpiYFtt7VjCLfwgO4R"
export DIB_DEBIAN_COMPONENTS=main,universe,multiverse,restricted
export DIB_RELEASE=hirsute
export DIB_UBUNTU_KERNEL=linux-raspi
export ELEMENTS_PATH="${SCRIPT_DIR}/elements"

disk-image-create -t qcow2 -o ~/rpi4.qcow2 rpi4
# qemu-img convert -f qcow2 -O raw ~/rpi4.qcow2 /dev/mmcblk1
