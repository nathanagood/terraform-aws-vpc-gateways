locals{
  prefix_name  = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_name
  resource_group_name = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  igw_name  = var.name != "" ? var.name : (var.vpc_name!= null && var.vpc_name!= "" ? "${var.vpc_name}-igw" : "${local.prefix_name}-igw")
  #igw_name  = var.name != "" ? var.name : "${local.prefix_name}-igw"
  igw_id = var.provision ? aws_internet_gateway.internet_gw[0].id : ""
  igw_arn = var.provision ? aws_internet_gateway.internet_gw[0].arn : ""
  vpc_id = var.provision ? data.aws_vpc.vpc[0].id : null
  
}


resource null_resource print_names {
  count = var.provision ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'VPC name: ${var.vpc_name != null && var.vpc_name != "" ? var.vpc_name : "null"}'"
  }
}

data "aws_vpc" "vpc" {
  depends_on = [
    null_resource.print_names
  ]
  count = var.provision ? 1 : 0

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "internet_gw" {
  depends_on = [
    data.aws_vpc.vpc
  ]
  #count = var.provision && var._count > 0 ?  1 : 0
  count = var.provision  ?  1 : 0

  vpc_id = local.vpc_id
  tags ={ 
      Name = local.igw_name, 
      ResourceGroup = local.resource_group_name
    }
}
