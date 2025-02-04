# hello-azure
📋 Contains a basic but secure example on how to run Unique, fully automated on every release, on Microsoft Azure.

## Components
The process consists of 3 components:
1. Semi-automated process of setting up the remote Terraform state and GitHub Actions automation. This is optional and only an example of how the next steps can be deployed. This is described in more detail in [governance/README.md](governance/README.md)
2. Fully-automated deployment Azure resources, split in 3 groups - identities, perimeter and workloads. Here all the Azure resources needed to run Unique are defined. This is described in more detail in [infrastructure/README.md](infrastructure/README.md)
3. Definitions of the workloads, which are deployed to the Kubernetes cluster. As an optional step, setting up GitHub runners connected to Azure VNET to be able to deploy to the AKS. This is described in more detail in [20_k8s_workloads/README.md](20_k8s_workloads/README.md)

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any changes.  See the [CONTRIBUTING](CONTRIBUTING) for more information

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
