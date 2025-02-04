# #For k8s service accounts
resource "azurerm_federated_identity_credential" "afic_workloads" {
  for_each            = var.cluster_workload_identities
  name                = each.value.name
  resource_group_name = azurerm_resource_group.core.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.aks_workload_identity.id
  subject             = "system:serviceaccount:${each.value.namespace}:${each.value.name}"
  depends_on = [
    var.cluster_id
  ]
}
