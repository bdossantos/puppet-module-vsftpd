define vsftpd::users(
  $ingroups     = [],
  $fullname     = undef,
  $password     = undef,
  $shell        = '/bin/false',
  $ensure       = 'present',
  $managehome   = false,
  $home         = undef,
  $uid          = undef,
  $gid          = undef
) {

  if ($home == undef) {
    $real_home = "/home/${name}"
  } else {
    $real_home = $home
  }

  user { $name:
    ensure     => $ensure,
    comment    => $fullname,
    groups     => $ingroups,
    shell      => $shell,
    home       => $real_home,
    managehome => $managehome,
    uid        => $uid,
    gid        => $gid,
    password   => $password,
  }

  if $ensure == 'present' {
    exec { "allow-user-${name}":
      path    => '/bin:/usr/bin',
      command => "echo ${name} >> ${vsftpd::userlist_file}",
      unless  => "cat ${vsftpd::userlist_file} | grep ${name}",
      require => User[$name],
    }
  } else {
    exec { "deny-user-${name}":
      path    => '/bin:/usr/bin',
      command => "sed '/\$${name}/d' ${vsftpd::userlist_file} > ${vsftpd::userlist_file}_tmp \
                  && mv ${vsftpd::userlist_file}_tmp ${vsftpd::userlist_file}",
      unless  => "cat ${vsftpd::userlist_file} | grep ${name}",
    }

    exec { "lock-account-${name}":
      path    => '/bin:/usr/bin',
      command => "passwd ${name} -l",
      require => User[$name],
    }
  }
}
