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

output "nexus-vm_private_ips" {
  description = "Private IP addresses of Web VMs"
  value       = module.nexus-vm.internal_ips
}

output "nexus-vm_ssh" {
  description = "SSH commands to connect to Web VMs"
  value = [
    for ip in module.nexus-vm.external_ips : "ssh -l ubuntu ${ip}"
  ]
}

output "teamcity-server-external_ip" {
  value = module.teamcity-server.external_ips
}