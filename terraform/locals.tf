locals {
  datasets = jsondecode(file("${path.module}/resources/datasets.json"))["datasets"]
}