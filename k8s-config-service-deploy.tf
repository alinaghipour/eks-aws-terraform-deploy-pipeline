resource "kubernetes_service" "nginxapp" {
  metadata {
    name = "terraform-nginxapp"
  }
  spec {
    selector = {
      apps = "EksAwsTerraformApp"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

resource "kubernetes_deployment" "nginxapp" {
  metadata {
    name = "terraform-nginxapp"
    labels = {
      apps = "EksAwsTerraformApp"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        apps = "EksAwsTerraformApp"
      }
    }

    template {
      metadata {
        labels = {
          apps = "EksAwsTerraformApp"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginxapp"

          resources {
            limits {
              cpu    = "1.0"
              memory = "512Mi"
            }
            requests {
              cpu    = "200m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}