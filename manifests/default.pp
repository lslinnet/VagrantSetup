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
}

class php {
  package { "php5":
    ensure => present,
  }
 
  package { "php5-cli":
    ensure => present,
  }
 
  package { "php5-mysql":
    ensure => present,
  }
 
  package { "libapache2-mod-php5":
    ensure => present,
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

include apache
include php
include mysql
include groups