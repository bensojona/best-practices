variable "name" {}
variable "region" {}
variable "vpc_id" {}
variable "vpc_cidr" {}
variable "private_subnet_ids" {}
variable "public_subnet_ids" {}
variable "ssl_cert" {}
variable "ssl_key" {}
variable "key_name" {}
variable "atlas_username" {}
variable "atlas_environment" {}
variable "atlas_token" {}
variable "sub_domain" {}
variable "route_zone_id" {}

variable "consul_amis" {}
variable "consul_nodes" {}
variable "consul_instance_type" {}
variable "consul_user_data" {}
variable "openvpn_user" {}
variable "openvpn_host" {}
variable "key_file" {}
variable "bastion_host" {}
variable "bastion_user" {}

variable "vault_amis" {}
variable "vault_nodes" {}
variable "vault_instance_type" {}
variable "vault_user_data" {}

module "consul" {
  source = "./consul"

  name               = "${var.name}-consul"
  vpc_id             = "${var.vpc_id}"
  vpc_cidr           = "${var.vpc_cidr}"
  private_subnet_ids = "${var.private_subnet_ids}"
  key_name           = "${var.key_name}"
  atlas_username     = "${var.atlas_username}"
  atlas_environment  = "${var.atlas_environment}"
  atlas_token        = "${var.atlas_token}"
  amis               = "${var.consul_amis}"
  nodes              = "${var.consul_nodes}"
  instance_type      = "${var.consul_instance_type}"
  user_data          = "${var.consul_user_data}"
  openvpn_user       = "${var.openvpn_user}"
  openvpn_host       = "${var.openvpn_host}"
  key_file           = "${var.key_file}"
  bastion_host       = "${var.bastion_host}"
  bastion_user       = "${var.bastion_user}"
}

module "vault" {
  source = "./vault"

  name               = "${var.name}-vault"
  region             = "${var.region}"
  vpc_id             = "${var.vpc_id}"
  vpc_cidr           = "${var.vpc_cidr}"
  private_subnet_ids = "${var.private_subnet_ids}"
  public_subnet_ids  = "${var.public_subnet_ids}"
  ssl_cert           = "${var.ssl_cert}"
  ssl_key            = "${var.ssl_key}"
  key_name           = "${var.key_name}"
  atlas_username     = "${var.atlas_username}"
  atlas_environment  = "${var.atlas_environment}"
  atlas_token        = "${var.atlas_token}"
  amis               = "${var.vault_amis}"
  nodes              = "${var.vault_nodes}"
  instance_type      = "${var.vault_instance_type}"
  user_data          = "${var.vault_user_data}"
  sub_domain         = "${var.sub_domain}"
  route_zone_id      = "${var.route_zone_id}"
}

# Consul
output "consul_private_ips" { value = "${module.consul.private_ips}" }

# Vault
output "vault_private_ips"  { value = "${module.vault.private_ips}" }
output "vault_elb_dns"      { value = "${module.vault.elb_dns}" }
output "vault_private_fqdn" { value = "${module.vault.private_fqdn}" }
