resource "random_id" "id" {
  byte_length = 6
  prefix      = "app-"
}

resource "google_project" "project" {
  name            = var.project_name
  project_id      = random_id.id.hex
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

output "project_id" {
  value = google_project.project.project_id
}
