#!/bin/bash
# In the name of Allah

docker_name="chall"
external_port=10110
internal_port=9999
haproxy_port=10010

for c in `docker ps -a | grep "$docker_name\|Created\|127.0.0.1:$(echo $external_port | head -c 4)\|Exited" | awk '{print $1}'`; do
	docker rm -f $c
done

# remove old and unused images
docker images | grep none | awk '{print $3}' | xargs -I mm docker rmi -f mm

if [ -z "$1" ]
then
      echo "\$1 is empty, we will run only 1 instance!"
      docker run -dit --restart always -p 127.0.0.1:$external_port:$internal_port $docker_name
      num=1
else
	num=$1
	re='^[0-9]+$'
	if ! [[ $1 =~ $re ]] ; then
		echo "error: Not a number" >&2; exit 1
	fi
	echo "we will run $1 instance of this docker"
	for port in `seq $external_port $(echo $external_port + $num - 1| bc -l)`; do
		docker run -dit --restart always -p 127.0.0.1:$port:$internal_port $docker_name
	done
fi
