# -*- mode: ruby -*-
# vi: set ft=ruby :


# defaults
BOX = ENV["BOX"] || "ubuntu/bionic64"


# this Vagrantfile is tested with this Vagrant version,
# fail if an older version is used
Vagrant.require_version ">= 2.2.14"

Vagrant.configure("2") do |config|
    # our VM is built from this box
    config.vm.box = BOX

    # automatically updated. comment or set to false to disable
    config.vm.box_check_update = true
    # assuming we run a web server in the VM,
    # we want to connect host system browsers to it
    config.vm.network "forwarded_port", guest: 80, host: 8080
    # default synced folder
    # to disable, uncomment the last part
    config.vm.synced_folder ".", "/Vagrant" #, disabled: true


    ##  PROVIDERS
    ##  =========

    # try virtualbox first, if not available try vmware
    config.vm.provider "virtualbox" do |vb|
        # configure the virtualbox machine
        vb.gui = false
        vb.customize ["modifyvm", :id, "--name", "lamp"]
        vb.customize ["modifyvm", :id, "--memory", 1024 * 4]
        vb.customize ["modifyvm", :id, "--cpuhotplug", "on"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
        vb.customize ["modifyvm", :id, "--vram", "8"]
        vb.customize ['modifyvm', :id, '--clipboard', "bidirectional"]
    end

    config.vm.provider "vmware_fusion"


    ##  PROVISIONERS
    ##  ============

    # provision by running bootstrap.sh inside the VM
    config.vm.provision :shell, path: "bootstrap.sh"

    # provision with the vagrant.yml Ansible playbook
    #config.vm.provision "ansible" do |ansible|
    #    ansible.playbook = "mariadb.yml"
    #end
end

