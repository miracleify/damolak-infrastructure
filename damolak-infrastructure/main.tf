module "network" {
  source = "./modules/network"

  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  environment        = var.environment

  eip_allocation_id  = var.eip_allocation_id
}



module "security" {
  source = "./modules/security"

  vpc_id      = module.network.vpc_id
  environment = var.environment
  app_port    = 5050
}

module "registry" {
  source = "./modules/registry"

  repository_name = "damolak-app"
  environment     = var.environment
}



module "compute" {
  source = "./modules/compute"

  environment        = var.environment
  app_name           = "damolak-app"
  image_url          = module.registry.repository_url
  subnets            = module.network.private_subnets
  security_group_id  = module.security.ecs_sg_id
  app_port           = var.app_port
  target_group_arn   = module.alb.target_group_arn
}


module "alb" {
  source = "./modules/alb"

  environment        = var.environment
  vpc_id             = module.network.vpc_id
  public_subnets     = module.network.public_subnets
  alb_sg_id          = module.security.alb_sg_id
  app_port           = var.app_port
  target_group_name  = "damolak-tg"
}