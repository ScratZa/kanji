output "vpc_name" {
 value = module.test.vpc_name
}

output "vpc_id" {
 value = module.test.vpc_id
}

output "subnets"{
 value = module.test.vpc_subnets
}

output "resource_group" {
 value = module.test.resource_group
}