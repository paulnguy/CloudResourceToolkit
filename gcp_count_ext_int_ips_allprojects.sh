#!/bin/bash

# Initialize counters for the total number of internal and external IP addresses
total_internal_ips=0
total_external_ips=0

# List all projects in the organization
projects=$(gcloud projects list --format="json" | jq -r '.[].projectId')

# Iterate over each project and list internal and external IP addresses
for project in $projects; do
  echo "Listing IP addresses for project: $project"
  
  # List instances and filter for internal IP addresses
  internal_ip_count=$(gcloud compute instances list --project $project --format='json' | jq '[.[] | .networkInterfaces[].networkIP] | length')
  echo "Number of internal IP addresses in project $project: $internal_ip_count"
  total_internal_ips=$((total_internal_ips + internal_ip_count))
  
  # List instances and filter for external IP addresses
  external_ip_count=$(gcloud compute instances list --project $project --format='json' | jq '[.[] | .networkInterfaces[].accessConfigs[]?.natIP] | length')
