# == Class openldap::install
#
# This class is called from openldap for install.
#
class openldap::install inherits openldap {

  $package_ensure = $::openldap::version ? {
    /(^\d\.\d\.\d$|present|installed|latest)/ => $::openldap::version,
    default                                   => 'installed'
  }

  package { $::openldap::package_name:
    ensure => $package_ensure,
  }
}
