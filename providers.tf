# Default provider information.
provider "aws" {
  region = var.aws_region
}

# The provider used to create the role that can be assumed to do everything
# needed in the Images (Production) account.
provider "aws" {
  alias  = "images_production"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.images_production.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
}

# The provider used to create the role that can be assumed to do everything
# needed in the Images (Staging) account.
provider "aws" {
  alias  = "images_staging"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.images_staging.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
}

# The provider used to create resources inside the Terraform account.
provider "aws" {
  alias  = "terraform"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.terraform.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
}

# The provider used to create resources inside the Users account.
provider "aws" {
  alias  = "users"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.users.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
}
