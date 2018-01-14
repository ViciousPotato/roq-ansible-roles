[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# Provisioning.

Copyright (c) 2017-2018, Hans Erik Thrane

## What is it?

Ansible provisioning of Ubuntu 16.04 VMs.

Helps you to quickly deploy Quinclas trading and/or development hosts.

## Do I have to use it?

No.

It's a default configuration meant to help you get started quickly.
The Quinclas tool-chain doesn't require this setup.

## What does it do?

* Baseline (all hosts)
	* Update and upgrade already installed system packages.
* Sysadmin (all hosts)
	* Install sysadmin command-line tools.
	* Enable NTP.
	* Install and enable sysstat.
	* Install useful sysadmin command-line tools.
	* Do NOT capture bash history (for security reasons).
	* Enable automatic system updates (for security reasons, not necessarily good for stabilty).
* Conda (all hosts)
	* Install the Miniconda2 package manager (system-wide).
* Infra (trading hosts)
	* Create trading user/group (for the deployment of software).
	* Create algo user/group (for the deployment of your strategies).
* Consul (trading hosts)
	* Install the Consul service discovery and configuration agent.
* Prometheus (trading hosts)
	* Install the Prometheus monitoring system and time-series database.
* Redis (trading hosts)
	* Install the Redis in-memory database.
* Nginx (trading hosts)
	* Install the Nginx reverse proxy server.
* Quinclas (trading hosts)
	* Install and configure user required gateways.
* Devtools (development hosts)
	* Install development tools (mostly focused on C-style languages).
	* Default git configuration (system-wide).
	* Default vim configuration, including useful plugins (system-wide).

## How do I use it?

The playbook assumes an "ansible" sudo-enabled user has been configured on the VM.

	ansible-playbook --ask-become-pass --private-key ~/.ssh/<pem-file> --inventory-file <your inventory> site.yml

Your inventory must list the IP addresses of your VMs.
Follow the guidelines from [here](http://docs.ansible.com/ansible/latest/intro_inventory.html).

Example

	[TestVM]
	test_vm ansible_host="1.2.3.4" gateways='["femasapi"]'

	[trading:children]
	TestVM

	[development:children]
	TestVM

## China?

You might want to use mirrors to access various code repositories.

Here some useful links

* [Miniconda-latest-Linux-x86_64.sh](https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda-latest-Linux-x86_64.sh)
* [conda-forge](https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/)
