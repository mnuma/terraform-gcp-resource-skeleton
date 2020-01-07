terraform {
  backend "gcs" {
    bucket = "terraform"
    prefix = "app"
  }
}
