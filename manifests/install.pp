class vsftpd::install {

  include vsftpd::ssl

  package { 'vsftpd':
    ensure  => 'latest',
  }

  file { $vsftpd::secure_chroot_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0754',
    require =>  Package['vsftpd'];
  }

  file { '/etc/vsftpd.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('vsftpd/vsftpd.conf.erb'),
    require => Package['vsftpd'],
    notify  => Service['vsftpd'];
  }

  file { $vsftpd::userlist_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640';
  }

  exec { 'fake-shell':
    path    => '/bin:/usr/bin',
    command => 'echo /bin/false >> /etc/shells',
    unless  => 'cat /etc/shells | grep /bin/false',
    require => Package['vsftpd'];
  }
}