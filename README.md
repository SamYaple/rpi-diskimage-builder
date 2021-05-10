# Linux Image Build for RPi4

This repo provides a diskimage-builder element that will build a minimal
Raspberry PI 4 image. Technically this element should work for the Raspberry PI
3 as-is, but that is untested and out-of-scope. If you plan to use this for
other versions than the RPi4, expect to do some modifications.

At this time, this build will only work with the `hirsute` (21.04) and beyond
releases of Ubuntu.

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

    # (optional) if you want to use an apt-cacher-ng server or similiar, set this value. The
    # configuration this sets is only used during build and does not end up in the final image
    export http_proxy=http://192.168.0.254:3142
    
    # The RELEASE and DEBIAN_COMPONENTS can be adjusted as needed. Refer to upstream documentation
    export DIB_RELEASE=hirsute
    export DIB_DEBIAN_COMPONENTS=main,universe,multiverse,restricted
    
    # This variable doesn't get installed, however it does prevent incorrect kernel installs from
    # the `ubuntu-minimal` element
    export DIB_UBUNTU_KERNEL=linux-raspi
    
    # This should point to the local path of this cloned repository
    export ELEMENTS_PATH="~/rpi-diskimage-builder/elements"
    
    # After the above envvars have been set, you can run disk-image-create as you normally would
    disk-image-create -t raw -o ~/rpi4-hirsute.raw rpi4
