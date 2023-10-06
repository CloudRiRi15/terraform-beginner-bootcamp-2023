# Terraform Beginner Bootcamp 2023 - Week 1

- [Root Module Structure](#root-module-structure)
- [Terraform and Input Variables](#terraform-and-input-variables)
  * [Terraform Cloud Variables](#terraform-cloud-variables)
  * [Variable Declaration](#variable-declaration)
  * [Loading Terraform Input Variables](#loading-terraform-input-variables)
  * [var flag](#var-flag)
  * [terraform.tvfars](#terraformtvfars)
  * [auto.tfvars](#autotfvars)
  * [var-file flag](#var-file-flag)
  * [Order of precedence for Terraform variables](#order-of-precedence-for-terraform-variables)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


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

Terraform uses variables to parameterize your configuration and allow you to input values that can be customized for different environments or use cases. The input variables are used to define values that configure your infrastructure. These values can be used again and again without having to remember their every occurrence in the event it needs to be updated.

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Variable Declaration

To declare a variable in Terraform, you can use the `variable` block in your `.tf` files or a separate `.tf` file e.g a `variables.tf` file can have the following code that defines the variable:

```hcl
variable "user_uuid" {
  description = "The UUID of the user"
  type        = string
  validation {
    condition        = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message    = "The user_uuid value is not a valid UUID."
  }
}
```

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_id="my-user_id"`

### terraform.tvfars

`terraform.tfvars` is a filename that Terraform automatically looks for when it initializes a Terraform project. It is used to provide default values for your Terraform variables.

### auto.tfvars

- `auto.tfvars` is a special file name in Terraform that allows you to automatically load variable values without having to explicitly specify them when running `terraform apply` or `terraform plan`

### var-file flag

- We can use the `var-file` flag to specify a file containing variable values that we want to use when running terraform apply, terraform plan, or other Terraform commands. 

- The `var-file` flag allows us to provide a separate file, often in JSON or HCL (HashiCorp Configuration Language) format, to set variable values, making it easier to manage and switch between different sets of input values for our Terraform configuration.

- Using the `var-file` flag will override any default values we have set in our Terraform configuration or in variable declaration files e.g., `terraform.tfvars` or `auto.tfvars`.


### Order of precedence for Terraform variables

- Terraform follows a specific order of precedence when determining the final value of a variable:

1. Command line flags `-var` have the highest precedence.
2. Environment variables `TF_VAR_` come next.
3. Variable files `terraform.tfvars` and `auto.tfvars` are considered.
4. Default values defined in the variable declaration are used if no other value is provided.

