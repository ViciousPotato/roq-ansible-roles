# Ansible Playbook

Copyright (c) 2017-2018, Hans Erik Thrane

## What is it?

A trivial playbook to provision a VM.

_Currently supporting Ubuntu, only._

## What does it do?

* Baseline
	* Update and upgrade installed packages.
* Sysadmin
	* Install sysadmin command-line tools.
	* Enable NTP.
	* Install and enable sysstat.
	* Install useful sysadmin command-line tools.
	* Do NOT capture bash history (for security reasons).
	* Enable automatic system updates (for security reasons).
* Devtools
	* Install development tools (mostly focused on C-style languages).
	* Default git configuration (system-wide).
	* Default vim configuration, including useful plugins (system-wide).
* Conda
	* Install Miniconda2 (system-wide).

## How do I use it?

The playbook assumes an "ansible" sudo-enabled user has been configured on the VM.

	ansible-playbook --ask-become-pass --private-key ~/.ssh/<pem-file> --inventory-file <your inventory> site.yml

Your inventory contains the IP addresses of your VM(s).
Follow the guidelines from [here](http://docs.ansible.com/ansible/latest/intro_inventory.html).

Example

	[TestVM]
	test_vm ansible_host="1.2.3.4"

## China?

You might want to use mirrors to access various code repositories.

Here some useful links

* [Miniconda-latest-Linux-x86_64](https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda-latest-Linux-x86_64.sh)
* [conda-forge](https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/)
