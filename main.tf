locals {
  bucket_name = coalesce(var.bucket_name, module.this.id)
}

resource "google_storage_bucket" "bucket" {
  name     = local.bucket_name
  location = "US"

  uniform_bucket_level_access = true

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_iam_member" "public" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_service_account" "this" {
  account_id   = module.this.id
  display_name = "My Service Account"
  project      = var.project_id
}

resource "google_storage_bucket_iam_member" "service_account" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.this.email}"
}

resource "google_service_account_key" "service_account" {
  service_account_id = google_service_account.this.name
}

resource "google_storage_bucket_iam_member" "service_account_metadata" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.legacyBucketReader"
  member = "serviceAccount:${google_service_account.this.email}"
}
