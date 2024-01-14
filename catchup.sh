#!/usr/bin/bash
export ALGORAND_DATA=/var/lib/algorand
goal node catchup $(curl -s https://testnet-api.voi.nodly.io/v2/status|jq -r '.["last-catchpoint"]') 
goal node status -w 1000
