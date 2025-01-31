module "kubernetes_cluster" {
  source                 = "github.com/Unique-AG/terraform-modules.git//modules/azure-kubernetes-service?ref=azure-kubernetes-service-2.0.0"
  application_gateway_id = module.application_gateway.appgw_id
  azure_prometheus_grafana_monitor = {
    azure_monitor_location = "westeurope"
    azure_monitor_rg_name  = data.azurerm_resource_group.core.name
    enabled                = true
  }
  cluster_name                 = var.cluster_name
  kubernetes_default_node_size = "Standard_D2ps_v6"
  log_analytics_workspace_id   = var.log_analytics_workspace_id
  node_pool_settings = {
    rapid = {
      auto_scaling_enabled = true
      max_count            = 3
      min_count            = 0
      mode                 = "User"
      node_count           = 0
      node_labels = {
        lifecycle   = "ephemeral"
        scalability = "rapid"
      }
      node_taints                 = ["scalability=rapid:NoSchedule", "lifecycle=ephemeral:NoSchedule"]
      os_disk_size_gb             = 100
      os_sku                      = "AzureLinux"
      temporary_name_for_rotation = "rapidrepl"
      upgrade_settings = {
        max_surge = "10%"
      }
      vm_size = "Standard_D8s_v3"
      zones   = ["1", "2", "3"]
    }
    steady = {
      auto_scaling_enabled = true
      max_count            = 4
      min_count            = 0
      mode                 = "User"
      node_count           = 2
      node_labels = {
        lifecycle   = "persistent"
        scalability = "steady"
      }
      node_taints                 = []
      os_disk_size_gb             = 100
      os_sku                      = "AzureLinux"
      temporary_name_for_rotation = "steadyrepl"
      upgrade_settings = {
        max_surge = "30%"
      }
      vm_size = "Standard_D8s_v3"
      zones   = ["1", "2", "3"]
    }
  }
  node_rg_name            = var.node_resource_group_name
  outbound_ip_address_ids = [var.aks_public_ip_id]
  resource_group_location = data.azurerm_resource_group.core.location
  resource_group_name     = data.azurerm_resource_group.core.name
  subnet_nodes_id         = var.subnet_aks_nodes_id
  tags                    = var.tags
  tenant_id               = data.azurerm_client_config.current.tenant_id
}
