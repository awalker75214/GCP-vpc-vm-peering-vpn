terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "milliondollarsofgame"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "milliondollarsofgame-571e697b0f13-KEY.json"

}