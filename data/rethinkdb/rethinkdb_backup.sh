#!/bin/sh

rethinkdb-dump -c $DATA_RETHINKDB_HOST

# upload
export AWS_ACCESS_KEY_ID=$BACKUP_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$BACKUP_SECRET_ACCESS_KEY

# updating LATEST
LATEST=$(ls -t rethinkdb_dump* | head -1)
aws --endpoint-url $BACKUP_ENDPOINT s3 cp ./$LATEST s3://$BACKUP_BUCKET/$BACKUP_PATH/LATEST.tar.gz

# uploading dump
aws --endpoint-url $BACKUP_ENDPOINT s3 mv ./rethinkdb_dump* s3://$BACKUP_BUCKET/$BACKUP_PATH/
