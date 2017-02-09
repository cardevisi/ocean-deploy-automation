#!/bin/bash

echo ""
echo "::::::::::::::::::::::::::"
echo "Wordpress deploy in docker"
echo "::::::::::::::::::::::::::"
echo ""

if [ -d "/var/lib/docker" ]; 
then 
    echo "Docker installed!"
else 
    echo "Install docker, please..."
    exit;
fi

echo "::::::::::::::::::::::::::"
echo "Instaling Mysql database..."
echo "::::::::::::::::::::::::::"

echo "Enter a database name:"
read database_name

echo "Enter a password to database:"
read password_database

echo ":::: Stop $database_name if exists ::::"
docker stop $database_name

echo ":::: Remove $database_name if exists ::::"
docker rm $database_name

echo ":::: Run docker database ::::"
docker run --name $database_name -e MYSQL_ROOT_PASSWORD=$password_database -d mysql

echo ":::: docker run --name $database_name -e MYSQL_ROOT_PASSWORD=$password_database -d mysql ::::"

echo "::::::::::::::::::::::::::"
echo ":::: Installing wordpress by docker ::::"
echo "::::::::::::::::::::::::::"

echo "Enter a name to your blog:"
read blog_name

echo "Enter a local port:"
read localhost_port

echo "Enter a container port:"
read container_port



docker run --name blog_name --link $database_name:mysql -e WORDPRESS_DB_PASSWORD=$password_database -p localhost_port:container_port