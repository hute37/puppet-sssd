puppet-sssd
===========

Puppet module used to delpoy sssd for ldap authentication

# NOTES
- This module has been tested with ubuntu 12.04 With TLS.
- It's currently being used to authenticate against AD
- Cached accounts!
- Server failover!
- For information on the each varible click below
[fedoraproject.org](http://docs.fedoraproject.org/en-US/Fedora/15/html/Deployment_Guide/chap-SSSD_User_Guide-Configuring_Services.html)


===

# Installation:
<pre>
      class { 'sssd':
        ldap_base => 'dc=mycompany,dc=com',
        ldap_uri  => 'ldap://ldap1.mycompany.com, ldap://ldap2.mycompany.com',
      }
</pre>

===

# Extra Files

- *lighdm.conf*    ->  Used to manage the login screen  '/etc/lightdm/lightdm.conf'
- *password-auth*  ->  Can change it to what you like  (Module will put it where it goes)
- *system-auth*    ->  Same as password-auth
- *nsswitch.conf*  ->  Can change it to what you like  (Module will put it where it goes)

Be sure to restart lightdm when making changes to the associated files.

Others/optional
- *group.conf*     ->  Used to give ldap users local groups  '/etc/security/group.conf'
- Certs            ->  If using TLS you will need to put the certs for the server on the host
- '/etc/hosts'     ->  May need to add your servers so the client can resolve the hostname of the servers

