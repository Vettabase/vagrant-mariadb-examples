## Vagrant MariaDB Examples

This repository was created to host a working example for Federico Razzoli's talk at FOSDEM 21: "Creating Vagrant development machines for MariaDB - HowTo and Best Practices".

This repository contains the necessary code to create a Vagrant box with MariaDB, using VirtualBox as a provider and Bash or Ansible as provisioners. Feel free to file a feature request to see an example involving a particular provider or provisioner.


## More info

The original talk's page on FOSDEM website:

https://fosdem.org/2021/schedule/event/mariadb_vagrant/

MariaDB KnowledgeBase has a section (initially contributed by Vettabase) with some documentation of using MariaDB on Vagrant, and a Vagrant overview for MariaDB users:

https://mariadb.com/kb/en/vagrant-and-mariadb/

The talk recording is available on the YouTube MariaDB Foundation channel:

https://www.youtube.com/watch?v=H7jhFFE2Sfs&list=PLaWL8LA11YjFuh_58T-U4T_9VXRVpQJWA&index=7&ab_channel=MariaDBFoundation

The slides are here:

https://www.slideshare.net/FedericoRazzoli/creating-vagrant-development-machines-with-mariadb


## Usage

To setup the machine:

```
vagrant up
```


### Provisioning

By default, provisioning is made with the `bootstrap.sh` file.

To use Ansible (the ##mariadb.yml## playbook), edit ##Vagrantfile## to comment the shell provisioning and uncomment the Ansible provisioning. You will need to install Ansible.

Once you run `vagrant up` successfully, Vagrant will know that the machinbe is provisioned. By default, repeating the command will do nothing. If you make changes to the Ansible provisioning and want the machine to be provisioned again, run:

```
vagrant up --provision
```


## Copyright and Contacts

This repository is distributed under the terms of the GNU GPL, version 3. Copyright: Vettabase Ltd.

To contact us:

* info@vettabase.com
* https://vettabase.com

