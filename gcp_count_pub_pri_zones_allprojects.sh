#!/bin/bash

# Initialize counters for the total number count
TOTAL_PUBLIC_COUNT=0
TOTAL_PRIVATE_COUNT=0

# List all projects in the organization
projects=$(gcloud projects list --format="json" | jq -r '.[].projectId')

# Iterate over each project and list managed zones
for project in $projects; do
  echo "Listing managed public zones for project: $project"
  
  # List and count public managed zones in current project
  publicz_count=$(gcloud dns managed-zones list --project $project --filter="visibility=public" --format="json" | jq 'length')
  echo "Number of Public Managed Zones for project: $project: $publicz_count"
  
  # List and count private managed zones in current project
  privatez_count=$(gcloud dns managed-zones list --project $project --filter="visibility=private" --format="json" | jq 'length')
  echo "Number of Private Managed Zones for project: $project: $privatez_count"
  
  # Add the count to the total
  TOTAL_PUBLIC_COUNT=$((TOTAL_PUBLIC_COUNT + publicz_count))
  TOTAL_PRIVATE_COUNT=$((TOTAL_PRIVATE_COUNT + privatez_count))
done

# Print the total number of Public and Private zones
echo "Total number of PUBLIC Managed Zones across ALL projects: $TOTAL_PUBLIC_COUNT"
echo "Total number of PRIVATE Managed Zones across ALL projects: $TOTAL_PRIVATE_COUNT"
