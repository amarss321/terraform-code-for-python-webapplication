module "vpc" {
  source             = "./vpc"
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  azs                = var.azs
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
}

module "SG" {
  source                     = "./SGroup"
  vpc_id                     = module.vpc.vpc_id
  ec2_sg_name                = "pythonwebappliaction"
  public_subnet_cidr_block   = var.public_subnets
  ec2_sg_name_for_python_api = "python-webapplication-Sg"
}

module "ec2" {
  source                     = "./ec2"
  instance_type              = var.instance_type
  ami_id                     = "ami-0c7217cdde317cfec"
  tag_name                   = "amar"
  key_name                   = var.key_name
  subnet_id                  = tolist(module.vpc.public_subnets)[0]
  sg_enable_ssh_https        = module.SG.sg_ec2_sg_ssh_http_id
  ec2_sg_name_for_python_api = module.SG.sg_ec2_for_python_api
  user_data_install_apache   = templatefile("apache.sh", {})
}

module "targetGroup" {
  source                   = "./loadbalancer-taget-group"
  lb_target_group_name     = "devops-project-TR"
  lb_target_group_port     = 5000
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.vpc.vpc_id
  ec2_instance_id          = module.ec2.dev_proj_1_ec2_instance_id
}

module "application-lb" {
  source                          = "./application-lb"
  lb_name                         = "pythonapplication"
  lb_type                         = "application"
  is_external                     = false
  sg_enable_ssh_https             = module.SG.sg_ec2_sg_ssh_http_id
  subnet_ids                      = tolist(module.vpc.public_subnets)
  tag_name                        = "dev-proj-1-alb"
  lb_target_group_arn             = module.targetGroup.dev_proj_1_lb_target_group_arn
  ec2_instance_id                 = module.ec2.dev_proj_1_ec2_instance_id
  lb_listner_port                 = 5000
  lb_listner_protocol             = "HTTP"
  lb_listner_default_action       = "forward"
  lb_https_listner_port           = 443
  lb_https_listner_protocol       = "HTTPS"
  dev_proj_1_acm_arn              = module.CM-Route53.dev_proj_1_acm_arn
  lb_target_group_attachment_port = 5000
}

module "hosted-zone" {
  source          = "./hosted-zone"
  domain_name     = "646558713315.realhandsonlabs.net"
  aws_lb_dns_name = module.application-lb.aws_lb_dns_name
  aws_lb_zone_id  = module.application-lb.aws_lb_zone_id
}

module "CM-Route53" {
  source         = "./CM-route53"
  domain_name    = "646558713315.realhandsonlabs.net"
  hosted_zone_id = module.hosted-zone.hosted_zone_id
}

module "rds" {
  source = "./rds"
  db_subnet_group_name = "private-subents"
  subnet_groups = tolist(module.vpc.private_subnets)
  rds_mysql_sg_id = module.SG.rds_mysql_sg_id
  mysql_db_identifier = "mydb"
  mysql_username = "amar"
  mysql_password = "Ssamar143s"
  mysql_dbname = "records"
}