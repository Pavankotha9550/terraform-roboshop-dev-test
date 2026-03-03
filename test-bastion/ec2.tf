module "bastion"{
    source= "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//20-bastion-server?ref=main"
    project= var.project
    environment=var.environment
}