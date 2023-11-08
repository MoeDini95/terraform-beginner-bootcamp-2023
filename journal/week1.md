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
