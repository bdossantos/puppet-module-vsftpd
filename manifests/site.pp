node default {
  class { 'vsftpd':
    force_local_data_ssl    => 'NO',
    force_local_logins_ssl  => 'NO',
    user_sub_token          => '$USER',
    local_root              => '/home/$USER',
  }

  vsftpd::users { 'foo':
    fullname  => 'Foo Bar'
  }
}