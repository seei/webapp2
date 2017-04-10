#!/bin/bash

set -o errexit -o xtrace

bucket=u-ecs-refarch-continuous-deployment

zip -j infra/deploy/templates.zip infra/templates/*

aws s3 cp infra/deploy/templates.zip "s3://${bucket}" --acl public-read
aws s3 cp --recursive infra/templates/ "s3://${bucket}/templates" --acl public-read
