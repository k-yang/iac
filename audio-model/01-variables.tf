#
# Variables
#

# variable "github_token" {
#   type = string
# }

# variable "ssh_private_key" {
#   type = string
# }

# variable "ssh_public_key" {
#   type = string
# }

# variable "google_oauth_client_id" {
#   type = string
# }

# variable "google_oauth_client_secret" {
#   type = string
# }

variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region the cluster in"
}

variable "zone" {
  description = "The zone the cluster in"
}

# variable "ssh_private_key" {
#   type = string
# }

# variable "ssh_public_key" {
#   type = string
# }
