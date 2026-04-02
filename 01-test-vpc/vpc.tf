module "vpc"{
    #source= "../vpc-terraform"
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//01-module-vpc?ref=main"
    project=var.project
    environment=var.environment
    public_subnets_cidr=["10.0.1.0/24", "10.0.2.0/24"]
    private_subnets_cidr=["10.0.11.0/24", "10.0.12.0/24"]
    database_subnets_cidr=["10.0.21.0/24", "10.0.22.0/24"]

}
