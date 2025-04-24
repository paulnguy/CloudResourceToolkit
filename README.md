# Cloud Resource Toolkit

This repository contains a collection of shell scripts designed to automate the inventory and management of cloud resources across multiple cloud environments, including AWS, GCP, and Azure. These scripts help in collecting counts of VPCs, subnets, network interfaces, IP addresses (public/private), and DNS zones (public/private).

## Content

- Overview
- Prerequisites
- Installation
- Usage
- Scripts
-  AWS Scripts
-  GCP Scripts
-  Azure Scripts

## Prerequisite

Before using these scripts, ensure you have the following installed and configured:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html): Installation Guide
- [GCP CLI](https://cloud.google.com/sdk/docs/install) (gcloud): Installation Guide
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli): Installation Guide

Additionally, ensure you have the necessary credentials and permissions to access the cloud resources in your respective environments.

## Installation

Clone the repository to your local machine:

```bash
git clone https://github.com/your-username/CloudResourceInventoryScripts.git
cd CloudResourceInventoryScripts
```

## Usage

Each script is designed to be run from the command line. Make sure to update any placeholder values (e.g., tenant IDs, project IDs) with your actual values.

Make the script executable:

```bash
git clone https://github.com/your-username/CloudResourceInventoryScripts.git
cd CloudResourceInventoryScripts
```bash

Run the script:

```bash
./script-name.sh
```bash

## .env File Example

``` env
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
AWS_SESSION_TOKEN=your-session-token
AWS_REGION=your-region
```

## Scripts

AWS Scripts
- Count VPCs: [aws_count_vpcs.sh](aws_count_vpcs.sh)
- Count Subnets: [aws_count_subnets.sh](aws_count_subnets.sh)
- Count Network Interfaces: [aws_count_enis.sh](aws_count_enis.sh)
- Count EC2 Instances: [aws_count_ec2_instances.sh](aws_count_ec2_instances.sh)
- Count Public IPs: [aws_count_public_ips.sh](aws_count_public_ips.sh)
- Count Private IPs: [aws_count_private_ips.sh](aws_count_private_ips.sh)
- Count DNS Public Hosted Zones: [aws_count_dns_public_zones.sh](aws_count_dns_public_zones.sh)
- Count DNS Private Hosted Zones: [aws_count_dns_private_zones.sh](aws_count_dns_private_zones.sh)


GCP Scripts
- Count Instances (all projects): [gcp_count_instances_allprojects.sh](gcp_count_instances_allprojects.sh)
- Count External IPs (all projects): [gcp_count_external_ips_allprojects.sh](gcp_count_external_ips_allprojects.sh)
- Count Internal IPs (all projects): [gcp_count_internal_ips_allprojects.sh](gcp_count_internal_ips_allprojects.sh)
- Count External & Internal IPs (all projects): [gcp_count_ext_int_ips_allprojects.sh](gcp_count_ext_int_ips_allprojects.sh)
- Count VPCs (all projects): [gcp_count_vpc_allprojects.sh](gcp_count_vpc_allprojects.sh)

Azure Scripts
- Count VMs (all subscriptions): [az_count_vm_allsubs.sh](az_count_vm_allsubs.sh)
- Count Private IPs (all subscriptions): [az_count_private_ips_allsubs.sh](az_count_private_ips_allsubs.sh)
- Count Public IPs (all subscriptions): [az_count_public_ips_allsubs.sh](az_count_public_ips_allsubs.sh)
- Count Public and Private IPs (all subscriptions): [az_count_pub_private_ips_allsubs.sh](az_count_pub_private_ips_allsubs.sh)
- Count VNets (all subscriptions): [az_count_vnet_allsubs.sh](az_count_vnet_allsubs.sh)
- Count DNS Zones per subscription: [az_count_allzones_selectsub.sh](az_count_allzones_selectsub.sh)
- Count DNS Zones (all subscriptions)s: [azure_count_dns_zones.sh](az_count_allzones_allsubs.sh)

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature-branch).
3. Make your changes and commit them (git commit -am 'Add new feature').
4. Push to the branch (git push origin feature-branch).
5. Create a new Pull Request.

## License

n/a


