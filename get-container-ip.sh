#!/bin/bash


if [ "$1" == "" ] ; then
	echo "Missing image name"
	exit 1
else
	IMAGE="$1"
fi

CID=`docker ps | grep $IMAGE | tail -1 | awk '{ print $1 }'`

docker inspect "$CID" | grep IPAddress | tail -1 | awk '{ print $2}' | sed 's/^\"\(.*\)\",$/\1/g'

# end


