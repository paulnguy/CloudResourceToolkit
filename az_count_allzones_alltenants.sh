#!/bin/bash

# Array of tenant IDs
tenants=("tenant1-id" "tenant2-id" "tenant3-id")

# Initialize counts
total_public_dns_count=0
total_private_dns_count=0

# Loop through each tenant
for tenant in "${tenants[@]}"; do
  # Set the tenant
  az account set --tenant $tenant
  
  # Count public DNS zones
  public_dns_count=$(az network dns zone list --query "[?zoneType=='Public'].name" --output tsv | wc -l)
  total_public_dns_count=$((total_public_dns_count + public_dns_count))
  
  # Count private DNS zones
  private_dns_count=$(az network private-dns zone list --query "[].name" --output tsv | wc -l)
  total_private_dns_count=$((total_private_dns_count + private_dns_count))
done

echo "Total public DNS zones across all tenants: $total_public_dns_count"
echo "Total private DNS zones across all tenants: $total_private_dns_count"

