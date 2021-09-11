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

