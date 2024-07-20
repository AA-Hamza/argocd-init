#!/bin/bash

# exit when any command fails
set -e

new_ver=$1

echo "new version: $new_ver"

dockerhub="aahamza"

# Simulate release of the new docker images
docker tag nginx:1.23.3 $dockerhub/nginx:$new_ver

# Push new version to dockerhub
docker push $dockerhub/nginx:$new_ver

# Update image tag
sed -i "s/aahamza\/nginx:.*/aahamza\/nginx:$new_ver/g" ./my-app/1-deployment.yaml

# Commit and push
git add .
git commit -m "Update image to $new_ver"
git push
