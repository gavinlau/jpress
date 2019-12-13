#!/bin/bash

version="$1"

if [[ "$version" == "" ]]; then
	echo "./please designated docker image version"
	exit 0
fi


mvn clean install


echo "exec : docker build . -t gavinlaucn/dy:"${version}
docker build . -t gavinlaucn/dy:${version}


echo "exec : docker push gavinlaucn/dy:"${version}
docker push gavinlaucn/dy:${version}

