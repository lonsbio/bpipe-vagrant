bpipe-vagrant
=============

Vagrant configuration for Bpipe (https://code.google.com/p/bpipe/) development.

Prerequisites
----
- Vagrant (http://www.vagrantup.com/) installed
- Virtualbox (https://www.virtualbox.org/) installed
- Additional binaries for Groovy, Gradle, Java and JavaMail - See Files below.

Caveats
----
- Tested on Ubuntu 13.04 x64 VM
- Uses a mixture of shell and Puppet provisioning - the order is fixed at the moment
- Should work on apt based systems, which are hard coded for some installations
- GridGain source files are removed from the git clone - include the binary and remove this step from init.pp if you want GridGain support 


Quick Start
----

Checkout code. Requires command line git. Download manually from GitHub otherwise.

	git clone https://github.com/lonsbio/bpipe-vagrant.git
	cd bpipe-vagrant

Edit files/gitconfig.txt to ensure changes are pushed under your name:

	vi files/gitconfig.txt 

Get the required additional binaries and place them in the `files` directory. See the Files section below for detail. Note: Java 1.6 and JavaMail may require login to download. Groovy and Gradle can be downloaded directly. For example, using wget on the command line:

	wget -P files http://dist.groovy.codehaus.org/distributions/groovy-binary-1.8.9.zip 
	wget -P files http://services.gradle.org/distributions/gradle-1.0-all.zip

Add a vagrant box and name it in line with manifests/init.pp, e.g. ubuntu-raring-x64 from http://cloud-images.ubuntu.com/

	vagrant box add ubuntu-raring-x64 http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box

 Start machine from the top level directory. This will be /vagrant inside your VM. Source code will be in /home/vagrant/bpipe 

	vagrant up

Enter machine

	vagrant ssh

Build the source code 

	cd /home/vagrant/bpipe
	gradle dist

Run tests.

	cd /home/vagrant/bpipe/tests
	./run.sh 

Run bpipe

	./bin/bpipe

Edit the source, build, commit etc


License
----
MIT license, see LICENSE


## Customisation ##

####Vagrantfile####
Customise the following:

- config.vm.box -> match this to a named Vagrant box you've added to your system.
- puppet.facter --> Modify if you wish to clone from a source other than https://code.google.com/p/bpipe/. This will probably require the use of .netrc  


####Files####
Configuration files that are served to the Puppet provisioner:

	bashrc.txt = ~/.bashrc 		--> based on Ubuntu 13.04 default bashrc, defines JAVE_HOME, GROOVY_HOME and GRADLE_HOME
	gitconfig.txt = ~/.gitconf 	--> name and email address for git
	netrc.txt = ~/.netrc		--> allow git automation if accessing a non-public repository (optional)

In addition to the configuration files, the following need to be obtained and included in this folder as 
per https://code.google.com/p/bpipe/wiki/DevelopmentSetup 

For example:

	gradle-1.0-all.zip
	groovy-binary-1.8.9.zip
	mail.jar			--> from JavaMail
	jdk-6u35-linux-x64.bin 		--> This can be any Java 1.6 JDK compatible with your virtual box

Any changes to the Java, Groovy or Gradle versions need to be reflected in manifests/init.pp as well.

####Manifest####

Manifest by default assumes:
- Gradle 1.0, Groovy 1.8.9 and Java 6u35 x64. 
- .netrc is not required

