docker stop papaya
docker rm papaya
docker build -t restapi:php .
docker run --name papaya -d -p 80:80 restapi:php
#docker run --name papaya -d -p 80:80 -v phpvolume:/var/www/html/phpvolume  restapi:php