# Manifest for Bpipe development (http://code/google/com/p/bpipe)
# File source is assumed to have the required prerequisities from:
#  * https://code.google.com/p/bpipe/wiki/DevelopmentSetup
#  * a .bashrc file with the required path variables (e.g. JAVE_HOME) 
#
# If credentials are required to git clone, uncomment the .netrc section below and edt the netrc.txt file in files

################################################################################
#Files
    file {'gitconfig':
      path    => '/home/vagrant/.gitconfig',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/gitconfig.txt"
    }

  file {'slurmconfig':
      path    => '/etc/slurm-llnl/slurm.conf',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/slurmconf.txt"
    }

# If working on a development branch on google code, .netrc may be useful.
# (1) Uncomment the following to have .netrc included in the VM
# (2) To prevent your login details being made public, ignore any changes to netrc.txt
# 	git update-index --assume-unchanged files/netrc.txt
# (3)Edit files/netrc.txt
#
    file {'netrc':
      path    => '/home/vagrant/.netrc',
      ensure  => present,
      mode    => 0600,
      source => "puppet:///files/netrc.txt"
     }

    file {'bashrc':
      path    => '/home/vagrant/.bashrc',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/bashrc.txt"
    }

    file {'groovy':
      path    => '/home/vagrant/groovy-binary-2.2.1.zip',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/groovy-binary-2.2.1.zip"
    }

    file {'java':
      path    => '/usr/local/bin/java/jdk-7u55-linux-x64.tar.gz',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/jdk-7u55-linux-x64.tar.gz",
 	before => Exec["sudo tar -xvzf /usr/local/bin/java/jdk-7u55-linux-x64.tar.gz"]
    }


################################################################################
# Exec

exec {'chown -R vagrant /home/vagrant/bpipe':
      cwd     => '/home/vagrant/',
  path    => ["/bin", "/usr/sbin"],
 	require => Exec["git clone $repo bpipe"]
    }

exec { "git clone $repo bpipe":
  cwd     => "/home/vagrant/",
  creates => "/home/vagrant/bpipe",
  path    => ["/usr/bin", "/usr/sbin"]
}

exec {"sudo tar -xvzf /usr/local/bin/java/jdk-7u55-linux-x64.tar.gz":
 cwd     => "/usr/local/bin/java",
  creates => "/usr/local/bin/java/jdk1.7.0_55",
  path    => ["/usr/bin", "/usr/sbin"]
}

exec {"unzip groovy-binary-2.2.1.zip":
 cwd     => "/home/vagrant",
  creates => "/home/vagrant/groovy-2.2.1/",
  path    => ["/usr/bin", "/usr/sbin"],
   require => File['groovy'],
    before => Exec["ln -s /home/vagrant/groovy-2.2.1/ /home/vagrant/groovy"]
}

exec {"ln -s /home/vagrant/groovy-2.2.1/ /home/vagrant/groovy":
	cwd => "/home/vagrant/",
       creates => "/home/vagrant/groovy/",	
  path    => ["/bin", "/usr/sbin"]
}

