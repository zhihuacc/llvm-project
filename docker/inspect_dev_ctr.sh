#!/bin/sh

POD_CMD=podman
echo "the container's IP and Ports:"
$POD_CMD container inspect -f 'IP: {{.NetworkSettings.IPAddress}}, Ports: {{.NetworkSettings.Ports}}' $1