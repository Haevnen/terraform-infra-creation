# terraform-infra-creation

## Step 0: Initialize Terraform
```
terraform init
```

## Step 1: Plan Resources
```
terraform plan -var-file="vars/terraform.tfvars"
```

## Step 2: Apply Resources
```
terraform apply -var-file="vars/terraform.tfvars"