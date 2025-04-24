#!/bin/bash

# Array of tenant IDs
tenants=("tenant1-id" "tenant2-id" "tenant3-id")

# Initialize count
total_count=0

# Loop through each tenant
for tenant in "${tenants[@]}"; do
  echo "Processing tenant: $tenant"
  # Set the tenant
  az account set --tenant $tenant
  # Get the count of public IPs
  count=$(az network public-ip list --output table | wc -l)
  # Add to total count
  total_count=$((total_count + count))
done
echo "Total public IPs across all subscriptions: $total_count"
