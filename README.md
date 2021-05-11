# cool-images-vmimport #

[![GitHub Build Status](https://github.com/cisagov/cool-images-vmimport/workflows/build/badge.svg)](https://github.com/cisagov/cool-images-vmimport/actions)

Terraform code to create the `vmimport` service role that is required by the
[AWS VM Import/Export feature](https://docs.aws.amazon.com/vm-import/latest/userguide/what-is-vmimport.html)
to function in the Images (Production) and Images (Staging) accounts in the
COOL.

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified in [backend.tf](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified in [backend.tf](backend.tf)).
- Access to all of the Terraform remote states specified in
  [remote_states.tf](remote_states.tf).
- The following COOL accounts and roles must have been created:
  - Images (Production and Staging):
    [`cisagov/cool-accounts/images`](https://github.com/cisagov/cool-accounts/tree/develop/images)
  - Users:
    [`cisagov/cool-accounts/users`](https://github.com/cisagov/cool-accounts/tree/develop/users)
- Terraform in
  [`cisagov/cool-images-assessment-images`](https://github.com/cisagov/cool-images-assessment-images)
  must have been applied.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 3.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| aws.images\_production | ~> 3.0 |
| aws.images\_staging | ~> 3.0 |
| aws.users | ~> 3.0 |
| terraform | n/a |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_policy.vmimport_production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.vmimport_staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.vmimportexportaccess_production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.vmimportexportaccess_staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.vmimport_production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.vmimport_staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.vmimportexportaccess_production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.vmimportexportaccess_staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.vmimport_production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vmimport_staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vmimportexportaccess_production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vmimportexportaccess_staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.vmimport_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vmimport_production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vmimport_staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vmimportexportaccess_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vmimportexportaccess_production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vmimportexportaccess_staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.assessment_images](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.images_production](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.images_staging](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.users](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| vmimport\_policy\_description | The description to associate with the IAM policy that allows the permissions necessary for the vmimport service role to allow VM import/export functionality. | `string` | `"Allows permissions necessary for the AWS VM Import/Export feature to function using the specified resources."` | no |
| vmimport\_policy\_name | The name to associate with the IAM policy that allows the permissions necessary for the vmimport service role to allow VM import/export functionality. | `string` | `"Images-ServiceRoleAccess-vmimport"` | no |
| vmimport\_role\_description | The description to associate with the vmimport service role. | `string` | `"The service role that is required by the AWS VM Import/Export feature to function in this account."` | no |
| vmimportexportaccess\_role\_description | The description to associate with the IAM role and attached policy that allows the permissions necessary to use the VM Import/Export feature with the AWS CLI. | `string` | `"Allows permissions necessary to use the AWS VM Import/Export feature with the AWS CLI."` | no |
| vmimportexportaccess\_role\_name | The name to associate with the IAM role and attached policy that allows the permissions necessary to use the VM Import/Export feature with the AWS CLI. | `string` | `"Images-VMImportExportAccess"` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| vmimport\_role\_production | The ARN for the vmimport service role in the Images (Production) account. |
| vmimport\_role\_staging | The ARN for the vmimport service role in the Images (Staging) account. |
| vmimportexportaccess\_role\_production | The IAM role that can be assumed to manage VM Import/Export tasks in the Images (Production) account. |
| vmimportexportaccess\_role\_staging | The IAM role that can be assumed to manage VM Import/Export tasks in the Images (Staging) account. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is only the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
