#!/bin/bash

# Initialize a counter for the total number of VPCs
total_vpcs=0

# List all projects in the organization
projects=$(gcloud projects list --format="json" | jq -r '.[].projectId')

# Iterate over each project and list VPCs
for project in $projects; do
  echo "Listing VPCs for project: $project"
  # List VPCs and count the number of VPCs in the current project
  vpc_count=$(gcloud compute networks list --project $project --format="json" | jq 'length')
  echo "Number of VPCs in project $project: $vpc_count"
  # Add the count to the total
  total_vpcs=$((total_vpcs + vpc_count))
done

# Print the total number of VPCs
echo "Total number of VPCs across all projects: $total_vpcs"
