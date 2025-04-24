# Cloud Resource Toolkit

This repository contains a collection of shell scripts designed to automate the inventory and management of cloud resources across multiple cloud environments, including AWS, GCP, and Azure. These scripts help in collecting counts of VPCs, subnets, network interfaces, IP addresses (public/private), and DNS zones (public/private).

## Content

Overview
Prerequisites
Installation
Usage
Scripts
  AWS Scripts
  GCP Scripts
  Azure Scripts

## Prerequisite

Before using these scripts, ensure you have the following installed and configured:

AWS CLI: Installation Guide
GCP CLI (gcloud): Installation Guide
Azure CLI: Installation Guide
Additionally, ensure you have the necessary credentials and permissions to access the cloud resources in your respective environments.

## Installation

Clone the repository to your local machine:

git clone https://github.com/your-username/CloudResourceInventoryScripts.git
cd CloudResourceInventoryScripts

## Usage

Each script is designed to be run from the command line. Make sure to update any placeholder values (e.g., tenant IDs, project IDs) with your actual values.

Make the script executable:

git clone https://github.com/your-username/CloudResourceInventoryScripts.git
cd CloudResourceInventoryScripts

Run the script:

./script-name.sh

## Scripts

AWS Scripts
Count VPCs: aws_count_vpcs.sh
Count Subnets: aws_count_subnets.sh
Count Network Interfaces: aws_count_enis.sh
Count Public IPs: aws_count_public_ips.sh
Count Private IPs: aws_count_private_ips.sh
Count DNS Zones: aws_count_dns_zones.sh

GCP Scripts
Count Instances: gcp_count_instances.sh
Count External IPs: gcp_count_external_ips.sh
Count Internal IPs: gcp_count_internal_ips.sh
Count VPCs: gcp_count_vpcs.sh
Count DNS Zones: gcp_count_dns_zones.sh

Azure Scripts
Count VMs: azure_count_vms.sh
Count Public IPs: azure_count_public_ips.sh
Count Private IPs: azure_count_private_ips.sh
Count VNets: azure_count_vnets.sh
Count Subnets: azure_count_subnets.sh
Count DNS Zones: azure_count_dns_zones.sh

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature-branch).
3. Make your changes and commit them (git commit -am 'Add new feature').
4. Push to the branch (git push origin feature-branch).
5. Create a new Pull Request.

## License

n/a


