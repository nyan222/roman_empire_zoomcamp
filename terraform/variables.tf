# variable "credentials" {
#   description = "My Credentials"
#   default     = "<Path to your Service Account json file>"
#   #ex: if you have a directory where this file is called keys with your service account json file
#   #saved there as my-creds.json you could use default = "./keys/my-creds.json"
# }


variable "project" {
  description = "Project"
  default     = "coral-firefly-411510"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "us-west1"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "us-west1"
}

# variable "bq_dataset_name" {
#   description = "My BigQuery Dataset Name"
#   #Update the below to what you want your dataset to be called
#   default     = "terra_nytaxi_dataset"
# }

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "roman_empire_zoomcamp"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "instance" {
  type = string
  default = "roman-empire"
}

variable "machine_type" {
  type = string
  default = "e2-standard-4"
}

variable "zone" {
  description = "Region for VM"
  type = string
  default = "us-west1-b"
}