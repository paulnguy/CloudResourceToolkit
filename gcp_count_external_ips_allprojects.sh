#!/bin/bash

# Initialize a counter for the total number of external IP addresses
total_ips=0

# List all projects in the organization
projects=$(gcloud projects list --format="json" | jq -r '.[].projectId')

# Iterate over each project and list external IP addresses
for project in $projects; do
  echo "Listing external IP addresses for project: $project"
  # List instances and filter for external IP addresses
  ip_count=$(gcloud compute instances list --project $project --format="json" | jq '[.[] | .networkInterfaces[].accessConfigs[]?.natIP] | length')
  echo "Number of external IP addresses in project $project: $ip_count"
  # Add the count to the total
  total_ips=$((total_ips + ip_count))
done

# Print the total number of external IP addresses
echo "Total number of external IP addresses across all projects: $total_ips"
