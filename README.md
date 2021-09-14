# Multiple Projects Development Environment

## Issues & Solution

Developing with multiple PHP projects under Windows may meet several problems:
- Let all projects stay under a same domain will meet conflict of cookies and session
- Different projects may have more than one version of PHP
- The performance is weak when a large PHP project run under Windows directly
- Not easy to test an email content

To solve such issues and save time with setting up a new project, I built up a framework with [Docker](https://www.docker.com):
- Different projects have their own domains
- Let projects play in their own Docker containers, in order to prevent version conflict
- Deploy projects under LAMP environment with Docker, in order to increase performance
- Use mailhog to get email content at localhost


## Contents

- A customized router container based on `nginx` image for proxying requests to local containers
- A mailer container based on `mailhog/mailhog` image for testing email
- A `phpmailadmin` container for database management
- A network named `dev_net`


## How to Use

### Setup the framework

1. Setup [Docker Desktop](https://docs.docker.com/desktop/windows/install/) and [docker-compose](https://docs.docker.com/compose/install/)
2. Click [HERE](https://github.com/zengliwei/dev/archive/refs/heads/master.zip) to download and decompress the packet onto local
3. Make sure the 22, 80, 443 ports are free, otherwise we need to modify the .env file to use other ports
4. Run the start.cmd
5. Check whether both [http://db.localhost](http://db.localhost) and [http://mail.localhost](http://mail.localhost) work
6. Create a project in your SSH tool for the router container

### Setup a project

1. Download one of the containers from the [Environment List](#environment-List) and decompress it into `projects` folder of the framework
2. Modify the folder name for your project
3. Modify .env file to setup project name and domain name
4. Run the start.cmd
5. Setup SSH Tunnel to your project_name_web container in the router SSH project 


## Environment List

- [dev-php-5.3](https://github.com/zengliwei/dev-php-5.x/tree/5.3)
- [dev-php-5.6](https://github.com/zengliwei/dev-php-5.x/tree/5.6)
- [dev-php-7.4](https://github.com/zengliwei/dev-php-7.x/tree/7.4)
- [dev-magento](https://magento2cn.github.io/notes/appendices/dev-windows/magento.html) - Support Magento 1.9 to 2.4
- [dev-drupal-9.x](https://github.com/zengliwei/dev-drupal/tree/9.x)
- [dev-jupyter-tensorflow](https://github.com/zengliwei/dev-jupyter/tree/tensorflow)
- [dev-rabbitmq](https://github.com/zengliwei/dev-rabbitmq)
- [dev-varnish](https://github.com/zengliwei/dev-varnish)
