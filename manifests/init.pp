class haproxy_plugin (
  $plugins_dir = $haproxy_plugin::params::plugins_dir,
  $application = true,
  $agent = true
) inherits haproxy_plugin::params {

  File {
    ensure => present,
  }
# Put ddl everywhere
  file { "${plugins_dir}/agent/haproxy.ddl":
    source => "puppet:///modules/${module_name}/agent/haproxy.ddl",
  }
  if $application {
    file { "${plugins_dir}/application/haproxy.rb":
      source => "puppet:///modules/${module_name}/application/haproxy.rb",
    }
  }
  if $agent {
    file { "${plugins_dir}/agent/haproxy.rb":
      source => "puppet:///modules/${module_name}/agent/haproxy.rb",
    }
  } else {
    file { "${plugins_dir}/agent/haproxy.rb":
      ensure => absent,
    }
  }
}
