class apache {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }
  
  file { "/etc/apache2/sites-available/project.conf":
    require => Package["apache2"],
    ensure => file,
    owner => root,
    group => root,
    mode => 0644,
    source => "/vagrant/puppet/default.conf",
    notify => Service["apache2"]
  }
  
  file { "/etc/apache2/sites-enabled/project.conf":
    ensure => "/etc/apache2/sites-available/project.conf",
    require => File["/etc/apache2/sites-available/project.conf"],
    notify => Service["apache2"]
  }
  
  file { "/etc/apache2/sites-enabled/000-default":
    ensure => absent,
    require => File["/etc/apache2/sites-enabled/project.conf"],
    notify => Service["apache2"]
  }
  
  exec { "/usr/sbin/a2enmod rewrite":
    unless => "/bin/readlink -e /etc/apache2/mods-enabled/rewrite.load",
    notify  => Service["apache2"],
  } 
}

class libs {
  package { "imagemagick":          ensure => present }
  package { "curl":                 ensure => present }
}

class php {
  package { "php5":                 ensure => present }
  package { "php5-cli":             ensure => present }
  package { "php5-mysql":           ensure => present }
  package { "libapache2-mod-php5":  ensure => present }
  package { "php5-imagick":         ensure => present, require => Package["imagemagick"] }
  package { "php5-curl":            ensure => present, require => Package["curl"] }
  package { "php5-intl":            ensure => present }
  package { "php5-sqlite":          ensure => present }
  package { "php-apc":              ensure => present }
  
  file { ["/etc/php5/apache2/php.ini", "/etc/php5/cli/php.ini"]:
    require => Package["php5"],
    ensure => file,
    owner => root,
    group => root,
    mode => 0644,
    source => "/vagrant/puppet/php.ini",
  }
}

class mysql {
  package { "mysql-server":
    ensure => present,
  }
 
  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }
 
  exec { "set-mysql-password":
    unless  => "mysql -uroot -proot",
    path    => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password root",
    require => Service["mysql"],
 
  }
}

class groups {
  group { "puppet":
      ensure => present,
  } 
}

class users {
  user { "www-data":
    groups => ["vagrant"],
    notify  => Service["apache2"],
  }
}

include apache
include libs
include php
include mysql
include groups
include users