#!/bin/bash

# Authenticate Azure CLI
az login

# Initialize counters
total_vms=0
total_public_ips=0
total_private_ips=0
total_vnets=0
total_public_zones=0
total_private_zones=0

# Get all subscriptions
subscriptions=$(az account list --query '[].id' --output tsv)

# Iterate over each subscription
for subscription in $subscriptions; do
  echo "Processing subscription: $subscription"
  az account set --subscription $subscription

  # Count VMs
  vm_count=$(az vm list --output table | wc -l)
  vm_count=$((vm_count - 1)) # Subtract table header
  total_vms=$((total_vms + vm_count))

  # Count Public IPs
  public_ip_count=$(az network public-ip list --output table | wc -l)
  public_ip_count=$((public_ip_count - 1)) # Subtract table header
  total_public_ips=$((total_public_ips + public_ip_count))

  # Count Private IPs
  private_ip_count=$(az vm list-ip-addresses --query "[].virtualMachine.network.privateIpAddresses[]" --output tsv | wc -l)
  total_private_ips=$((total_private_ips + private_ip_count))

  # Count VNets
  vnet_count=$(az network vnet list --output table | wc -l)
  vnet_count=$((vnet_count - 1)) # Subtract table header
  total_vnets=$((total_vnets + vnet_count))

  # Count Public DNS Zones
  public_zone_count=$(az network dns zone list --query "[?zoneType=='Public'].name" --output tsv | wc -l)
  total_public_zones=$((total_public_zones + public_zone_count))

  # Count Private DNS Zones
  private_zone_count=$(az network private-dns zone list --query "[].name" --output tsv | wc -l)
  total_private_zones=$((total_private_zones + private_zone_count))
done

# Output results
echo "Results based on all available Azure subscriptions:"
echo "Total VMs: $total_vms"
echo "Total Public IPs: $total_public_ips"
echo "Total Private IPs: $total_private_ips"
echo "Total VNets: $total_vnets"
echo "Total Public DNS Zones: $total_public_zones"
echo "Total Private DNS Zones: $total_private_zones"
