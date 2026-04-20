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

module "cart"{
    source = "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//30-module-category?ref=main"
    #ource =  ""
    component = "user"
    priority = 30
}

module "shipping"{
    source = "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//30-module-category?ref=main"
    #ource =  ""
    component = "user"
    priority = 40
}

module "payment"{
    source = "git::https://github.com/Pavankotha9550/terraform-roboshop-dev-module.git//30-module-category?ref=main"
    #ource =  ""
    component = "user"
    priority = 50
}