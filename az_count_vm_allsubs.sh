#!/bin/bash

# Initialize a counter for the total number of VMs
total_vm_count=0

# Get all subscriptions in the tenant
subscriptions=$(az account list --query '[].id' --output tsv)

# Loop through each subscription and list VMs
for subscription in $subscriptions; do
  echo "Listing VMs for subscription: $subscription"
  az account set --subscription $subscription
  vm_count=$(az vm list --output table | wc -l)
  # Subtract 1 for the table header
  vm_count=$((vm_count - 1))
  echo "Number of VMs in subscription $subscription: $vm_count"
  # Add the count to the total
  total_vm_count=$((total_vm_count + vm_count))
done

# Print the total number of VMs
echo "Total number of VMs across all subscriptions: $total_vm_count"
