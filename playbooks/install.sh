#!/bin/sh

if test ! $(which ansible) && test $(which yum)
then
  echo '[ Installing Ansible on RedHat based distro ]'
  yum install libevent-devel python-devel gcc python-pip -y && pip install ansible

fi

if test $(which ansible)
then
  echo '[ Running Ansible Playbook ]'
  ansible-playbook -K -i inventory rhel-playbook.yml
fi