# PHP Docker helper for Unix/Linux

This repo contains a couple of simple bash scripts to immediately spin up a PHP Apache environment in your current working directory, using the PHP version of your choice. 

The container will be exposed on http://localhost:8000 and https://localhost:4430

## Installation

Clone the repo to a directory of your choice.

Add execute permissions to the two included scripts:

`chmod +x php_here.sh makecerts.sh`

Open up the script `php_here.sh` and change the top line to reference whatever directory you cloned in to. For example, if you cloned this repo to `~/php_docker_helper`, the top line should be:

`php_here_dir=~/php_docker_helper`

Save the script.

Add a line to (or create if necessary) your `~/.bash_profile` script to automatically load the included `php_here.sh` script every time you launch bash:

`source /path/to/repo/php_here.sh`

Also run the above in your current shell session to enable it now (i.e. copy and paste the line above in to your terminal and hit enter).

In the repo directory, run `makecerts.sh`. This will create a subdirectory called `certs`.

Create a new directory wherever you like and add a simple test PHP script:

```php
<?php phpinfo();
```

In that directory, run the command `php_here` from your shell. This will launch a container on localhost.

Visit http://localhost:8000 in your browser, or https://localhost:4430 (and add the `ca.crt` generated in the `certs` to your system trust store to avoid browser warnings).

You will see a PHP info page for PHP 7.4.

To run any other version of PHP, just run `php_here <version number>`, e.g. `php_here 8.1`.

To stop the container, run `php_stop` from your working directory.

Run `php_stop rm` to also delete the container.

Run `php_rmi` to stop the container, delete it and delete the image so it will be rebuilt next time you run.

That's it! Hope you find this useful.