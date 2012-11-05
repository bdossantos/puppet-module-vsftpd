class vsftpd::ssl {

  package { ['openssl']:
    ensure => installed,
  }

  exec { 'generate-certs':
    command => "/usr/bin/openssl req -new -inform PEM -x509 -nodes -days 999 -subj \
                '/C=FR/ST=AutoSign/O=AutoSign/localityName=AutoSign/commonName=${::fqdn}/organizationalUnitName=AutoSign/emailAddress=AutoSign/' \
                -newkey rsa:2048 -out ${vsftpd::rsa_cert_file} -keyout ${vsftpd::rsa_private_key_file}",
    unless  => "/usr/bin/test -f ${vsftpd::rsa_cert_file} &&
                /usr/bin/test -f ${vsftpd::rsa_private_key_file}",
    require => Package['vsftpd', 'openssl'],
    notify  => Service['vsftpd'],
  }

  file { [$vsftpd::rsa_cert_file, $vsftpd::rsa_private_key_file]:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Exec['generate-certs'],
  }
}