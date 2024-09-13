# Terraform

Inspired by [Gruntwork reference architecture](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example/tree/master).

### Versioning

Versions of the modules follow the [semantic versioning](https://semver.org/) specification.

- **Major** - Large impact, multiple modules, breaking changes, requires state migrations.
- **Minor** - Medium sized impact, new features, backwards compatible.
- **Patch** - Small impact, safe to apply, one or just a few modules.

#### Pull-request labelling

When you create new pull-request to terraform-modules repository, add one of the following labels, if you want to automatically create a new release on merge.

- major
- minor
- patch

#### Changelog

As part of every release new changelog entry should be generated with information about what has been changed.

#### Module usage

To use the module, reference the git tag. If the reference is not specified, HEAD of the master branch will be used.

```hcl
terraform {
  source = "git@github.com:example/example.git//dummy_module?ref=v1.2.3"
}
```

If you need to perform emergency action, you can point the module to your branch or even local directory. This approach is generally discouraged.

```hcl
terraform {
  source = "../path/to/module/example"
}
```

Alternatively with `--terragrunt-source` parameter:

```sh
$ terragrunt apply --terragrunt-source "..//path/to/module/example"
<tg output>
```

## Repository organization

The directory structure should follow the WYSIWYG principle.

```text
_envcommon
account
 └ _global
 └ region
    └ _global
    └ environment
       └ resource
```

### Where

- **Envcommon**: Contains common configurations of modules across all the environments.
- **Account**: At the top level are each of our AWS accounts, such as stage-account, prod-account, mgmt-account, etc.
- **Region**: Within each account, there can be one or more AWS regions, such as us-east-1, eu-west-1, and ap-southeast-2, where we've deployed resources. There may also be a _global folder that defines resources that are available across all the AWS regions in this account, such as IAM users, Route 53 hosted zones, and CloudTrail.
- **Environment**: Within each region, there can be one or more "environments", such as qa, stage, etc. Typically, an environment corresponds to a single VPC, which isolates that environment from everything else in that AWS account. There may also be a _global folder that defines resources that are available across all the environments in this AWS region, such as Route 53 A records, SNS topics, and ECR repos.
- **Resource**: Within each environment, we deploy all the resources for that environment, such as EC2 Instances, Auto Scaling Groups, ECS Clusters, Databases, Load Balancers, and so on.

## Deployment

At the moment changes are applied manually. In the future with help of some CI/CD tool.

### Pre-requirements

- [terraform](https://github.com/hashicorp/terraform)
- [terragrunt](https://github.com/gruntwork-io/terragrunt)

### IAM Role

IAM role `terraformer` is created in every account. This role should be used when applying the Terraform code.

### State files and locking

- S3 is used as a backend for all the state files.
- All state files are stored in a single account.
- DynamoDB is used to prevent conflicts when applying new changes.

### Deploying single targeted module

Switch to desired account/region/environment directory and run following commands.

```sh
$ teragrunt plan
<tg output>

$ terragrunt apply
<tg output>
```

### Deploying everything in account

Switch to desired directory for account, region or environment and run following commands.

```sh
$ terragrunt run-all plan
<tg output>

# !! Be careful, 'run-all apply' uses auto-apply, so it does not ask for confirmation !!
$ terragrunt run-all apply
<tg output>
```
