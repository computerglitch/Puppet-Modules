# == Class: autofs::install
#
# This class ensures that the distro-appropriate 
# autofs package is installed along with configuring
# the default configuration file. 

class autofs::install {
  case $operatingsystem{
    redhat, centos: {
    $package_name = ['nfs-utils', 'autofs']
    $config_file   = "/etc/sysconfig/autofs"
    package { $package_name:
        ensure  => installed,
       }
    }
    ubuntu, debian: {
    $package_name  = ['nfs-common', 'autofs']
    $config_file   = "/etc/default/autofs"
    package { $package_name:
        ensure  => installed,
       }
    }
 }
  file {
   'autofs_config':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path    => $config_file,
    source  => "puppet:///modules/autofs/autofs",
    notify  => Service[autofs];
   }
}
