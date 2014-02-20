# == Define: autofs::client
# 
# autofs::client is the define for the auto.* file
# that is called from auto.master
# 
# == Examples
#
# autofs::client {
#   'home':
#    mount_name     => 'home',
#    client_mount   => [ '*  -rw,intr,noatime  nfs0:/export/home/&' ],
#             }
#
# This example would create the /etc/auto.home file
# with the following contents:
#
# *  -rw,intr,noatime  nfs0:/export/home/&
# 
define autofs::client(
  $mount_name = 'share', $client_mount = [],
  $ensure = 'present', $mode = '0644')
  {
  include autofs::service
  case $ensure {
   "present": { $real_ensure = file }
    "absent": { $real_ensure = absent }
     default: { fail("Invalid value '${ensure}' used for ensure") }
  }
  file {
   "auto${title}":
    ensure  => $real_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => $mode,
    path    => "/etc/auto.$mount_name",
    content => template( 'autofs/auto.mount.erb' ),
    notify  => Service[autofs];
  }
}
