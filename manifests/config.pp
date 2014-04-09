# == Class: sssd::config
#
# This class configures sssd.
#
#
# === Authors
#
# * William Lehnertz
class sssd::config (
    $debug_level                    = '0x02F0',
    $reconnection_retries           = '3',
    $sbus_timeout                   = '30',
    $services                       = 'nss, pam',
    $domains                        = 'ad.example.com',
    $filter_groups                  = 'root,wheel',
    $filter_users                   = 'root',
    $offline_credentials_expiration = '2',
    $ldap_default_bind_dn           = 'cn=user,ou=Users,dc=example,dc=org',
    $ldap_default_authtok_type      = 'password',
    $ldap_default_authtok           = 'your_password',
    $ldap_uri                       = 'ldap://ldap.example.org',
    $ldap_search_base               = 'dc=example,dc=org',
    $ldap_id_use_start_tls          = 'true',
    $ldap_tls_reqcert               = 'demand',
    $ldap_tls_cacert                = '/etc/pki/tls/certs/ca-bundle.crt',
    $ldap_schema                    = 'ad',
    $id_provider                    = 'ldap',
    $auth_provider                  = 'ldap',
    $access_provider                = 'ldap',
    $cache_credentials              = 'true',
    $enumerate                      = 'false',
    $entry_cache_timeout            = '6000',
    $ldap_access_filter             = '(&(objectclass=shadowaccount)(objectclass=posixaccount))',
    $ldap_group_member              = 'uniquemember',
    $ldap_group_object_class        = 'posixGroup',
    $ldap_group_name                = 'cn',
    $ldap_network_timeout           = '3',
    $ldap_account_expire_policy     = 'ad',
    $ldap_access_order              = 'expire',
    $ldap_user_name                 = 'sAMAccountName',
    $ldap_user_object_class         = 'user',
    $ldap_user_gecos                = 'displayName',
    $ldap_user_home_directory       = 'unixHomeDirectory',
    $ldap_user_fullname             = 'sAMAccountName',
){

  file { '/etc/sssd/sssd.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    notify  => Class['sssd::service'],
    content => template('sssd/sssd.conf.erb'),
  }

  file { '/etc/pam.d/password-auth':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/sssd/password-auth',
  }

  file { '/etc/pam.d/system-auth':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/sssd/system-auth',
  }

  file { '/etc/nsswitch.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/sssd/nsswitch.conf',
  }
}
