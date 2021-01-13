## Vagrant MariaDB Examples

This repository was created to host a working example for Federico Razzoli's talk at FOSDEM 21: "Creating Vagrant development machines for MariaDB - HowTo and Best Practices".

https://fosdem.org/2021/schedule/event/mariadb_vagrant/


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

