# Terraform Beginner Bootcamp 2023 - week 1

## Root Module Structure
Our root module structure is as follows:
```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform & Input Variables 


## Terraform Cloud Variables 

In Terraform we can set two kinds of variables:
- Environment Variables - Vars you would set in your bash terminal eg. AWS credentials. 
- Terraform Variables - Vars you would normally set in your tfvars file. 

We can set Terraform Cloud Variables to be sensitive so they are not shown visibly in the UI.


### Loading Terraform Input Variables
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_uuid"`

### var-file flag 
- TODO: document this flag!


### terrform.tfvars

This is the default file to load in terraform variables in bulk. 

## auto.tfvars

- TODO: document this function for terraform cloud 


### Order of Terraform Variables 

- TODO: ·document·which·terraform·variables·takes·precedence.




## Dealing with Configuration Drift 

## What happens if we lose our state file `terraform.tfstate`

If you lose your state file, you most likely have to tear down all of your cloud infrastructure manually. 

You can use terraform import. But it won;t work for all cloud resources. You need to check the terraform providers documentation for which resources support importing. 

### Solve Missing Resources with Terraform Import


`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

### Fix Manual Config 

If a user deletes or modifies cloud resources manually through ClickOps. 

If we run Terraform plan, it will attempt to put our infrastructure into the expected state fixing Configuration Drift. 

## Fix using Terraform Refresh 
```sh
terraform apply -refresh-only -auto-approve
```
## Terraform Modules 

### Terraform Module Structure 
It is recommended to place modules in a `modules` directory when locally developing modules. 
## Passing Input Variables

We can pass input variables ·to·our·module·

The module has to declare the terraform variables in its own variables.tf

```tf 
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources 

Using the source we can import the moddule from various places eg:

- locally 
- Github
- Terraform Registry


```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform 

Services such as ChatGPT may not have the latest documentation or info about Terraform which can provide old values that are deprecated which could potentially cause errors. 

In most cases, cross checking with the Terraform registry would be recommended. 

## Working with Files in Terraform 


### Fileexists Function
This is a built in terraform function to check the existence of a file.
```
condition     = fileexists(var.error_html_filepath)
```
[Fileexists](https://developer.hashicorp.com/terraform/language/functions/fileexists

)
### Filemd5 Function

[Filemd5 Funtion](https://developer.hashicorp.com/terraform/language/functions/filemd5)



### Path Variable 

In Terraform, there is a special variable called `path` that allows us to ref local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variables](https://developer.hashicorp.com/terraform/language/expressions/references)

```
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = ${path.root}/public/index.html"
}
```
### Terraform Locals
[Terraform Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
Locals allow us to define local variables. 
It can be very useful when we need to transform data into another format and have referenced a variable.
```tf
locals  {
    s3_origin_id = "MyS3Origin"
}
```

### Terraform Data Sources 
This allows us to source data from cloud resources.
This is useful when we want to transfer data into another format and have it referenced as a variable. 

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)


## Working with JSON 

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

We use the jseonencode to create the json policy inline in the hcl.
```tf
> jsonencode({"hello"="world"})
{"hello":"world"}

```


### Changing the Lifecycle of Resources 

[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)


### Terraform Data 

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.
[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)


## Provisioners 

Provisioners allow you to execute commands on compute instances. For example: an AWS CLI Command

They are not recommended for use by HashiCorp because Configuration management tools such as Ansible are a better fit, but the functionality exists. 

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute a command on the machine running the terraform commands. Example plan apply 

[local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}

```

## Remote-exec
This will execute commands on a machine which you target. You will need to provide credentials such as an SSH to get into the machine.

[remote-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```

## For Each Expressions

[For Each Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)

For each allows us eo enumerate over complex data types

```sh
[for s in var.list : upper(s)]

```

This is mostly useful for when you are creating multiple cloud resources and you want to reduce the amount of repetitive terraform code.