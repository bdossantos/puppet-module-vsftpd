class vsftpd(
  $package_name = 'vsftpd',
  $listen_ipv6 = 'NO',
  $anonymous_enable = 'NO',
  $local_enable = 'YES',
  $write_enable = 'YES',
  $local_umask = '022',
  $anon_upload_enable = 'NO',
  $anon_mkdir_write_enable = 'NO',
  $allow_writeable_chroot = undef,
  $seccomp_sandbox = undef,
  $chroot_local_user = 'YES',
  $chroot_list_file = '',
  $chown_username = '',
  $userlist_enable = 'YES',
  $userlist_deny = 'NO',
  $userlist_file = '/etc/vsftpd.user_list',
  $user_sub_token = '',
  $local_root = '',
  $secure_chroot_dir = '/var/run/vsftpd/empty',
  $dirmessage_enable = 'YES',
  $use_localtime = 'YES',
  $xferlog_enable = 'YES',
  $xferlog_file = '/var/log/vsftpd.log',
  $syslog_enable = 'NO',
  $xferlog_std_format = 'NO',
  $log_ftp_protocol = 'NO',
  $connect_from_port_20 = 'YES',
  $idle_session_timeout = '600',
  $data_connection_timeout = '120',
  $nopriv_user = 'nobody',
  $async_abor_enable = 'NO',
  $ftpd_banner = 'Welcome to my FTP Server',
  $setproctitle_enable = 'NO',
  $rsa_cert_file = '/etc/ssl/certs/vsftpd_cert.pem',
  $rsa_private_key_file = '/etc/ssl/private/vsftpd_key.pem',
  $allow_anon_ssl = 'YES',
  $force_local_data_ssl = 'YES',
  $force_local_logins_ssl = 'YES',
  $require_ssl_reuse = 'NO',
  $ssl_tlsv1 = 'YES',
  $ssl_sslv2 = 'YES',
  $ssl_sslv3 = 'YES'
) {

  include vsftpd::install,
          vsftpd::service
}
