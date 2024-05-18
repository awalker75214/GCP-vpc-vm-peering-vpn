
#### VPC & VM'S ### 

resource "google_compute_network" "euro-vpc-tf" {
  name = "euro-vpc-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub-sg" {
  name ="sub-sg"
  network = google_compute_network.euro-vpc-tf.id
  ip_cidr_range = "10.72.1.0/24"
  region = "europe-north1"
}

output "auto" {
  value = google_compute_network.euro-vpc-tf.id
}


resource "google_compute_instance" "euro_vm" {
  zone         = "europe-north1-a"
  name         = "euro-vm"
  machine_type = "n2-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = "euro-vpc-tf"
    subnetwork = google_compute_subnetwork.sub-sg.name # Replace with a reference or self link to your subnet, in quotes
   access_config {
      // Not assigned a public IP
    }
  }
 
  metadata = {
    startup-script = file("${path.module}/startup-script.sh")
  }

}


resource "google_compute_network" "americas-vpc-tf" {
  name = "americas-vpc-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub-sg1-america" {
  name ="sub-sg1-america"
  network = google_compute_network.americas-vpc-tf.id
  ip_cidr_range = "172.16.1.0/24"
  region = "northamerica-northeast1"
}


resource "google_compute_subnetwork" "sub-sg2-america" {
  name ="sub-sg2-america"
  network = google_compute_network.americas-vpc-tf.id
  ip_cidr_range = "172.16.2.0/24"
  region = "northamerica-northeast2"
}


output "auto-america" {
  value = google_compute_network.americas-vpc-tf.id
}

resource "google_compute_instance" "americas_vm" {
  zone         = "northamerica-northeast1-b"
  name         = "americas-vm"
  machine_type = "n2-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = "americas-vpc-tf"
    subnetwork = google_compute_subnetwork.sub-sg1-america.name # Replace with a reference or self link to your subnet, in quotes
  }
}




resource "google_compute_network" "asia-vpc-tf" {
  name = "asia-vpc-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub-sg-asia" {
  name ="sub-sg-asia"
  network = google_compute_network.asia-vpc-tf.id
  ip_cidr_range = "192.168.1.0/24"
  region = "asia-northeast1"
}

output "auto-asia" {
  value = google_compute_network.asia-vpc-tf.id
}


resource "google_compute_instance" "asia_vm" {
  zone         = "asia-northeast1-a"
  name         = "asia-vm"
  machine_type = "n2-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = "asia-vpc-tf"
    subnetwork = google_compute_subnetwork.sub-sg-asia.name # Replace with a reference or self link to your subnet, in quotes
  }
}

######PEERING MODULE#####

resource "google_compute_network_peering" "peering1" {
  name         = "peering1"
  network      = google_compute_network.euro-vpc-tf.self_link
  peer_network = google_compute_network.americas-vpc-tf.self_link
}

resource "google_compute_network_peering" "peering2" {
  name         = "peering2"
  network      = google_compute_network.americas-vpc-tf.self_link
  peer_network = google_compute_network.euro-vpc-tf.self_link
}








