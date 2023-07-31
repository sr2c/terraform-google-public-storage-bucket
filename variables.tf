variable "bucket_name" {
  type        = string
  description = "Name of the storage bucket."
}

variable "project_id" {
  description = "The ID of the GCP project in which resources will be provisioned."
  type        = string
}
