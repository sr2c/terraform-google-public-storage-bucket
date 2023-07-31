output "service_account_key" {
  description = "The service account key"
  value       = google_service_account_key.service_account.private_key
  sensitive   = true
}