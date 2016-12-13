#!/bin/bash

for CID in `docker ps | awk '{ print $1 }'` ; do
	IP=`docker inspect "$CID" | grep IPAddress | tail -1 | awk '{ print $2 }' | sed 's/^\"\(.*\)\",$/\1/g'`
	IMAGE=`docker ps | grep "$CID" | awk '{ print $2 }'`
	echo "$CID with $IMAGE on $IP"
done

# end


