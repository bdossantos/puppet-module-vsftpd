node default {
  include vsftpd

  vsftpd::users { 'foo':
    fullname  => 'Foo Bar'
  }
}