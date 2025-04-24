#!/bin/bash

# Count public DNS zones
public_dns_count=$(az network dns zone list --query "[?zoneType=='Public'].name" --output tsv | wc -l)
echo "Total public DNS zones: $public_dns_count"

# Count private DNS zones
private_dns_count=$(az network private-dns zone list --query "[].name" --output tsv | wc -l)
echo "Total private DNS zones: $private_dns_count"
