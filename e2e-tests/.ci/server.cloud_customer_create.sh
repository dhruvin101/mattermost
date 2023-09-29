#!/bin/bash
set -e -u -o pipefail
cd $(dirname $0)
. .e2erc

# Check if CWS_URL is set or not
if [ -n "${CWS_URL-}" ] && [ -n "$CWS_URL" ]; then
  mme2e_log "CWS_URL is set."
else
  mme2e_log "Environment variable CWS_URL is empty or unset. It must be set to create test cloud customer."
  exit 1
fi

response=$(curl -X POST "${CWS_URL}/api/v1/internal/tests/create-customer?sku=cloud-enterprise&is_paid=true")
echo $response
echo "MM_CLOUDSETTINGS_CWSURL=${CWS_URL}" >> .env
echo "MM_CLOUDSETTINGS_CWSAPIURL=${CWS_URL}" >> .env
echo "MM_CLOUD_API_KEY=$(echo $response | jq -r .api_key)" >> .env
MM_CUSTOMER_ID=$(echo $response | jq -r .customer_id)
echo "MM_CUSTOMER_ID=$MM_CUSTOMER_ID" >> .env
echo "MM_CLOUD_INSTALLATION_ID=$(echo $response | jq -r .installation_id)" >> .env

mme2e_log "Test cloud customer created, MM_CUSTOMER_ID: $MM_CUSTOMER_ID."
