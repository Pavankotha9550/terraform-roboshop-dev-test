module "user"{
    source = "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//30-module-category?ref=main"
    component = "user"
    priority = 20
}