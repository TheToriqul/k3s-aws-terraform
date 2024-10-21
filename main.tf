provider "aws" {
  region     = var.aws_region
}

module "vpc" {
  source        = "./modules/vpc"
  project_name  = var.project_name
  environment   = var.environment
  vpc_cidr      = var.vpc_cidr
}

module "security" {
  source        = "./modules/security"
  project_name  = var.project_name
  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
}

module "k3s" {
  source              = "./modules/k3s"
  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  security_group_id   = module.security.k3s_sg_id
  ssh_public_key      = var.ssh_public_key
}

module "loadbalancer" {
  source             = "./modules/loadbalancer"
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_id  = module.security.lb_sg_id
  k3s_instance_id    = module.k3s.instance_id
}