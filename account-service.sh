#!/bin/bash

set -e

## !!! Fill this !!!
export ACCOUNT_ID=
export OIDC_PROVIDER=
export NAMESPACE=
export SERVICE_ACCOUNT_NAME=
export ROLE_NAME=

###---
read -r -d '' TRUST_RELATIONSHIP <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${ACCOUNT_ID}:oidc-provider/${OIDC_PROVIDER}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${OIDC_PROVIDER}:aud": "sts.amazonaws.com",
          "${OIDC_PROVIDER}:sub": "system:serviceaccount:${NAMESPACE}:${SERVICE_ACCOUNT_NAME}"
        }
      }
    }
  ]
}
EOF
echo "${TRUST_RELATIONSHIP}" > trust.json

ROLE_ARN=aws iam create-role --role-name ${ROLE_NAME} \
    --assume-role-policy-document file://trust.json \
    | jq -r '.Role.Arn'

kubectl annotate serviceaccount -n ${NAMESPACE} \
    ${SERVICE_ACCOUNT_NAME} \
    eks.amazonaws.com/role-arn=${ROLE_ARN}