# note

This project has been superseded by the Kern Suite. Checkout the kern suite page for more info: http://kernsuite.info/

# packaging
This repository contains documentation and issues about packaged radio astronomy software. 

You can request the packaging of new radio astronomy software by opening a new issue in this repository.


# installation for Ubuntu LTS (14.04)

Make sure the universe and multiverse components are enabled in software sources (uncomment appropriate lines in ``/etc/apt/sources.list``, or use the Ubuntu Software Center or whatever). Then add the main radio astronomy repository to your Ubuntu system:

    $ sudo apt-get install -y software-properties-common
    $ sudo add-apt-repository -s ppa:radio-astro/main
    $ sudo apt-get update

now you can install the required radio-astro package using apt-get.

See https://launchpad.net/~radio-astro/+archive/ubuntu/main for a list of packages.

You can also use ``apt-get build-dep packagename`` to install all the required build dependencies for a given package. This is useful if you later want to build it from source.


# Vagrant

You can also install these packaging on any modern operating system using
virtualisation. To make your life easier we've created a simple Vagrant
setup for you, which you can use to initialise a virtual environment.

To get started:

 * Install Vagrant: https://www.vagrantup.com/
 * Checkout this git repository on your system (`git clone https://github.com/radio-astro/packaging`)
 * Run `vagrant up` in this folder
 * Run `vagrant ssh` to enter the virtual machine
 * You can install for example meqtrees with `sudo apt-get install meqtrees`


# developers

Check out the wiki for  documentation about various packaging related procedures:

https://github.com/radio-astro/packaging/wiki
