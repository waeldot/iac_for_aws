#!/bin/bash

kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.0"

FSID=$( aws efs describe-file-systems --query "FileSystems[*].FileSystemId" | awk '/fs-/ {print $1}' );
sed -i -E "s/fs-[0-9a-z]+\"$/${FSID:1:-1}\"/" vars.tf 

echo -e "\n[ new efs-fs-id:  $FSID ]\n"
echo "[ terraform variable for efs-fs-id ]"
grep -A 2 efs-fs-id vars.tf
