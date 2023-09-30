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

You can also set the env vars in the `gitpod.yml` but this can only contain non sensitive env var

