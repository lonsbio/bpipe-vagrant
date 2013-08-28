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

    file {'gradle':
      path    => '/home/vagrant/gradle-1.0-all.zip',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/gradle-1.0-all.zip"
    }

    file {'groovy':
      path    => '/home/vagrant/groovy-binary-1.8.9.zip',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/groovy-binary-1.8.9.zip"
    }

    file {'javajdk1.6':
      path    => '/usr/local/bin/java/jdk-6u35-linux-x64.bin',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/jdk-6u35-linux-x64.bin",
 	before => Exec["sudo bash /usr/local/bin/java/jdk-6u35-linux-x64.bin"]
    }

  file {'jarmail':
      path    => '/home/vagrant/bpipe/local-lib/mail.jar',
      ensure  => present,
      mode    => 0644,
      source => "puppet:///files/mail.jar",
 	require => Exec["git clone $repo bpipe"]
    }


################################################################################
# Exec

exec {'chown -R vagrant /home/vagrant/bpipe':
      cwd     => '/home/vagrant/',
  path    => ["/bin", "/usr/sbin"],
 	require => Exec["git clone $repo bpipe"]
    }

#Gridgain dependency currently tricky - removing executor source for the moment. 
exec {'mv bpipe/src/main/groovy/bpipe/executor/Gridgain* /home/vagrant/removed/':
      cwd     => '/home/vagrant/',
	creates => '/home/vagrant/removed/GridgainProvider.groovy',
  path    => ["/bin", "/usr/sbin"],
 	require => Exec["git clone $repo bpipe"]
    }

exec { "git clone $repo bpipe":
  cwd     => "/home/vagrant/",
  creates => "/home/vagrant/bpipe",
  path    => ["/usr/bin", "/usr/sbin"]
}

exec {"sudo bash /usr/local/bin/java/jdk-6u35-linux-x64.bin":
 cwd     => "/usr/local/bin/java",
  creates => "/usr/local/bin/java/jdk1.6.0_35",
  path    => ["/usr/bin", "/usr/sbin"]
}

exec {"unzip gradle-1.0-all.zip":
 cwd     => "/home/vagrant",
  creates => "/home/vagrant/gradle-1.0/",
  path    => ["/usr/bin", "/usr/sbin"],
   require => File['gradle'], 
	before => Exec["ln -s /home/vagrant/groovy-1.8.9/ /home/vagrant/groovy && ln -s /home/vagrant/gradle-1.0/ /home/vagrant/gradle"]
}

exec {"unzip groovy-binary-1.8.9.zip":
 cwd     => "/home/vagrant",
  creates => "/home/vagrant/groovy-1.8.9/",
  path    => ["/usr/bin", "/usr/sbin"],
   require => File['groovy'],
    before => Exec["ln -s /home/vagrant/groovy-1.8.9/ /home/vagrant/groovy && ln -s /home/vagrant/gradle-1.0/ /home/vagrant/gradle"]
}

exec {"ln -s /home/vagrant/groovy-1.8.9/ /home/vagrant/groovy && ln -s /home/vagrant/gradle-1.0/ /home/vagrant/gradle":
	cwd => "/home/vagrant/",
       creates => "/home/vagrant/groovy/",	
  path    => ["/bin", "/usr/sbin"]
}

