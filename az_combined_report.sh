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
total_public_records=0
total_private_records=0

# Get all subscriptions
subscriptions=$(az account list --query '[].id' --output tsv)

# Iterate over each subscription
for subscription in $subscriptions; do
  echo "Processing subscription: $subscription"
  az account set --subscription $subscription

  # Get all resource groups in the subscription
  resource_groups=$(az group list --query '[].name' --output tsv)

  # Iterate over each resource group
  for resource_group in $resource_groups; do
    echo "Processing resource group: $resource_group"

    # Count VMs
    vm_count=$(az vm list --resource-group $resource_group --output table | wc -l)
    vm_count=$((vm_count - 1)) # Subtract table header
    total_vms=$((total_vms + vm_count))

    # Count Public IPs
    public_ip_count=$(az network public-ip list --resource-group $resource_group --output table | wc -l)
    public_ip_count=$((public_ip_count - 1)) # Subtract table header
    total_public_ips=$((total_public_ips + public_ip_count))

    # Count Private IPs
    private_ip_count=$(az vm list-ip-addresses --resource-group $resource_group --query "[].virtualMachine.network.privateIpAddresses[]" --output tsv | wc -l)
    total_private_ips=$((total_private_ips + private_ip_count))

    # Count VNets
    vnet_count=$(az network vnet list --resource-group $resource_group --output table | wc -l)
    vnet_count=$((vnet_count - 1)) # Subtract table header
    total_vnets=$((total_vnets + vnet_count))

    # List and count Public DNS Zones
    public_zones=$(az network dns zone list --resource-group $resource_group --query "[?zoneType=='Public'].name" --output tsv)
    total_public_zones=$(echo $public_zones | wc -l)

    # List and count Private DNS Zones
    private_zones=$(az network private-dns zone list --resource-group $resource_group --query "[].name" --output tsv)
    total_private_zones=$(echo $private_zones | wc -l)

    # Count DNS Records per Public Zone
    for zone in $public_zones; do
      echo "Processing public DNS zone: $zone"
      record_count=$(az network dns record-set list --zone-name $zone --resource-group $resource_group --query 'length(@)')
      total_public_records=$((total_public_records + record_count))
      echo "DNS records in public zone $zone: $record_count"
    done

    # Count DNS Records per Private Zone
    for zone in $private_zones; do
      echo "Processing private DNS zone: $zone"
      record_count=$(az network private-dns record-set list --zone-name $zone --resource-group $resource_group --query 'length(@)')
      total_private_records=$((total_private_records + record_count))
      echo "DNS records in private zone $zone: $record_count"
    done
  done
done

# Output results
echo "Results based on all available Azure subscriptions:"
echo "Total VMs: $total_vms"
echo "Total Public IPs: $total_public_ips"
echo "Total Private IPs: $total_private_ips"
echo "Total VNets: $total_vnets"
echo "Total Public DNS Zones: $total_public_zones"
echo "Total Private DNS Zones: $total_private_zones"
echo "Total DNS Records in Public Zones: $total_public_records"
echo "Total DNS Records in Private Zones: $total_private_records"