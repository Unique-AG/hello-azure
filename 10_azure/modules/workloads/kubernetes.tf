module "kubernetes_cluster" {
  source                       = "github.com/Unique-AG/terraform-modules.git//modules/azure-kubernetes-service?ref=azure-kubernetes-service-2.0.0"
  cluster_name                 = var.cluster_name
  resource_group_location      = data.azurerm_resource_group.core.location
  resource_group_name          = data.azurerm_resource_group.core.name
  kubernetes_default_node_size = "Standard_D2ps_v6"
  outbound_ip_address_ids      = [var.aks_public_ip_id]

  node_rg_name = var.node_resource_group_name
  tags         = var.tags
  azure_prometheus_grafana_monitor = {
    enabled                = true
    azure_monitor_location = "westeurope"
    azure_monitor_rg_name  = data.azurerm_resource_group.core.name
  }

  node_pool_settings = {
    steady = {
      temporary_name_for_rotation = "steadyrepl"
      vm_size                     = "Standard_D8ps_v6"
      node_count                  = 2
      min_count                   = 1
      max_count                   = 8
      os_disk_size_gb             = 100
      os_sku                      = "AzureLinux"
      node_labels = {
        scalability = "steady"
        lifecycle   = "persistent"
      }
      node_taints          = []
      auto_scaling_enabled = true
      mode                 = "User"
      zones                = ["1", "2", "3"]
      upgrade_settings = {
        max_surge = "30%"
      }
    }
    rapid = {
      temporary_name_for_rotation = "rapidrepl"
      vm_size                     = "Standard_D8ps_v6"
      node_count                  = 0
      min_count                   = 0
      max_count                   = 3
      os_disk_size_gb             = 100
      os_sku                      = "AzureLinux"
      node_labels = {
        scalability = "rapid"
        lifecycle   = "ephemeral"
      }
      node_taints          = ["scalability=rapid:NoSchedule", "lifecycle=ephemeral:NoSchedule"]
      auto_scaling_enabled = true
      mode                 = "User"
      zones                = ["1", "2", "3"]
      upgrade_settings = {
        max_surge = "10%"
      }
    }
  }
  application_gateway_id     = module.application_gateway.appgw_id
  subnet_nodes_id            = var.subnet_aks_nodes_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  tenant_id                  = data.azurerm_client_config.current.tenant_id
}
