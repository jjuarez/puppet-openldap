##
# Class: openldap
#
# The aim of this class is help to install and setup an OpenLDAP
# instance with some limitations well knew
#
class openldap(
  Optional[Array[String]]        $schemas,
  Optional[Array[String]]        $log_level,
  Optional[Stdlib::Absolutepath] $config_directory,
  Optional[Stdlib::Absolutepath] $module_directory,
  Optional[Stdlib::Absolutepath] $data_directory,
  Optional[Stdlib::Absolutepath] $system_config_file,
  Optional[Stdlib::Absolutepath] $pid_file,
  Optional[Stdlib::Absolutepath] $args_file,
  Optional[String]               $user,
  Optional[String]               $group,
  Optional[String]               $package_name,
  Optional[String]               $service_name,
  Optional[String]               $version,
  Optional[String]               $suffix,
  Optional[String]               $root_dn,
  String                         $root_password,
  String                         $replication_dn,
  Optional[String]               $replication_password,
  Optional[String]               $config_dn,
  String                         $config_password,
  Optional[String]               $monitor_dn,
  String                         $monitor_password,
  Optional[String]               $ldapadmins_dn,
  Optional[Integer]              $max_database_size,
  Optional[Integer]              $threads,
  Optional[Integer]              $tool_threads,
  Optional[String]               $size_limit,
  Optional[String]               $time_limit,
  Optional[Boolean]              $tls_support,
  Optional[Hash[String,String]]  $tls_configuration,
  Optional[Boolean]              $slave,
  Optional[String]               $slave_rid,
  Optional[Hash[String,String]]  $slave_configuration,
  Optional[Hash[String,String]]  $master_configuration,
  ) {

  contain '::openldap::install'
  contain '::openldap::config'
  contain '::openldap::service'

  Class['::openldap::install']
  -> Class['::openldap::config']
  ~> Class['::openldap::service']
}

