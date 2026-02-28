provider "aws" {
    region = var.aws_region
}

provider "aws" {
    region = var.aws_region
}

module "jenkins" {
    source = "./modules/jenkins"

    // Take the root module's vpc_id value and pass it into Jenkins module's vpc_id variable
    vpc_id     = var.vpc_id
    key_name   = var.key_name
    instance_type = var.instance_type
}

