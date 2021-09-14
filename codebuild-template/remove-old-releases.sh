#!/bin/bash

releases_folder=($(aws s3 ls s3://$S3_DEPLOY_BUCKET | awk '{print $2}'))
remove_folder_count=$(expr ${#releases_folder[@]} - $KEEP_RELEASES)
if [ $remove_folder_count > 0 ]
then
  for i in `seq 0 $(expr $remove_folder_count - 1)`
  do
    aws s3 rm s3://$S3_DEPLOY_BUCKET/${releases_folder[i]} --recursive
    echo "Removed folder: s3://$S3_DEPLOY_BUCKET/${releases_folder[i]}"
  done
fi
