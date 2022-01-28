php_here_dir=~/php_docker

php_here()
{
    if ! [ -n "$1" ]
    then
        printf "Setting default version to 7.4...\n"
        version='7.4'
    else
        version=$1
    fi
	printf "Starting PHP $version container...\n"
    if ! docker images php-$version-apache | grep -q 'php-'"$version"'-apache'; then
        printf "No image found, building...\n"
        owd=$PWD
        cd $php_here_dir
        docker build --build-arg PHPVERSION=$version -t php-$version-apache .        
        cd $owd
    fi
    printf "Running container...\n"
    docker run -d -p 8080:80 -p 4430:443 --name php-apache -v $PWD:/var/www/html php-$version-apache
}

php_stop()
{
	printf "Stopping PHP container...\n"
    docker stop php-apache
    if [ -n "$1" ] && [[ $1 == "rm" ]]
    then
        printf "Removing PHP container...\n"
        docker rm php-apache
    fi
}

php_rmi()
{
    if ! [ -n "$1" ]
    then
        printf "Setting default version to 7.4...\n"
        version='7.4'
    else
        version=$1
    fi
    php_stop rm
    printf "Removing PHP $version container...\n"
    docker rmi php-$version-apache
}