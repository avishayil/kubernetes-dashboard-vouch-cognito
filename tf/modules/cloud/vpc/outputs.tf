output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "vpc_nat_eip" {
  value = module.vpc.nat_public_ips[0]
}