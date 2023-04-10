resource "kubernetes_namespace" "ado-agents" {
  metadata {

    # TODO: include option for annotations and labels
    # annotations = {
    #   name = "example-annotation"
    # }

    # labels = {
    #   mylabel = "label-value"
    # }

    name = var.k8s_ado_agents_namespace
  }
}

resource "kubernetes_secret" "pipeline-auth" {
  metadata {
    name      = "pipeline-auth"
    namespace = var.k8s_ado_agents_namespace
  }

  data = {
    AZP_URL   = var.ado_org
    AZP_TOKEN = var.ado_ext_pat
  }

  type = "Opaque"
}

resource "kubernetes_job" "azure-pipelines-agent" {
  metadata {
    name      = "azure-pipelines-setup"
    namespace = var.k8s_ado_agents_namespace
  }
  spec {
    active_deadline_seconds    = 300
    backoff_limit              = 0
    ttl_seconds_after_finished = 600
    template {
      metadata {}
      spec {
        container {
          name              = "azure-pipelines-agent"
          image             = var.k8s_ado_agent_image
          image_pull_policy = "Always"
          env {
            name  = "AZP_AGENT_NAME"
            value = "setup-template"
          }
          env {
            name  = "AZP_POOL"
            value = var.ado_agent_pool_name
          }
          env {
            name = "pipeline-auth"
            value_from {
              secret_key_ref {
                name = "pipeline-auth"
                key  = "AZP_TOKEN"
              }
            }
          }
        }
        restart_policy          = "Never"
        active_deadline_seconds = 240
      }
    }
  }
  wait_for_completion = false
}


# data "kubectl_file_documents" "docs" {
#     content = file("multi-doc-manifest.yaml")
# }

# resource "kubectl_manifest" "test" {
#     for_each  = data.kubectl_file_documents.docs.manifests
#     yaml_body = each.value
# }

resource "kubectl_manifest" "scaled_job" {
  yaml_body = templatefile("${path.module}/kubernetes/scaledjob.yml", {
    namespace = var.k8s_ado_agents_namespace
    pool_name = var.ado_agent_pool_name
    image     = var.k8s_ado_agent_image
  })
  depends_on = [
    kubernetes_namespace.ado-agents,
    helm_release.keda
  ]
}


# ╷
# │ Error: Failed to construct REST client
# │
# │   with module.terraform-azurerm-aks-devops-agent.kubernetes_manifest.scaled_job,
# │   on .terraform/modules/terraform-azurerm-aks-devops-agent/kubernetes.tf line 73, in resource "kubernetes_manifest" "scaled_job":
# │   73: resource "kubernetes_manifest" "scaled_job" {
# │
# │ cannot create REST client: no client config

# https://github.com/hashicorp/terraform-provider-kubernetes/issues/1775
# https://github.com/hashicorp/terraform-provider-kubernetes/issues/1380
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/kubectl_manifest

# resource "kubernetes_manifest" "scaled_job" {
#   manifest = {
#     apiVersion = "keda.sh/v1alpha1"
#     kind       = "ScaledJob"

#     metadata = {
#       name      = "azure-pipelines-scaledjob"
#       namespace = var.k8s_ado_agents_namespace

#       labels = {
#         name = "azure-pipelines-scaledjob"
#       }
#     }

#     spec = {
#       triggers = [
#         {
#           type = "azure-pipelines"
#           metadata = {
#             poolName                   = var.ado_agent_pool_name
#             organizationURLFromEnv     = "AZP_URL"
#             personalAccessTokenFromEnv = "AZP_TOKEN"
#           }
#         }
#       ]
#       jobTargetRef = {
#         activeDeadlineSeconds = 14400
#         template = {
#           spec = {
#             restartPolicy = "Never"
#             containers = [
#               {
#                 name            = "azure-pipelines-agent"
#                 image           = var.k8s_ado_agent_image
#                 imagePullPolicy = "Always"
#                 envFrom = [
#                   {
#                     secretRef = {
#                       name = "pipeline-auth"
#                     }
#                   }
#                 ]
#               }
#             ]
#           }
#         }
#       }
#       pollingInterval            = 10
#       successfulJobsHistoryLimit = 5
#       failedJobsHistoryLimit     = 5
#       maxReplicaCount            = 30
#       rollout = {
#         strategy = "gradual"
#       }
#     }
#   }

#   depends_on = [
#     helm_release.keda
#   ]
# }
