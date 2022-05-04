## Network configuration

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "gateway" {
  source = "./modules/gateway"
  vpc_id = module.vpc.id
}

module "security" {
  source      = "./modules/security group"
  name        = "RU_SG"
  description = "Public Security Group"
  vpc_id      = module.vpc.id
  cidr_block  = ["0.0.0.0/0"]
}

module "rtable_A" {
  source         = "./modules/rtable"
  cidr           = "0.0.0.0/0"
  gateway_id     = module.gateway.id
  vpc_id         = module.vpc.id
  subnet_id      = module.subnet_A.id
  route_table_id = module.rtable_A.id
}

module "subnet_A" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.id
  ippublic          = true
  subnet_tag        = "Public_A"
  cidr              = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

module "network_interface_Jenkins" {
  source      = "./modules/network"
  private_ips = ["10.0.2.10"]
  subnet_id   = module.subnet_B.id
  security    = [module.security.id]
}

module "JenkinsBastion" {
  source               = "./modules/instance"
  instance_type        = "t2.micro"
  key                  = "devops_rampup"
  ami                  = "ami-0c02fb55956c7d316"
  name                 = "JenkinsBastion"
  userdata             = "user-data-jenkins.sh"
  network_interface_id = module.network_interface_Jenkins.id
  security             = [module.security.id]
}

module "rtable_B" {
  source         = "./modules/rtable"
  cidr           = "0.0.0.0/0"
  gateway_id     = module.gateway.id
  vpc_id         = module.vpc.id
  subnet_id      = module.subnet_B.id
  route_table_id = module.rtable_B.id
}

module "subnet_B" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.id
  ippublic          = true
  subnet_tag        = "Public_B"
  cidr              = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

module "subnet_private" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.id
  subnet_tag        = "Private_A"
  cidr              = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  ippublic          = false
}

module "network_interface_k8s_master" {
  source      = "./modules/network"
  private_ips = ["10.0.3.10"]
  subnet_id   = module.subnet_private.id
  security    = [module.security.private_SG_id]
}

module "k8s_master" {
  source               = "./modules/instance"
  instance_type        = "t2.medium"
  key                  = "devops_rampup"
  ami                  = "ami-04505e74c0741db8d" //Ubuntu AMI
  name                 = "K8s_master"
  userdata             = "user-data-k8s-master.sh"
  network_interface_id = module.network_interface_k8s_master.id
  security             = [module.security.private_SG_id]
}

module "network_interface_k8s_worker" {
  source      = "./modules/network"
  private_ips = ["10.0.3.11"]
  subnet_id   = module.subnet_private.id
  security    = [module.security.private_SG_id]
}

module "k8s_worker" {
  source               = "./modules/instance"
  instance_type        = "t2.medium"
  key                  = "devops_rampup"
  ami                  = "ami-04505e74c0741db8d" //Ubuntu  AMI
  name                 = "K8s_worker"
  userdata             = "user-data-k8s-worker.sh"
  network_interface_id = module.network_interface_k8s_worker.id
  security             = [module.security.private_SG_id]
}

module "network_interface_k8s_worker2" {
  source      = "./modules/network"
  private_ips = ["10.0.3.12"]
  subnet_id   = module.subnet_private.id
  security    = [module.security.private_SG_id]
}

module "k8s_worker2" {
  source               = "./modules/instance"
  instance_type        = "t2.medium"
  key                  = "devops_rampup"
  ami                  = "ami-04505e74c0741db8d" //Ubuntu  AMI
  name                 = "K8s_worker2"
  userdata             = "user-data-k8s-worker.sh"
  network_interface_id = module.network_interface_k8s_worker2.id
  security             = [module.security.private_SG_id]
}

module "loadbalancer" {
  source   = "./modules/load balancer"
  security = [module.security.id]
  subnets  = [module.subnet_private.id, module.subnet_B.id]
  vpc_id   = module.vpc.id
  instance = [module.k8s_worker.instance_id, module.k8s_worker2.instance_id]
}

module "database" {
  source          = "./modules/rds"
  identifier      = "db-movie-app"
  security_groups = module.security.private_SG_id
  subnets         = [module.subnet_private.id, module.subnet_B.id]
}

module "nat" {
  source        = "./modules/nat"
  subnet_nat    = module.subnet_A.id
  subnet_target = module.subnet_private.id
  allocation_id = module.gateway.allocation_id
  vpc_id        = module.vpc.id
}

