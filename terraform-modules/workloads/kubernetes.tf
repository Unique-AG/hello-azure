module "kubernetes_cluster" {
  source = "github.com/Unique-AG/terraform-modules.git//modules/azure-kubernetes-service?ref=azure-kubernetes-service-4.0.1"

  kubernetes_version                      = var.kubernetes_version
  application_gateway_id                  = module.application_gateway.appgw_id
  segregated_node_and_pod_subnets_enabled = true
  cluster_name                            = var.cluster_name
  kubernetes_default_node_size            = var.kubernetes_default_node_size
  kubernetes_default_node_zones           = ["1", "3"]
  node_rg_name                            = var.node_resource_group_name
  resource_group_location                 = data.azurerm_resource_group.core.location
  resource_group_name                     = data.azurerm_resource_group.core.name
  default_subnet_nodes_id                 = var.subnet_aks_nodes_id
  default_subnet_pods_id                  = var.subnet_aks_pods_id
  tags                                    = var.tags
  tenant_id                               = data.azurerm_client_config.current.tenant_id
  defender_log_analytics_workspace_id     = var.defender_log_analytics_workspace_id
  prometheus_node_recording_rules         = var.prometheus_node_recording_rules
  prometheus_kubernetes_recording_rules   = var.prometheus_kubernetes_recording_rules
  prometheus_ux_recording_rules           = var.prometheus_ux_recording_rules

  log_analytics_workspace = {
    id                  = var.log_analytics_workspace_id
    location            = var.resource_group_core_location
    resource_group_name = var.resource_group_core_name
  }

  azure_prometheus_grafana_monitor = {
    azure_monitor_location = var.resource_group_core_location
    azure_monitor_rg_name  = var.resource_group_core_name
    enabled                = true
    grafana_major_version  = "11"
    identity = {
      type         = "UserAssigned"
      identity_ids = [var.grafana_user_assigned_identity_id]
    }
  }


  network_profile = {
    idle_timeout_in_minutes = 100
    outbound_ip_address_ids = [var.aks_public_ip_id]
  }

  node_pool_settings = {
    rapid = {
      auto_scaling_enabled = true
      max_count            = var.kubernetes_rapid_max_count
      min_count            = var.kubernetes_rapid_min_count
      mode                 = "User"
      node_count           = var.kubernetes_rapid_node_count
      node_labels = {
        lifecycle   = "ephemeral"
        scalability = "rapid"
      }
      node_taints     = ["scalability=rapid:NoSchedule", "lifecycle=ephemeral:NoSchedule"]
      os_disk_size_gb = 100
      os_sku          = "AzureLinux"
      upgrade_settings = {
        max_surge = "10%"
      }
      vm_size = var.kubernetes_rapid_node_size
      zones   = ["1", "3"]
    }
    steady = {
      auto_scaling_enabled = true
      max_count            = var.kubernetes_steady_max_count
      min_count            = var.kubernetes_steady_min_count
      mode                 = "User"
      node_count           = var.kubernetes_steady_node_count
      node_labels = {
        lifecycle   = "persistent"
        scalability = "steady"
      }
      node_taints     = []
      os_disk_size_gb = 100
      os_sku          = "AzureLinux"
      upgrade_settings = {
        max_surge = "30%"
      }
      vm_size = var.kubernetes_steady_node_size
      zones   = ["1", "3"]
    }
  }
}
