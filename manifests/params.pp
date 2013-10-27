class haproxy_plugin::params {
  if $::osfamily == 'windows' {
    $plugins_dir = 'c:\mcollective\plugins\mcollective'
  } else {
    $plugins_dir = '/usr/share/mcollective/plugins/mcollective'
  }
}