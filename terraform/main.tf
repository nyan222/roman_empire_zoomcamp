terraform {
  #required_version = ">= 1.0"
  backend "local" {}  # Can change from "local" to "gcs" (for google) or "s3" (for aws), if you would like to preserve your tf-state online
  #local: stores state file locally as terraform.tfstate
  # required_providers {
  #   google = {
  #     source  = "hashicorp/google"
  #     version = "5.6.0"
  #   }
  # }
}

provider "google" {
  ##credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

# Data Lake Bucket
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "data-lake-bucket" {
  name          = var.gcs_bucket_name
  location      = var.region
  # Optional, but recommended settings:
  storage_class = var.gcs_storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 22  // days
    }
  }

  force_destroy = true
}


# DWH
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
resource "google_bigquery_dataset" "datasets" {
  for_each = local.datasets

  project                     = var.project
  dataset_id                  = each.value["dataset_id"]
  delete_contents_on_destroy  = true
  location                    = var.region

}

# Virtual Machine Instance
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# We need more than 10 GB, ideally 100 GB.
resource "google_compute_instance" "my-instance" {
  name         = var.instance
  machine_type = var.machine_type
  zone         = var.zone
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      size = 100
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = "default"
    subnetwork = "default"
    access_config {
      // Ephemeral IP
    }
  }
}