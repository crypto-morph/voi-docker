#!/usr/bin/bash
if [[ $1 == "" ]]; then
  echo "please supply a telemetry name"
else
  export ALGORAND_DATA=/var/lib/algorand
  diagcfg telemetry name -n $1
  diagcfg telemetry enable
fi