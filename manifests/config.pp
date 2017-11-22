# == Class openldap::config
#
# This class is called from openldap for service config.
#
class openldap::config inherits openldap {
  $config_file         = [$::openldap::config_directory, 'slapd.conf'].join('/')
  $slave_config_file   = [$::openldap::config_directory, 'slave.conf'].join('/')
  $schema_directory    = [$::openldap::config_directory, 'schema'].join('/')
  $schema_files        = $::openldap::schemas.map |$schema| {
    [$schema_directory, $schema].join('/')
  }

  # You could use specific bindings like these:
  # ['ldapi:///', "ldap://${facts['ipaddress']}:389/", "ldaps://${facts['ipaddress']}:636/"]
  $slapd_urls = $::openldap::tls_support ? {
    true    => ['ldapi:///', 'ldap:///', 'ldaps:///'],
    default => ['ldapi:///', 'ldap:///'],
  }

  $replication_bind_dn = "cn=${::openldap::replication_dn},${::openldap::suffix}"

  file { 'System config file':
    ensure  => present,
    path    => $::openldap::system_config_file,
    owner   => 'root',
    group   => 'root',
    content => epp('openldap/system_slapd.conf.epp', {
      'slapd_urls' =>$slapd_urls.join(' '),
    }),
  }

  file { 'Main config file':
    ensure  => present,
    path    => $config_file,
    owner   => $::openldap::user,
    group   => $::openldap::group,
    content => epp('openldap/slapd.conf.epp', {
      'schema_files'      =>$schema_files,
      'log_level'         =>$::openldap::log_level.join(' '),
      'slave_config_file' =>$slave_config_file,
    }),
  }

  if $::openldap::slave {
    file { 'Replication config file':
      ensure  => present,
      path    => $slave_config_file,
      owner   => $::openldap::user,
      group   => $::openldap::group,
      content => epp('openldap/slave.conf.epp', {
        'rid'             =>$::openldap::slave_rid,
        'provider'        =>$::openldap::slave_configuration['provider'],
        'type'            =>$::openldap::slave_configuration['type'],
        'interval'        =>$::openldap::slave_configuration['interval'],
        'search_base'     =>$::openldap::suffix,
        'scope'           =>$::openldap::slave_configuration['scope'],
        'bind_dn'         =>$replication_bind_dn,
        'credentials'     =>$::openldap::replication_password,
        'bind_method'     =>$::openldap::slave_configuration['bind_method'],
        'retry'           =>$::openldap::slave_configuration['retry'],
        'schema_checking' =>$::openldap::slave_configuration['schema_checking'],
      }),
    }
  }
}

