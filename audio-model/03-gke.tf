resource "google_container_cluster" "audio" {
  provider = google-beta

  name        = "audio-cluster"
  description = "GKE Cluster for self-hosting audio models"
  location    = var.region

  enable_autopilot = true
  release_channel {
    channel = "RAPID"
  }
  min_master_version = "1.34.0-gke.2201000"

  # networking
  network         = google_compute_network.main.name
  subnetwork      = google_compute_subnetwork.gke.name
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }
  private_cluster_config {
    enable_private_nodes = true
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "STORAGE", "HPA", "POD", "DAEMONSET", "DEPLOYMENT", "STATEFULSET"]
    managed_prometheus {
      enabled = true
    }
  }

  depends_on = [
    google_compute_subnetwork.gke
  ]
  deletion_protection = false
}

# module "k8s" {
#   source = "./k8s"
#   region = var.region
#   depends_on = [google_container_cluster.audio]
# }
