# Install Nginx web server
exec { 'update system':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure => 'installed',
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
}

file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => "
server {
  listen 80;
  server_name _;
  
  location / {
    root /var/www/html;
    index index.html;
  }

  location /redirect_me {
    return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
  }
}
",
  require => Package['nginx'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}
