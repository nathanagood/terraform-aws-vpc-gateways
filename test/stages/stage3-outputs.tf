output "vpc_id" {
    value = module.dev_vpc.vpc_id
}
output "vpc_name" {
    value = module.dev_vpc.vpc_name
}
output "igw_id" {
    value  = module.dev_igw.igw_id   
}
output "igw_arn" {
    value  =  module.dev_igw.igw_arn  
}

output "ids" {  
    value =  module.dev_igw.ids 
}

resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > igw-output.json"
    environment = {
      OUTPUT = jsonencode({
        vpc_name=module.dev_vpc.vpc.tags["Name"]
        vpc_id= module.dev_vpc.vpc_id
        vpc_name= module.dev_vpc.vpc_name
        igw_id= module.dev_igw.igw_id    
        igw_arn= module.dev_igw.igw_arn    
        
      })
    }
  }
}
