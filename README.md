[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# Ansible playbook roles for server provisioning.

Copyright (c) 2017-2018, Hans Erik Thrane

## What is it?

`ansible-playbook` for quick deployment of trading and/or development configuration to a Ubuntu 16.04 host.

## Is it required?

No.
It's a default configuration meant to help you get started quickly.

## What does it do?

* Baseline (all hosts)
	* Update and upgrade already installed system packages.
* Sysadmin (all hosts)
	* Enable NTP.
	* Install and enable sysstat.
	* Install sysadmin command-line tools.
	* Do NOT capture bash history (for security reasons).
	* Enable automatic system updates (for security reasons, not necessarily good for stabilty).
* Conda (all hosts)
	* Install the Miniconda3 package manager (system-wide).
* Tuning (trading hosts)
  * Kernel configuration (/etc/sysctl.conf).
  * Tune network stack for low latency.
* Docker (trading hosts)
	* Install the Docker container manager (system-wide).
* Infra (trading hosts)
	* Create trading user/group (for the deployment of software).
	* Create algo user/group (for the deployment of your strategies).
* Nginx (trading hosts)
	* Install the Nginx reverse proxy server.
* Redis (trading hosts)
	* Install the Redis in-memory database.
* Netdata (trading hosts)
  * Install the Netdata real-time performance and health-monitoring system.
* Prometheus (trading hosts)
	* Install the Prometheus monitoring system and time-series database.
* Roq Trading (trading hosts)
	* Install and configure gateways.
	* Configure crontab to start/stop the gateways.
* Devtools (development hosts)
	* Install development tools (mostly focused on C-style languages).
	* Default git configuration (system-wide).
	* Default vim configuration, including useful plugins (system-wide).

## How do I use it?

The playbook assumes an "ansible" sudo-enabled user has been configured on the VM.

	ansible-playbook --ask-become-pass --private-key ~/.ssh/<pem-file> --inventory-file <your inventory> site.yml

Your inventory must list the IP addresses of your VMs.
Follow the guidelines from [here](http://docs.ansible.com/ansible/latest/intro_inventory.html).
