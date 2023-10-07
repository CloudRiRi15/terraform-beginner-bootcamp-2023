# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

The root module is the top-level directory in your Terraform configuration where you define your infrastructure resources and their relationships. The root module serves as the entry point for Terraform to understand and execute your infrastructure code.

Our root module structure is as follows:

- PROJECT_ROOT
  - README.md - The root module and any nested modules **should have** README files.
  - main.tf - This is the main configuration file where you define the majority of your infrastructure resources using Terraform configuration language (HCL). You declare your resources, their attributes, and relationships here.This is the primary entrypoint where all the resources are created.
  - variables.tf - In this file, you define input variables that allow you to parameterize your infrastructure code. Input variables make your configuration more flexible by allowing you to pass values into your resources dynamically. 
  - outputs.tf - This file is used to define output values that you want to expose from your infrastructure code. Output values are useful for displaying information or sharing data between different parts of your infrastructure or even other Terraform configurations.
  - providers.tf -  This is used to specify and configure the providers you intend to use in your Terraform configuration
  - terraform.tfvars - This is an optional file where you can assign values to your input variables. It stores the data of the variables we want to load into our Terraform project.


```hcl

├──PROJECT_ROOT

├── README.md             # required for root modules
├── main.tf               # everything else
├── variables.tf          # stores the structure of input variables
├── outputs.tf            # stores our outputs
├── providers.tf          # defines required providers and their configuration
├── terraform.tfvars      # the data of variables we want to load into our terraform project

```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag



### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables takes presendence.

## Dealing Configuration Drift

### Terraform Import

### What Happens if we loose our state file?

if you loose your statefile, you most likely have to tear down all your cloud infrastructure manually.

You can use terraform import but it wont for all cloud resources. You need to check the terraform providers documentation for which resources support import.



### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.example`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and deletes or modifies cloud resource manually through ClickOps

If we run terraform plan it will attempt to put our infrastructure back into the expected state fixing Configuration Drift.



