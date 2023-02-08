module "modules" {
  source             = "./modules"
  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  subnets_cidr       = var.subnet_cidr
  az1                = var.zone1
  az2                = var.zone2
  cidr_from_anywhere = var.cidr_from_anywhere
  public_subnet1   = module.ec2.public-instance-1
  public_subnet2 = module.ec2.public-instance-2
  private_subnet1 = module.ec2.private-instance-1
  private_subnet2= module.ec2.private-instance-2

}
module "ec2" {
  source          = "./ec2"
  ami_id          = var.ami_id
  instance_type         = var.instance_type
  securitygroupid = module.modules.secgroup-id
  publicsubnet1-id     = module.modules.public_subnet_id1
  publicsubnet2-id      = module.modules.public_subnet_id2
  privatesubnet1-id     = module.modules.private_subnet_id1
  privatesubnet2-id    = module.modules.private_subnet_id2



  provisioner_data =  ["sudo apt update -y",
      "sudo apt install -y nginx",
      "echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${module.modules.pivatedns}; \n  } \n}' > default",
      "sudo mv default /etc/nginx/sites-enabled/default",
      "sudo systemctl stop nginx",
      "sudo systemctl start nginx"]
    
}