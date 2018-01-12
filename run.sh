#!/usr/bin/env bash

if [[ $# == 0 ]]; then
	echo "syntax: --private-key <...> --inventory <...> site.yml" && exit 1
fi

ansible-playbook $@
