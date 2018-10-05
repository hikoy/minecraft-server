ansible-test:
		ansible-playbook ansible/site.yml -i ansible/development
build-vm:
		packer build -var-file=./secret/vm-conf.json packer-vm.json
build-gcp:
		packer build -var-file=./secret/gcp-conf.json packer-gcp.json
clean:
		rm -rf output-virtualbox-iso
