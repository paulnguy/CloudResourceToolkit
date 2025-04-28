#!/bin/bash

# Authenticate Google Cloud CLI
gcloud auth login

# Initialize counters
total_instances=0
total_external_ips=0
total_internal_ips=0
total_vpcs=0
total_public_zones=0
total_private_zones=0
total_public_records=0
total_private_records=0

# List all projects
projects=$(gcloud projects list --format="json" | jq -r '.[].projectId')

# Iterate over each project
for project in $projects; do
  echo "Processing project: $project"

  # Count Instances
  instance_count=$(gcloud compute instances list --project $project --format="json" | jq 'length')
  total_instances=$((total_instances + instance_count))

  # Count External IPs
  external_ip_count=$(gcloud compute addresses list --project $project --format="json" | jq 'length')
  total_external_ips=$((total_external_ips + external_ip_count))

  # Count Internal IPs
  internal_ip_count=$(gcloud compute instances list --project $project --format='json' | jq '[.[] | .networkInterfaces[].networkIP] | length')
  total_internal_ips=$((total_internal_ips + internal_ip_count))

  # Count VPCs
  vpc_count=$(gcloud compute networks list --project $project --format="json" | jq 'length')
  total_vpcs=$((total_vpcs + vpc_count))

  # Count Public DNS Zones
  public_zones=$(gcloud dns managed-zones list --project $project --filter="visibility=public" --format="json")
  public_zone_count=$(echo $public_zones | jq 'length')
  total_public_zones=$((total_public_zones + public_zone_count))

  # Count Private DNS Zones
  private_zones=$(gcloud dns managed-zones list --project $project --filter="visibility=private" --format="json")
  private_zone_count=$(echo $private_zones | jq 'length')
  total_private_zones=$((total_private_zones + private_zone_count))

  # Count DNS Records per Public Zone
  for zone in $(echo $public_zones | jq -r '.[].name'); do
    record_count=$(gcloud dns record-sets list --zone=$zone --project=$project --format="json" | jq 'length')
    total_public_records=$((total_public_records + record_count))
  done

  # Count DNS Records per Private Zone
  for zone in $(echo $private_zones | jq -r '.[].name'); do
    record_count=$(gcloud dns record-sets list --zone=$zone --project=$project --format="json" | jq 'length')
    total_private_records=$((total_private_records + record_count))
  done
done

# Output results
echo "Results based on all available Google Cloud projects:"
echo "Total Instances: $total_instances"
echo "Total External IPs: $total_external_ips"
echo "Total Internal IPs: $total_internal_ips"
echo "Total VPCs: $total_vpcs"
echo "Total Public DNS Zones: $total_public_zones"
echo "Total Private DNS Zones: $total_private_zones"
echo "Total DNS Records in Public Zones: $total_public_records"
echo "Total DNS Records in Private Zones: $total_private_records"