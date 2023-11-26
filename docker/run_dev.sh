#!/usr/bin/env bash
# $1: image name
# $2: container name

# use podman in MacOs, docker otherwise.
POD_CMD=podman

# change greadlink to readlink if in MacOS
SRC_ROOT=$(dirname $0)/..
echo "SRC_ROOT=$SRC_ROOT"

query_img=$($POD_CMD image list -q $1)
if [[ "$query_img" == "" ]];
then
    echo "Building image $1..."
    $POD_CMD build -f Dev.Dockerfile -t $1 $SRC_ROOT
fi

query_ctr=$($POD_CMD ps -qa --filter name=^$2)

if [[ "$query_ctr" == "" ]]; 
then
    echo "Creating container $2..."
    $POD_CMD create -p 22 --privileged --name $2 -it $1
fi

echo "Starting container $2..."
$POD_CMD start $2
$POD_CMD exec -it $2 bash
