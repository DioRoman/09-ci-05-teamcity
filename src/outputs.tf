# Web outputs
output "teamcity-agent_private_ips" {
  description = "Private IP addresses of Web VMs"
  value       = module.teamcity-agent.internal_ips
}

output "teamcity-agent_ssh" {
  description = "SSH commands to connect to Web VMs"
  value = [
    for ip in module.teamcity-agent.external_ips : "ssh -l ubuntu ${ip}"
  ]
}

output "teamcity-server_private_ips" {
  description = "Private IP addresses of Web VMs"
  value       = module.teamcity-server.internal_ips
}

output "teamcity-server_ssh" {
  description = "SSH commands to connect to Web VMs"
  value = [
    for ip in module.teamcity-server.external_ips : "ssh -l ubuntu ${ip}"
  ]
}

output "vm-yc_private_ips" {
  description = "Private IP addresses of Web VMs"
  value       = module.vm-yc.internal_ips
}

output "vm-yc_ssh" {
  description = "SSH commands to connect to Web VMs"
  value = [
    for ip in module.vm-yc.external_ips : "ssh -l ubuntu ${ip}"
  ]
}

output "teamcity-server-external_ip" {
  value = module.teamcity-server.external_ips
}