# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilise semantic versioning for its tagging.

[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, e.g  `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes.

The Terraform CLI installation instructions have change due to gpg keyring changes. We had to make reference to the lastest installation instructions in the Terraform Documentation and change the scripting for install. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built on Ubuntu.
Please consider checking your Linux Distribution and change accordingly, to the distribution needs.

[How To Check the OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version.
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Teraform CLI gpg depreciation issues we noticed that the bash scripts steps were a considerable amount more code than the installation code in our gitpod.yml file. We decided to createa bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy
- This will make it easier to debug and execute manually Terraform CLI install.
- This will allow better portabbility for other projects that need to install Terraform CLI.

#### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script. e.g `#!/bin/bash`

ChatGPT recommended we use the following format: `#!/usr/bin/env bash`

- this should allow forportability for different OS distributions.
- this will search the user's PATH for the bash executable.

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

e.g `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to pointthe script to a program to interpret it.

e.g `source ./bin/install_terraform_cli`

#### Linux Permissions and Considerations

Inorder to make our bash scripts executable we need to change the linux permissions for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively we could use the following command:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod


### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with Enviroment Variables (Env Vars)

#### env command

We can list out all Enviroment Variables (Env Vars) using the `env` command.

We can filter specific env vars using the grep command e.g `env | grep AWS_`

#### Setting and Unsetting Enviroment Variable (Env Vars)

In the terminal we can set env vars using the command `export HELLO='world'`

In the terminal we can unset env vars using the command `unset HELLO`

We can set an env var temporarily by running the command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we an set an env var without writing an export eg
```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Enviroment variables (Env Var)

We can print an env var using `echo $HELLO`

#### Scoping of Env Vars

When you open up a new bash terminal in VScode it will not be aware of the env vars that you have set in another window(i.e another terminal).

If you want your Env Vars to persist across all future bash terminals that are open or you will open, you will need to set env vars in your bash profile e.g `.bash_profile`

#### persisiting Enviroment Variables in Gitpod

We can persist env vars into Gitpod by storing them in Gitpod Secrets Storage.

```sh
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all the bash terminals opened in those workspaces.

You can also set the env vars in the `gitpod.yml` but this can only contain non sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting started Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our aws credentials are configured correctly by running the following command:
```sh
aws sts get-caller-identity
```

if it is successful you should see a json payload return that looks like this;

```json
{
    "UserId": "AIDA5UTRHSNY5TED5FSTF",  
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We will need to generate AWS CLI credits from IAM User inorder to use the AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources their providers  and modules from Terraform registry which are locatedat [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in Terraform. Providers are responsible for interacting with specific APIs or services of various cloud providers, infrastructure platforms, or external systems to create, update, and manage resources. In essence, they serve as the bridge between Terraform and the target infrastructure. In essence Terraform providers are like **connectors** that help Terraform talk to different cloud services and platforms.

[Random terraform providers](https://registry.terraform.io/providers/hashicorp/random/latest)

- **Modules** are a way to organize and reuse your infrastructure code in a structured and modular fashion, making it easier to manage and maintain complex infrastructure setups. In a way we can say Terraform modules are like pre-made customizable templates for building infrastructure, making it easier to create and manage different parts of your infrastructure without starting from scratch each time.

### Terraform Console

We can see a list if all the Terraform commands by typing `terraform`. 

#### Terraform Init

When you initialise/start a new project you run the `terraform init` command to download the binaries for the terraform providers that we will use in this project. The `terraform init` command ensures that your Terraform environment is set up correctly with the necessary plugins, modules, and backend configurations, so you can create, update, or manage your infrastructure as defined in your Terraform configuration files.

#### Terraform Plan

The `terraform plan` command is used to preview and assess the changes that Terraform will make to your infrastructure before actually applying those changes. Running this command allows us to review and verify what Terraform intends to do to our infrastructure without actually making any changes.

We can output this changeset i.e. "plan" to be passed to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

The `terraform apply` command is used to apply the changes defined in your Terraform configuration to your infrastructure. It will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.

If we want to automatically approve a destroy we can provide the auto approve flag e.g `terraform apply --auto-approve`

#### Terraform Destroy

The `terraform destroy` command is used to destroy all resources managed by your Terraform configuration. It effectively tears down your infrastructure.

If we want to automatically approve an apply we can provide the auto approve flag e.g `terraform destroy --auto-approve`


#### Terraform Lock Files

`.terraform.lock.hcl`

this file contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be commited** to your Version Control System (VSC) e.g Github


#### Terraform State Files

`terraform.tfstate`

This file contains information about the current state of your infrastructure.

This file **should not be committed** to your Version Control System (VSC) e.g Github.

This file can contain sensitive data.

If you loose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file sate.


##### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with terraform Cloud Login and Gitpod Workspaces

When attempting to run `terraform login` it will launch a bash terminal in a weird looking window like an old xp gaming view to generate a token with some prompts to navigate that window. It does not work was expected in Gitpod VSCode in the browser.

The workaround is to manually generate a token in terraform Cloud 

[Terraform Login](https://app.terraform.io/app/settings/tokens?source=terraform-login)

You will then have to create and open the file manually using the following commands

```
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Next you will provide the following code (ensure to replace the token in the file with the one you generated manually from the Terraform Login page)

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-TOKEN-HERE"
    }
  }
}    
```





