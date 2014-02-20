AutoFS Puppet Module
====================
This is an autofs module I created that works with Debian and CentOS. The code should be pretty self
explanatory.

Usage Example
=============
<code>
   autofs::client {
   'home':
    mount_name     => 'home',
    client_mount   => [ '*  -rw,intr,noatime  nfs0:/export/home/&' ],
             }

   autofs::master {
   'masterconfig':
    auto_master    => [ '/home    /etc/auto.home' ];
        }
</code>


If you are not using an ENC, I would put this call in a 'site' folder inside of the manifests folder. So 
the structure would be: autofs/mainfests/site and inside of the site folder you would define your
client mounts.

As an example:
webhosts could be: autofs/manifests/site/webhosts.pp with the following content:

<code>
class autofs::site::webhosts {
   autofs::client {
   'home':
    mount_name     => 'home',
    client_mount   => [ '*        -rw,intr,noatime     nfs0:/export/home/&' ],
             }
   autofs::client {
   'opt':
    mount_name     => 'opt',
    client_mount   => [ '/opt     -rw,intr,noatime     store0:/SSD/opt' ],
             }
   autofs::master {
   'masterconfig':
    auto_master => [ '/home     /etc/auto.home',
                     '/-        /etc/auto.opt' ];
             }
}

I would make the following call from the webhosts node manifest:

<code>
node "webhost0" {
include autofs, autofs::site::techhill
}
</code>

This would generate the following autofs configuration on webhost0:

/etc/auto.master
<code>
#This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#
/home	 /etc/auto.home
/-	 /etc/auto.opt
/misc    /etc/auto.misc
/net     -hosts

+auto.master
</code>

/etc/auto.home
<code>
*        -rw,intr,noatime     nfs0:/export/home/&
</code>

/etc/auto.opt
<code>
/opt     -rw,intr,noatime     store0:/SSD/opt
</code>


