class vsftpd::service {

  service { 'vsftpd':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => Class['vsftpd::install'];
  }
}