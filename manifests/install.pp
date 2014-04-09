# == Class: sssd::install
#
# This class installs sssd.
#
# === Authors
#
# * William Lehnertz
class sssd::install (
) {

  package { 'sssd':
    ensure  => 'present',
  }

  # package { 'sssd-client':
  #   ensure  => 'latest',
  # }

}
