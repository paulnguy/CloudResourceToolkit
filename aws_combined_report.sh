#!/bin/bash

# Authenticate AWS CLI
aws configure

# Initialize counters
total_vpcs=0
total_subnets=0
total_enis=0
total_eips=0
total_private_ips=0
total_public_zones=0
total_private_zones=0
total_public_records=0
total_private_records=0

# Count VPCs
total_vpcs=$(aws ec2 describe-vpcs --query 'Vpcs[*].VpcId' --output json | jq 'length')

# Count Subnets
total_subnets=$(aws ec2 describe-subnets --query 'Subnets[*].SubnetId' --output json | jq 'length')

# Count ENIs
total_enis=$(aws ec2 describe-network-interfaces --query 'NetworkInterfaces[*].NetworkInterfaceId' --output json | jq 'length')

# Count EIPs
total_eips=$(aws ec2 describe-addresses --query 'Addresses[*].PublicIp' --output json | jq 'length')

# Count Private IPs
total_private_ips=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddress' --output json | jq 'length')

# Count Public DNS Zones
public_zones=$(aws route53 list-hosted-zones --query 'HostedZones[?Config.PrivateZone==`false`].Id' --output json)
total_public_zones=$(echo $public_zones | jq 'length')

# Count Private DNS Zones
private_zones=$(aws route53 list-hosted-zones --query 'HostedZones[?Config.PrivateZone==`true`].Id' --output json)
total_private_zones=$(echo $private_zones | jq 'length')

# Count DNS Records per Public Zone
for zone in $(echo $public_zones | jq -r '.[]'); do
  record_count=$(aws route53 list-resource-record-sets --hosted-zone-id $zone --query 'ResourceRecordSets[*].Name' --output json | jq 'length')
  total_public_records=$((total_public_records + record_count))
done

# Count DNS Records per Private Zone
for zone in $(echo $private_zones | jq -r '.[]'); do
  record_count=$(aws route53 list-resource-record-sets --hosted-zone-id $zone --query 'ResourceRecordSets[*].Name' --output json | jq 'length')
  total_private_records=$((total_private_records + record_count))
done
# Output results
echo "Results based on current AWS account:"
echo "Total VPCs: $total_vpcs"
echo "Total Subnets: $total_subnets"
echo "Total ENIs: $total_enis"
echo "Total EIPs: $total_eips"
echo "Total Private IPs: $total_private_ips"
echo "Total Public DNS Zones: $total_public_zones"
echo "Total Private DNS Zones: $total_private_zones"
echo "Total DNS Records in Public Zones: $total_public_records"
echo "Total DNS Records in Private Zones: $total_private_records"