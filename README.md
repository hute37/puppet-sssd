puppet-sssd
===========

Puppet module used to delpoy sssd for ldap authentication

# NOTES
	- This module has been tested with ubuntu 12.04 With TLS.
	- It's currently being used to authenticate against AD
	- Cached accounts!
	- Server failover!
	- For information on the each varible see 
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

- *lighdm.conf* -> Used to manage the login screen 

