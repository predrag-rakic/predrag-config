#!/usr/bin/env bash

version="v1.5"

# Setup; may be overridden by setting the corresponding environment variables:
environment=${BC_ENV:-bluecode.mobi}
sdk_host=${SDK_HOST:-BLUECODE}

# Wallet name (optional argument)
wallet=${1:-wallet}

function require {
    path_to_executable=$(which $1)
    if [ ! -x "$path_to_executable" ] ; then
        echo "Missing executable: $1"
        exit 1
    fi
}

require "openssl"
require "curl"
require "jq"
require "uuidgen"
require "sed"
require "tr"

base_path="${HOME}/.bc_wallet"
wallet_path="${base_path}/${sdk_host}/${environment}"
wallet_file="${wallet_path}/${wallet}"

if [ -r ${wallet_file} ] ; then
    echo "Loading wallet for ${environment}..."
    source ${wallet_file}
else
    echo "Setting up new wallet for ${environment}..."
    mkdir -p ${wallet_path}

    # Generate random identifiers
    device_id=$(uuidgen)
    echo "device_id=${device_id}" > ${wallet_file}

    # Register the SDK client
    key_path="${wallet_path}/${device_id}.key"
    csr_path="${wallet_path}/${device_id}.csr"
    # Legacy: RSA key pair
    # openssl req -new -newkey rsa:2048 -subj "/CN=${device_id}" -keyout ${key_path} -nodes -out ${csr_path} 2>/dev/null
    openssl ecparam -name prime256v1 -genkey -out ${key_path} 2>/dev/null
    openssl req -new -sha256 -key ${key_path} -subj "/CN=${device_id}" -out ${csr_path} 2>/dev/null
    echo "key_path=${key_path}" >> ${wallet_file}

    headers_path="${wallet_path}/${device_id}.hdr"
    response=$(curl "https://sdk-ca.${environment}/v1/clients" \
        --data-urlencode "csr@${csr_path}" \
        -H "X-Device-Id: ${device_id}" \
        -H "X-Sdk-Host: ${sdk_host}" \
        -H "User-Agent: get_token.sh (${version})" \
        -D ${headers_path} \
        2>/dev/null)
    cert_uuid=$(echo ${response} | jq -r .cert_uuid)
    jwt=$(cat ${headers_path} | grep -i "x-jwt" | sed 's/.*: *//' | tr -d '\r\n')
    echo "jwt=${jwt}" >> ${wallet_file}

    # Fetch the client certificate
    response=$(curl "https://sdk-ca.${environment}/v1/certificates/${cert_uuid}" \
        -H "X-Device-Id: ${device_id}" \
        -H "X-Sdk-Host: ${sdk_host}" \
        -H "User-Agent: get_token.sh (${version})" \
        2>/dev/null)
    cert=$(echo ${response} | jq .cert)
    cert_pem=$(sed -e 's/^"//' -e 's/"$//' <<<"$cert")
    cert_path="${wallet_path}/${device_id}.crt"
    echo -en ${cert_pem} > "${cert_path}"
    echo "cert_path=${cert_path}" >> ${wallet_file}

    # Create wallet
    response=$(curl "https://sdk-api.${environment}/v1/wallet" \
        --data-urlencode "secret=OTk5OTk=" \
        -H "Authorization: Bearer ${jwt}" \
        -H "X-Device-Id: ${device_id}" \
        -H "X-Sdk-Host: ${sdk_host}" \
        -H "User-Agent: get_token.sh (${version})" \
        --cert ${cert_path} \
        --key ${key_path} \
        2>/dev/null)
fi

# Get wallet
response=$(curl "https://sdk-api.${environment}/v1/wallet" \
    -H "Authorization: Bearer ${jwt}" \
    -H "X-Device-Id: ${device_id}" \
    -H "X-Sdk-Host: ${sdk_host}" \
    -H "User-Agent: get_token.sh (${version})" \
    --cert ${cert_path} \
    --key ${key_path} \
    2>/dev/null)
card_id=$(echo ${response} | jq -r '.cards | .[0] | .id')

if [[ "$card_id" == "null" ]]; then
    new_card_url=$(echo ${response} | jq -r .new_card_url)
    echo "Please add a card to the wallet:"
    echo ${new_card_url}
    exit 1
fi

# Get barcode
response=$(curl -v "https://sdk-api.${environment}/v1/sessions" \
    --data-urlencode "secret=OTk5OTk=" \
    --data-urlencode "card_id=${card_id}" \
    --data-urlencode "current=new" \
    --data-urlencode "stored_barcodes=" \
    -H "Authorization: Bearer ${jwt}" \
    -H "X-Device-Id: ${device_id}" \
    -H "X-Sdk-Host: ${sdk_host}" \
    -H "User-Agent: get_token.sh (${version})" \
    --cert ${cert_path} \
    --key ${key_path} \
    2>/dev/null)
current_barcode=$(echo ${response} | jq -r '.current | .barcode')
current_shortcode=$(echo ${response} | jq -r '.current | .shortcode')
offline=$(echo ${response} | jq -r '.offline | .[] | .barcode')

echo "Current: ${current_barcode} (${current_shortcode})"
echo "Offline:"
echo ${offline}

