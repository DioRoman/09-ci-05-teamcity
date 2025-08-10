# Создание сетей, подсетей и групп безопасности

module "yandex-vpc" {
  source       = "git::https://github.com/DioRoman/ter-final.git//src/modules/yandex-vpc?ref=main"
  env_name     = var.nexus-vm[0].env_name
  subnets = [
    { zone = var.vpc_default_zone[0], cidr = var.vpc_default_cidr[1] }
  ]
  security_groups = [
    {
      name        = "web"
      description = "Security group for web servers"
      ingress_rules = [
        {
          protocol    = "TCP"
          port        = 80
          description = "HTTP access"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol    = "TCP"
          port        = 443
          description = "HTTPS access"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol    = "TCP"
          port        = 22
          description = "SSH access"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol    = "TCP"
          port        = 8111
          description = "Teamcity port"
          cidr_blocks = ["0.0.0.0/0"]
        },       
        {
          protocol    = "TCP"
          port        = 8081
          description = "Nexus port"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ],
    egress_rules = [
        {
            protocol    = "ANY"
            description = "Allow all outbound traffic"
            cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },
  ]
}

# Создание VM

# module "teamcity-server" {
#   source              = "git::https://github.com/DioRoman/ter-final.git//src/modules/yandex-vm?ref=main"
#   vm_name             = var.teamcity-server[0].instance_name 
#   vm_count            = var.teamcity-server[0].instance_count
#   zone                = var.vpc_default_zone[0]
#   subnet_ids          = module.yandex-vpc.subnet_ids
#   image_id            = data.yandex_compute_image.ubuntu.id
#   platform_id         = var.teamcity-server[0].platform_id
#   cores               = var.teamcity-server[0].cores
#   memory              = var.teamcity-server[0].memory
#   disk_size           = var.teamcity-server[0].disk_size 
#   public_ip           = var.teamcity-server[0].public_ip
#   security_group_ids  = [module.yandex-vpc.security_group_ids["web"]]
  
#   labels = {
#     env  = var.teamcity-server[0].env_name
#     role = var.teamcity-server[0].role
#   }

#   metadata = {
#     user-data = data.template_file.teamcity-server.rendered
#     serial-port-enable = local.serial-port-enable
#   }  
# }

# module "teamcity-agent" {
#   source              = "git::https://github.com/DioRoman/ter-final.git//src/modules/yandex-vm?ref=main"
#   vm_name             = var.teamcity-agent[0].instance_name 
#   vm_count            = var.teamcity-agent[0].instance_count
#   zone                = var.vpc_default_zone[0]
#   subnet_ids          = module.yandex-vpc.subnet_ids
#   image_id            = data.yandex_compute_image.ubuntu.id
#   platform_id         = var.teamcity-agent[0].platform_id
#   cores               = var.teamcity-agent[0].cores
#   memory              = var.teamcity-agent[0].memory
#   disk_size           = var.teamcity-agent[0].disk_size 
#   public_ip           = var.teamcity-agent[0].public_ip
#   security_group_ids  = [module.yandex-vpc.security_group_ids["web"]]
  
#   labels = {
#     env  = var.teamcity-agent[0].env_name
#     role = var.teamcity-agent[0].role
#   }

#   depends_on = [
#   module.teamcity-server
#   ]

#   metadata = {
#     user-data = data.template_file.teamcity-agent.rendered
#     serial-port-enable = local.serial-port-enable
#     server-url = "http://${module.teamcity-server.external_ips[0]}:8111"
#   } 
# }

module "nexus-vm" {
  source              = "git::https://github.com/DioRoman/ter-final.git//src/modules/yandex-vm?ref=main"
  vm_name             = var.nexus-vm[0].instance_name 
  vm_count            = var.nexus-vm[0].instance_count
  zone                = var.vpc_default_zone[0]
  subnet_ids          = module.yandex-vpc.subnet_ids
  image_id            = data.yandex_compute_image.ubuntu.id
  platform_id         = var.nexus-vm[0].platform_id
  cores               = var.nexus-vm[0].cores
  memory              = var.nexus-vm[0].memory
  disk_size           = var.nexus-vm[0].disk_size 
  public_ip           = var.nexus-vm[0].public_ip
  security_group_ids  = [module.yandex-vpc.security_group_ids["web"]]
  
  labels = {
    env  = var.nexus-vm[0].env_name
    role = var.nexus-vm[0].role
  }

  # depends_on = [
  # module.teamcity-agent
  # ]

  metadata = {
    user-data = data.template_file.nexus-vm.rendered
    serial-port-enable = local.serial-port-enable
  } 
}

# Инициализация 
# data "template_file" "teamcity-server" {
#   template = file("./teamcity-server-init.yml")
#     vars = {
#     ssh_public_key     = file(var.vm_ssh_root_key)
#   }
# }

# data "template_file" "teamcity-agent" {
#   template = file("./teamcity-agent-init.yml")
#     vars = {
#     ssh_public_key     = file(var.vm_ssh_root_key)
#     server-url = "http://${module.teamcity-server.external_ips[0]}:8111"
#   }
# }

data "template_file" "nexus-vm" {
  template = file("./nexus-vm-init.yml")
    vars = {
    ssh_public_key     = file(var.vm_ssh_root_key)
  }
}

# Получение id образа Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}
