#!/usr/bin/env bash
set -o xtrace

SERVER=$1
REPOSITORY=$2
PASSWORD=$3

cat << EOF > /etc/docker/daemon.json
{
  "insecure-registries": ["http://${SERVER}:80"]
}
EOF

sudo service docker restart

echo ${PASSWORD} | docker login --username foo --password-stdin

docker stop docker-web-app  && docker rm $_
echo  rmi $(docker images --filter=reference=${SERVER}/${REPOSITORY}/web-app:latest)

docker stop docker-go-service  && docker rm $_
docker rmi $(docker images --filter=reference=${SERVER}/${REPOSITORY}/go-service:latest)

export GO_SERVICE=127.0.0.1

docker run -d --name docker-web-app -p 80:80 ${SERVER}/${REPOSITORY}/web-app:latest
docker run -d --name docker-go-service -p 3000:3000 ${SERVER}/${REPOSITORY}/go-service:latest


echo "Deploy Ok"
