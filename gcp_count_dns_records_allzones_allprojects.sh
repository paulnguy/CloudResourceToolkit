#!/bin/bash

echo "The process time will vary based on # of projects and zones, please be patient"

# Initialize counters for the total number of DNS records
TOTAL_PUBLIC_RECORDS=0
TOTAL_PRIVATE_RECORDS=0

# List all projects in the organization
projects=$(gcloud projects list --format="json" | jq -r '.[].projectId')

# Iterate over each project and list DNS records
for project in $projects; do
  echo "Processing project: $project"

  # List all managed zones in the current project
  zones=$(gcloud dns managed-zones list --project=$project --format="json" | jq -r '.[].name')

  for zone in $zones; do
    # Get the visibility of the zone
    visibility=$(gcloud dns managed-zones describe $zone --project=$project --format="json" | jq -r '.visibility')

    # Count DNS records in the current zone
    record_count=$(gcloud dns record-sets list --zone=$zone --project=$project --format="json" | jq 'length')

    echo "Zone: $zone, Visibility: $visibility, DNS Records: $record_count"

    # Add the count to the total based on visibility
    if [ "$visibility" == "public" ]; then
      TOTAL_PUBLIC_RECORDS=$((TOTAL_PUBLIC_RECORDS + record_count))
    elif [ "$visibility" == "private" ]; then
      TOTAL_PRIVATE_RECORDS=$((TOTAL_PRIVATE_RECORDS + record_count))
    fi
  done
done

# Print the total number of DNS records
echo "Total number of DNS Records in PUBLIC Managed Zones across ALL projects: $TOTAL_PUBLIC_RECORDS"
echo "Total number of DNS Records in PRIVATE Managed Zones across ALL projects: $TOTAL_PRIVATE_RECORDS"
echo "Total number of DNS Records across ALL projects: $((TOTAL_PUBLIC_RECORDS + TOTAL_PRIVATE_RECORDS))"