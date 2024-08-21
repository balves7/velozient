# Velozient DevOps Assesment

This README file explains how was build the terraform code for the DevOps Assignment:1 provided by Velozient. Also it contains a how to get started with the TF code.

## Terraform Code Structure

For this scenario, it was used a module approach following the decoupled structure, where each module can be used when it is invoked in the root main.tf file. 
The good point to use this structure is for infrastructure changes, for example: adding a new resource or a new service. 
See the folder structure bellow: 
```bash
├── backend.tf
├── docs
│   ├── folder_structure.png
│   ├── state_list.png
│   ├── terraform_apply_output.png
│   └── terraform_plan.png
├── environments
│   └── dev
│       └── terraform.tfvars
├── main.tf
├── modules
│   ├── app_vms
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── db
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── network
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── web_vms
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── README.md
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf


```

There's an environment folder to maintain the variables for each environment "dev/stage/prod". When you run terraform plan/apply you need to put the "-var-file=./environment/{dev/prod/stage}/terraform.tfvars

## Folders and files
##### backend.tf
Used to set up the terraform.tfstate file in a remote backend, in this case Azure remote store.

#### docs/
Contains the screenshots of the creation process as required.

#### environments/
Contains the terraform.tfvars variables file for each environment 

#### modules/
Contains the code for resource blocks used by terraform as modules.
Modules: network, app_vm, web_vm, db.


See the example bellow: 
```bash
terraform plan --var-file=./environments/dev/terraform.tfvars
```

## Required packages
Was used a Linux machine to create and test this code with the following packages:  
* azure cli "2.63.0"
* terraform "v1.3.7"

## Usage

First you need to login into your Azure subscription with the command

```bash
az login
``` 
Now you can start the terraform to reach the backend 
```bash
terraform init
```
sample output: 
```bash
balves@tuf-desktop ~/velozient$ terraform init
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Using previously-installed hashicorp/azurerm v3.44.1

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
balves@tuf-desktop ~/velozient$

```

After initialized the backend you can run plan to check the modifications in the real scenario.

```bash
terraform plan --var-file=./environments/dev/terraform.tfvars
```

After reviewed and agreed with the changes, then you can apply the changes with the command bellow:
```bash
terraform apply --var-file=./environments/dev/terraform.tfvars
```

Sample apply output: 

```bash
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

app_vm_name = tomap({
  "vm1" = "appvm1"
})
app_vm_private_ip = tomap({
  "vm1" = "10.0.1.4"
})
sql_server_fqdn = "bebsqldbserver.database.windows.net"
web_public_ip = "104.41.56.52"
web_vm_name = tomap({
  "vm1" = "webvm1"
  "vm2" = "webvm2"
})
web_vm_private_ip = tomap({
  "vm1" = "10.0.0.6"
  "vm2" = "10.0.0.7"
})
balves@tuf-desktop ~/velozient$ 

```



## Author

[Bruno Alves](https://linkedin.com/in/brunoalves7/)
