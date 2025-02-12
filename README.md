# hello-azure
📋 Contains a basic but secure example on how to run Unique, fully automated on every release, on Microsoft Azure.

> [!WARNING]  
> This repository is a `hello world` (that is why its called `hello-azure`) example. Unique is not responsible and liable for any inaccuracies or misinterpretations. Users of this repository must make sure to validate the contents, test accordingly and validate the applied changes with their own governance, compliance and security processes/teams!

## Components

The directory is primarily targeted towards specific personas or teams.

```
.
├── …
├── applications            # targets Application Developers and contains Unique-specific workloads
├── cluster                 # targets Day 2 IT/Cluster Operators and contains the cluster bootstrapping components
├── governance              # targets Day 1 IT/Governance and contains primarily identity and access management components
└── infrastructure          # targets Day 1 IT/Infrastructure and contains the landing zone components
```

## Branches

The repository logic bases on two main branches:

- `release` - contains the stable and tested release artefacts/configurations/files
- `preview` - contains the continously updated preview artefacts/configurations/files

<!-- https://mermaid.live/edit#pako:eNqtVMtOwzAQ_JWVpciXgtpCUfERkLhUcOCGcnGSxbEax5HjtEJRJL6GD-NLsPNQoVCIKDnFs-PZmbXsmsQ6QcJIENQyl5ZBDTTTYoUbzCgDmmBUCToBalNU6JGIl-gBIe2t4UXqsJqWqd5eGZ7HKZYOsKZCR_HotVZK2hWPvF6LU8Vl3pHveKdZGNxI3HrZXfHeJGgoo5e0aaAJgjCH9hsaD2uAqOWDwQydOdB-I4PZjhC3JkAmLCRvL68h-VBKMV7rykLv4ftNrljAfDpfnE4vTkx8Ovsk8QNxPpJ4yFWfaVdRaAQOZsFy4bR6maNiLcfGWn6J1Y-_L_fjn03HKZ2NbXk-Ll43n8FLN599qcXInv9wKMvjDmXvRP5i4IDE7xba9GRCnLa7lIl7JGrPDkn7FISEud-Em7WXbxyPV1Y_POcx6a45MboSKWFPPCvdqioSbvFGcmG4GigFzx-1Vj2peQct510C -->
```mermaid
%%{init: { 'logLevel': 'debug', 'theme': 'base', 'gitGraph': {'showBranches': true, 'showCommitLabel':true,'mainBranchName': 'preview', 'mainBranchOrder':'9'}} }%%
      gitGraph
        branch release order: 1
        commit id:"…"
        checkout preview
        commit id:"prep 2025.06-rc.1"
        commit id:"prep 2025.06-rc.2"
        commit id:"prep 2025.06-rc…"
        checkout release
        merge preview tag:"2025.06"
        checkout preview
        commit id:"prep 2025.08-rc.1"
        commit id:"prep 2025.08-rc.2"
        branch 2025.08 order:10
        commit id:"prep 2025.08-rc.3"
        commit id:"prep 2025.08-rc.4"
        checkout preview
        merge 2025.08 tag:"prep 2025.08-rc.5"
        commit id:"prep 2025.08-rc…"
        checkout release
        merge preview tag:"2025.08"
        checkout preview
        commit id:"prep 2025.08.1"
        checkout release
        merge preview tag:"2025.08.1"
        checkout preview
        commit id:"prep …"
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any changes.  See the [CONTRIBUTING](CONTRIBUTING) for more information

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
