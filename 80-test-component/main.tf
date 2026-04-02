module "user"{
    source = "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//30-module-category?ref=main"
    #ource =  ""
    component = "user"
    priority = 20
}

module "frontend"{
    source = "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//30-module-category?ref=main"
    #ource =  ""
    component = "frontend"
    priority = 10
}