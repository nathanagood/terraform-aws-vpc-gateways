module "dev_igw"{
    source = "./module"
    provision = var.provision && var.cloud_provider == "aws" ? true : false
    resource_group_name = var.resource_group_name
    name_prefix = var.name_prefix
    vpc_name=module.dev_vpc.vpc_name
    
}