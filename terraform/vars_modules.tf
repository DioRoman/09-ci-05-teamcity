# variable "teamcity-server" {
#   type = list(
#      object({ env_name = string, instance_name = string, instance_count = number, public_ip = bool, platform_id = string,
#      cores = number, memory = number, disk_size = number, role= string }))
#   default = ([ 
#     { 
#     env_name          = "production",
#     instance_name     = "teamcity-server", 
#     instance_count    = 1, 
#     public_ip         = true,
#     platform_id       = "standard-v3",
#     cores             = 4,
#     memory            = 4,
#     disk_size         = 10,
#     role              = "teamcity-server"    
#   }])
# }

# variable "teamcity-agent" {
#   type = list(
#      object({ env_name = string, instance_name = string, instance_count = number, public_ip = bool, platform_id = string,
#      cores = number, memory = number, disk_size = number, role= string }))
#   default = ([ 
#     { 
#     env_name          = "production",
#     instance_name     = "teamcity-agent", 
#     instance_count    = 1, 
#     public_ip         = true,
#     platform_id       = "standard-v3",
#     cores             = 2,
#     memory            = 4,
#     disk_size         = 10,
#     role              = "teamcity-agent"    
#   }])
# }

variable "nexus-vm" {
  type = list(
     object({ env_name = string, instance_name = string, instance_count = number, public_ip = bool, platform_id = string,
     cores = number, memory = number, disk_size = number, role= string }))
  default = ([ 
    { 
    env_name          = "production",
    instance_name     = "nexus", 
    instance_count    = 1, 
    public_ip         = true,
    platform_id       = "standard-v3",
    cores             = 2,
    memory            = 4,
    disk_size         = 10,
    role              = "nexus"    
  }])
}