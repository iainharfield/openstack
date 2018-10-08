#!/bin/bash
# Contact: Iain Harfield
# Description: Configure Devstack with some minimal configuration for demo setup
# Date: 20 August 2018
#
# Instuctions:
#  1. Install this script  into the  ./devstack dircetory
#  2. copy your laptop public key into the devstack/mykey directory
#      e.g. scp -i awsIreland.pem ./.ssh/id_rsa.pub ubuntu@ec2-xx-xx-xxx-xx.eu-west-1.compute.amazonaws.com:~/devstack/mykey
#  3. run the script
#

echo "##########################################################"
echo "#" get the demo user contect for openstack CLI commands
echo "##########################################################"
. ./devstack/openrc demo demo

echo "#################################################"
echo "#" Create security groups
echo "#################################################"
openstack security group rule create default --protocol tcp --ingress --dst-port 22
openstack security group rule create default --protocol icmp

openstack security group rule list default


echo "#############################################"
echo "#" Create key
echo "#############################################"
#  Create the mykey directory and put your key file in it
#  key your laptop key. From your laptop execute something like
#     scp -i awsIreland.pem ./.ssh/id_rsa.pub ubuntu@ec2-52-50-208-36.eu-west-1.compute.amazonaws.com:~/devstack/mykey
openstack keypair create --public-key  ./myKey/id_rsa.pub  myKey


echo "#########################################################"
echo "#" Create  some floating point ip address in the project
echo "#########################################################"
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip create  public
openstack floating ip list


echo "#################################################"
echo "#" Download ubuntu  16.04 QCOW2 and VMDK images
echo "#################################################"
#mkdir myimages
file1="xenial-server-cloudimg-amd64-disk1.img"
file2="xenial-server-cloudimg-amd64-disk1.vmdk"

if [ ! -f "./myImages/$file1" ]
then
    echo "$0: File '${file1}' not found so down loading."
    curl https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img > ./myImages/xenial-server-cloudimg-amd64-disk1.img
fi

if [ ! -f "./myImages/$file2" ]
then
    echo "$0: File '${file2}' not found so down loading."
    curl https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img > ./myImages/xenial-server-cloudimg-amd64-disk1.vmdk
fi

#curl https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img > ./myimages/xenial-server-cloudimg-amd64-disk1.img
#curl https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.vmdk > ./myimages/xenial-server-cloudimg-amd64-disk1.vmdk

echo "#################################################"
echo "#" Install images into DevStack images
echo "#################################################"
openstack image create --private  --disk-format qcow2 --container-format bare  --file ./myImages/xenial-server-cloudimg-amd64-disk1.img  --property key=myKey  Ubuntu-16.04-qcow2
openstack image create --private  --disk-format vmdk  --container-format bare  --file ./myImages/xenial-server-cloudimg-amd64-disk1.vmdk  --property key=myKey  Ubuntu-16.04-vmdk
openstack image create --private  --disk-format qcow2 --container-format bare  --file ./myImages/ubuntu-16.04-sb10.3-4.img  --property key=myKey  Ubuntu-16.04-sb10.3-4
openstack image list


echo "#################################################"
echo "#" Get the list of Projects 
echo "#" Use the Demo ID in your OpenBaton vim config    
echo "#################################################"
openstack project list
