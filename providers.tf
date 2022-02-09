# Default provider information.
provider "aws" {
  default_tags {
    tags = var.tags
  }
  region = var.aws_region
}

# The provider used to create the role that can be assumed to do everything
# needed in the Images (Production) account.
provider "aws" {
  alias = "images_production"
  assume_role {
    role_arn     = data.terraform_remote_state.images_production.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
  default_tags {
    tags = var.tags
  }
  region = var.aws_region
}

# The provider used to create resources inside the Terraform account.
provider "aws" {
  alias = "terraform"
  assume_role {
    role_arn     = data.terraform_remote_state.terraform.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
  default_tags {
    # It makes no sense to associate a "Workspace" tag with the
    # Terraform read role, since it can read the state from any
    # workspace.
    #
    # Such a tag will also flip flop as one switched from staging to
    # production or vice versa, which is highly annoying.
    tags = { for k, v in var.tags : k => v if k != "Workspace" }
  }
  region = var.aws_region
}

# The provider used to create resources inside the Users account.
provider "aws" {
  alias = "users"
  assume_role {
    role_arn     = data.terraform_remote_state.users.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
  default_tags {
    tags = var.tags
  }
  region = var.aws_region
}
