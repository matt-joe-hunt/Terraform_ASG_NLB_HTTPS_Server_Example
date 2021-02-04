provider "aws" {
  region = var.region-master
}

module "ASG" {
  source = "./modules/ASG"

  sg-id = module.SG.sg-id
  instance-profile-name = module.IAM.instance-profile-name
  subnet-ids = module.VPC.subnet-ids

  depends_on = [ module.S3 ]
}

module "IAM" {
  source = "./modules/IAM"
  
}

module "NLB" {
  source = "./modules/NLB"

  public-subnet-ids = module.VPC.subnet-ids
  vpc-id            = module.VPC.vpc-id
}

module "S3" {
  source = "./modules/S3"

  bucket-name = var.bucket-name
}

module "SG" {
  source  = "./modules/SG"

  asg-sg-name = var.asg-sg-name
  vpc-id  = module.VPC.vpc-id
}

module "VPC" {
  source   = "./modules/VPC"
  
  vpc-name = var.vpc-name
}
