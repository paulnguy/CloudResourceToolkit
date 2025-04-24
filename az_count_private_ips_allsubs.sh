#!/bin/bash

# Array of tenant IDs
tenants=("tenant1-id" "tenant2-id" "tenant3-id")

# Initialize count
total_private_ip_count=0

# Loop through each tenant
for tenant in "${tenants[@]}"; do
  # Set the tenant
  az account set --tenant $tenant
  
  # Get the count of private IP addresses
  private_ip_count=$(az vm list-ip-addresses --query "[].virtualMachine.network.privateIpAddresses[]" --output tsv | wc -l)
  
  # Add to total count
  total_private_ip_count=$((total_private_ip_count + private_ip_count))
done

echo "Total private IP addresses across all subscriptions: $total_private_ip_count"