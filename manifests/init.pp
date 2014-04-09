# == Class: sssd
#
# This class installs sssd and configures it for LDAP authentication on Debian
# based machines.  It also sets up nsswitch.conf and pam to use sssd for
# authentication and groups.
#
#
# === Parameters
#
# [*filter_groups*]
#   String.  Groups to filter out of the sssd results
#   Default: root,wheel
#
# [*filter_users*]
#   String.  Users to filter out of the sssd results
#   Default: root
#
# [*ldap_base*]
#   String.  LDAP base to search for LDAP results in
#   Default: dc=example,dc=org
#
# [*ldap_uri*]
#   String.  LDAP URIs to connect to for results.  Comma separated list of hosts.
#   Default: ldap://ldap.example.org
#
# [*ldap_access_filter*]
#   String.  Filter used to search for users
#   Default: (&(objectclass=shadowaccount)(objectclass=posixaccount))
#
# [*logsagent*]
#   String.  Agent for remote log transport
#   Default: ''
#   Valid options: beaver
#
# === Examples
#
# * Installation:
#     class { 'sssd':
#       ldap_base => 'dc=mycompany,dc=com',
#       ldap_uri  => 'ldap://ldap1.mycompany.com, ldap://ldap2.mycompany.com',
#     }
#
#
# === Authors
#
# * William Lehnertz
class sssd (
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

  class { 'sssd::install': }

  class { 'sssd::config':
    debug_level                    => $debug_level,
    reconnection_retries           => $reconnection_retries,
    sbus_timeout                   => $sbus_timeout,
    services                       => $services,
    domains                        => $domains,
    filter_groups                  => $filter_groups,
    filter_users                   => $filter_users,
    offline_credentials_expiration => $offline_credentials_expiration,
    ldap_default_bind_dn           => $ldap_default_bind_dn,
    ldap_default_authtok_type      => $ldap_default_authtok_type,
    ldap_default_authtok           => $ldap_default_authtok,
    ldap_uri                       => $ldap_uri,
    ldap_search_base               => $ldap_search_base,
    ldap_id_use_start_tls          => $ldap_id_use_start_tls,
    ldap_tls_reqcert               => $ldap_tls_reqcert,
    ldap_tls_cacert                => $ldap_tls_cacert,
    ldap_schema                    => $ldap_schema,
    id_provider                    => $id_provider,
    auth_provider                  => $auth_provider,
    access_provider                => $access_provider,
    cache_credentials              => $cache_credentials,
    enumerate                      => $enumerate,
    entry_cache_timeout            => $entry_cache_timeout,
    ldap_access_filter             => $ldap_access_filter,
    ldap_group_member              => $ldap_group_member,
    ldap_group_object_class        => $ldap_group_object_class,
    ldap_group_name                => $ldap_group_name,
    ldap_network_timeout           => $ldap_network_timeout,
    ldap_account_expire_policy     => $ldap_account_expire_policy,
    ldap_access_order              => $ldap_access_order,
    ldap_user_name                 => $ldap_user_name,
    ldap_user_object_class         => $ldap_user_object_class,
    ldap_user_gecos                => $ldap_user_gecos,
    ldap_user_home_directory       => $ldap_user_home_directory,
    ldap_user_fullname             => $ldap_user_fullname,
  }

  class { 'sssd::service': }

  # Containment
  anchor { 'sssd::begin': }
  anchor { 'sssd::end': }

  Anchor['sssd::begin'] ->
  Class['sssd::install'] ->
  Class['sssd::config'] ->
  Class['sssd::service'] ->
  Anchor['sssd::end']

}
