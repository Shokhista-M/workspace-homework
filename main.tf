terraform {
    backend "s3" {
        bucket = "backendforworkspaces"
        key = "multiple_workspaces.terraform.tfstate"
        region = "us-east-2"
    }
    required_providers {
        tfe = {
            version = "~>0.64.0"
        }
    }
}
provider "tfe" {
    version = "~>0.64.0"
}
variable "networks" {
    type = list(string)
    default = ["sandbox", "dev", "test", "uat","prod"]
}
resource "tfe_workspace" "test" {
    for_each = toset(var.networks)
    name = "network-${each.key}"
    organization = "029DA-DevOps24"
}