# Linux Image Build for RPi4

This repo provides a diskimage-builder element that will build a minimal
Raspberry PI 4 image. Technically this element should work for the Raspberry PI
3 as-is, but that is untested and out-of-scope. If you plan to use this for
other versions than the RPi4, expect to do some modifications.

# Prerequisites
Clone the repo:

    git clone https://github.com/SamYaple/rpi-diskimage-builder

A build helper script has been provided, but should primarily be used as a
reference as it has some local config from my build environment. If you wish to
use the `build.sh` script, you should modify it for your needs.

The following packages are needed:

 - kpartx
 - debootstrap
 - qemu-utils
 - python3-diskimage-builder

You may wish to pip install `diskimage-builder` if you need a newer version 
than what is provided in the Ubuntu repositories or if you are building on
distro that does not include the package at all.

Additional documentation for
[diskimage-builder](https://docs.openstack.org/diskimage-builder/latest/user_guide/building_an_image.html)
usage can be found upstream and should supplement this readme.

# Building with the rpi4 element

    # (optional) http_proxy pointed to apt-cacher-ng server, this value does
    #            not end up in the final image
    export http_proxy=http://192.168.0.254:3142
    
    # (optional) $DIB_CREATE_USERNAME will be created and added to the sudo
    #            group
    export DIB_CREATE_USERNAME=mgmt
    # (optional) $DIB_ADD_AUTHORIZED_SSH_KEY is added to
    #            /home/$DIB_CREATE_USERNAME/.ssh/authorized_keys
    export DIB_ADD_AUTHORIZED_SSH_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8/vEPvz4foBsFFi1i2mBrf8ZEpiYFtt7VjCLfwgO4R"
    
    export DIB_OPENSSH_SERVER_HARDENING=1
    export DIB_DEBIAN_COMPONENTS=main,universe,multiverse,restricted
    export DIB_RELEASE=hirsute
    
    # This variable doesn't actually get installed, but instead prevents the
    # normal kernel configuration in `ubuntu-minimal` from occuring
    export DIB_UBUNTU_KERNEL=linux-raspi
    
    # This should point to the local path of this cloned repository
    export ELEMENTS_PATH="~/rpi-diskimage-builder/elements"
    
    # After the above envvars have been set, you can run disk-image-create as
    # you normally would
    disk-image-create -t raw -o ~/rpi4-hirsute.raw rpi4

