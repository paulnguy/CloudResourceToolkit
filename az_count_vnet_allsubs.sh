#!/bin/bash

# Initialize a counter for the total number of VNets
total_vnet_count=0

# Get all subscriptions in the tenant
subscriptions=$(az account list --query '[].id' --output tsv)

# Loop through each subscription and count VNets
for subscription in $subscriptions; do
  echo "Counting VNets for subscription: $subscription"
  az account set --subscription $subscription
  vnet_count=$(az network vnet list --query "length(@)")
  echo "Number of VNets in subscription $subscription: $vnet_count"
  # Add the count to the total
  total_vnet_count=$((total_vnet_count + vnet_count))
done

# Print the total number of VNets
echo "Total number of VNets across all subscriptions: $total_vnet_count"
