
## Europe Firewall Allows
resource "google_compute_firewall" "europe-http" {
  name    = "europe-http"
  network = google_compute_network.euro-vpc-tf.id
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80" ]
  }

  source_tags = ["web"]

  source_ranges = ["172.16.0.0/24", "172.16.1.0/24", "10.72.1.0/24","192.168.1.0/24"]
}

output "network_id" {
  value =  google_compute_network.euro-vpc-tf.id
}



## America to Europe vpn
resource "google_compute_firewall" "america-to-europe-http" {
  name    = "america-to-europe-http"
  network = google_compute_network.americas-vpc-tf.id

  allow {
    protocol = "tcp"
    ports    = ["80","22" ]
  }

  source_ranges = ["0.0.0.0/0", "35.235.240.0/20"]

}


### Asia RDP
resource "google_compute_firewall" "asia_allow_rdp" {
  name    = "asia-allow-rdp"
  network = google_compute_network.asia-vpc-tf.id

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]


}