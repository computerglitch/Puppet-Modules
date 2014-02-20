# == Define: autofs::master
# 
# autofs::master defines the calls auto.master must
# make to the other auto.* files for autofs.
# 
# == Examples:
#
# autofs::master {
#  'masterconfig':
#   auto_master => [ '/share      /etc/auto.share', 
#                    '/share2     /etc/auto.share2' ]  
#
# In this example we are adding /share and /share2 to
# /etc/auto.master
#
define autofs::master($auto_master = [])
 {
  include autofs::service
  file {
   "auto.master":
   ensure   => 'file',
   owner    => 'root',
   group    => 'root',
   mode     => '0644',
   path     => "/etc/auto.master",
   content  => template( 'autofs/auto.master.erb' ),
   notify   => Service[autofs];
 }
} 
