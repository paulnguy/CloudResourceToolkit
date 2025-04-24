#!/bin/bash

# Initialize a counter for the total number of instances
total_instances=0

# List all projects in the organization
projects=$(gcloud projects list --format="json" | jq -r '.[].projectId')

# Iterate over each project and list instances
for project in $projects; do
  echo "Listing instances for project: $project"
  # Get the number of instances in the current project
  instance_count=$(gcloud compute instances list --project $project --format="json" | jq 'length')
  echo "Number of instances in project $project: $instance_count"
  # Add the count to the total
  total_instances=$((total_instances + instance_count))
done

# Print the total number of instances
echo "Total number of instances across all projects: $total_instances"
