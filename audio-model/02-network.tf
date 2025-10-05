locals {
  main_cidr = "10.0.0.0/8"
}

resource "google_compute_network" "main" {
  name                    = "main"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke" {
  name                     = "main-gke"
  region                   = var.region
  ip_cidr_range            = "10.129.0.0/19"
  network                  = google_compute_network.main.name
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.0.0.0/9"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.128.0.0/16"
  }
}

##########################################
# Router and NAT for k8s internet access #
##########################################

resource "google_compute_router" "main_router" {
  name    = "main-router"
  region  = var.region
  network = google_compute_network.main.name
}

resource "google_compute_router_nat" "main_nat" {
  name                               = "main-nat"
  router                             = google_compute_router.main_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  min_ports_per_vm                   = 56000

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}