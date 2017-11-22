# == Class openldap::service
#
# This class is meant to be called from openldap.
# It ensure the service is running.
#
class openldap::service inherits openldap {

  service { $::openldap::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
