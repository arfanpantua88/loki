#!/bin/bash
cd /home
chmod +x script.py
cd /home/loki
aws s3api put-object --bucket hx-loki-test --key index/  #add a folder, name it index
aws s3 cp chunks-copy s3://<BUCKET-NAME> --recursive #please create bucket first
aws s3 cp chunks/index s3://<BUCKET-NAME>/index --recursive