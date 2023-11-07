# Terraform Beginner Bootcamp 2023 - week 0

- [Semantic Versioning](#semantic-versioning)
- [Installing Terraform CLI](#installing-terraform-cli)
  * [Considerations with the terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang Considerations](#shebang-considerations)
    + [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
- [Gitpod Lifecycle  Before, Init, Command](#gitpod-lifecycle---before--init--command)
- [Working with Env Vars](#working-with-env-vars)
  * [env command](#env-command)
  * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
  * [Printing Vars](#printing-vars)
  * [Scoping of Env Vars](#scoping-of-env-vars)
  * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
  * [Terraform Init](#terraform-init)
  * [Terraform Plan](#terraform-plan)
  * [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
  * [Terraform Directory](#terraform-directory)
- [Issues with Terraform Cloud Login and Gitpod Workspaces](#issues-with-terraform-cloud-login-and-gitpod-workspaces)


## Semantic Versioning

This project will utilize semantic versioning for its tagging.
[semver.org/]https://semver.org/ 

The general format:

**MAJOR.MINOR.PATCH**,  eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Installing Terraform CLI

### Considerations with the terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform documentation and change the scripting for install. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs. 

[How to check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version
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

While fixing the CLI gpg deprecation issues we notice that bash scripts steps were a considerable amount more code/ So we decided to create a bash script to install the terraform CLI. 

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)
- This will keep the Gitpod Task file ([.gitpod.yml](./gitpod.yml)) tidy. 
- This allows us to easily debug and execute manually terraform CLI install.
- This will allow better portability for other projects that need to install terraform CLI.



#### Shebang Considerations
A Shebang (Sha-bang) tells the bash script what program that will interpret the script. e.g,. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`
- for portability for different OS distributions
- will search the user's PATH for the bash executables 

https://en.wikipedia.org/wiki/Shebang_(Unix)

## Execution Considerations 

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

e.g. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it. 

e.g. `source ./bin/install_terraform_cli`


#### Linux Permissions Considerations 

In order to make our bash scripts executable we need to change linux permission for the the script to be executable at the user mode.

```
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod


## Gitpod Lifecycle - Before, Init, Command

We need to be careful when using the Init because it will not return if we restart an existing workspace/


https://www.gitpod.io/docs/configure/workspaces/tasks




## Working with Env Vars 

### env command 

We can list out all Environment Variables using the `env` command. 

we can filter specific env vars using grep eg `env |grep AWS`


### Setting and Unsetting Env Vars 

In the terminal we can set using `export HELLO='world'`

In the terminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command 

``` sh
HELLO='World' ./bin/print_message
```

Within a bash script we can set env without writing export eg.

``` sh 
#!/usr/bin/env bash
HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo eg/ `echo $HELLO`

### Scoping of Env Vars

When you open new bash temrinals in VScode, it will not be aware of env vars that you have set in another terminal window. 

If you want Env Vars to persist across all future bash terminals, you need to set env vars in your bash profile. eg. `.bash_profile`


### Persisting Env Vars in Gitpod 

We can persist  env vars in gitpod by storing them in gitpods secrets storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the ev vars for all bash terminals opened in workspaces. 

You can also set env vars in the `.gitpod.yml` file but this can only contain non-sensitive env vars.



## AWS CLI Installation 

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`] (./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)


We can chek if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```
If it is successful, you should see a json payload return that looks like this:

```json
"UserId": "LMNOP123748QRSTUVXZ",
"Account": "12345678910",
"Arn": "arn:aws:iam::12345678910:user/Terratest"

```

We'll need to generate AWS CLI credentials from IAM User in order to use the AWS CLI.


## Terraform Basics

### Terraform Registry 

Terraform sources their providers and modules from the terraform registry site which is located at [registry.terraform.io](https://registry.terraform.io)

- **Providers** is an interface to APIs that will allow you to create resources in terraform.
- **Modules** is a set of terraform configuration files in a single directory.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Console 

We can see a list of all the terraform commands by simply typing `terraform`

### Terraform Init

At the start of a new project you can run `terraform init` to initialize and download the binaries for the terraform providers that we will be using in this project. 

### Terraform Plan 

`terraform plan`
This will let us preview the changes that terraform will make to the infrastructure before deploying it. 

### Terraform Apply 

`terraform apply`
This will run a plan and pass the changeset to be executed by terraform. Apply should prompt us yes or no.

If we want to automatically approve apply we can provide the auto approve flag `terraform apply --auto-approve`

#### Terraform Destroy 

`terraform destroy`
This will destroy resources.

You can also use the auto approve the auto approve flag to skip the approve prompt `terraform apply --auto-approve`

#### Terraform Lock Files 
`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The terraform lock file should be committed to your version country system (VCS) such as Github. 

#### Terraform State Files 

`terraform.tfstate` contains information about the current state of your infrastructure. 

This file should **not** be commited. to your version control system. 

This file can contain sensitive data. If you lose this file, you will lose the state of your infrastructure. 

`.terraform.tfstate.backup` is the previous state file state. 

### Terraform Directory 

`.terraform` directory contains binaries of terraform providers. 


## Issues with Terraform Cloud Login and Gitpod Workspaces

When trying to run `terraform login` a CLI will appear in the terminal which states that you need to generate a token. However, it does not work when executed in Gitpod VsCode via the browser. 

The workaround is to manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source
```

Then create the file manually here: 

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```

Then you will open the file: 

```sh
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (Add your token in the file):

```json
{
    "credentials": {
      "app.terraform.io": {
        "token": "Terraform-Cloud-Token"
      }
    }

}
```


Created a bash script to automate the process of generating a token from Terraform Cloud. 
The file created is located in: [bin/generate_tfrc_creds](bin/generate_tfrc_creds)
