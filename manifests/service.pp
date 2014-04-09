# == Class: sssd::service
#
# This class manages the sssd service.  It is not intended to be called directly.
#
#
# === Authors
#
# * William Lehnertz
#

class sssd::service (){

  service { 'sssd':
    ensure  => 'running',
    enable  => true,
  }
}
