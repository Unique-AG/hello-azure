resource "azuread_group" "telemetry_observer" {
  display_name     = var.telemetry_observer_group_display_name
  security_enabled = true
  # Having groups assignable to roles requires Azure AD Premium. As a workaround add users directly
  # assignable_to_role = true
}

resource "azuread_group" "sensitive_data_observer" {
  display_name     = var.sensitive_data_observer_group_display_name
  security_enabled = true
  # Having groups assignable to roles requires Azure AD Premium. As a workaround add users directly
  # assignable_to_role = true
}

resource "azuread_group" "devops" {
  display_name     = var.devops_group_display_name
  security_enabled = true
  # Having groups assignable to roles requires Azure AD Premium. As a workaround add users directly
  # assignable_to_role = true
}

resource "azuread_group" "emergency_admin" {
  display_name     = var.emergency_admin_group_display_name
  security_enabled = true
  # Having groups assignable to roles requires Azure AD Premium. As a workaround add users directly
  # assignable_to_role = true
}

resource "azuread_group" "admin_kubernetes_cluster" {
  display_name     = var.admin_kubernetes_cluster_group_display_name
  security_enabled = true
  # Having groups assignable to roles requires Azure AD Premium. As a workaround add users directly
  # assignable_to_role = true
}

resource "azuread_group" "main_keyvault_secret_writer" {
  display_name     = var.main_keyvault_secret_writer_group_display_name
  security_enabled = true
  # Having groups assignable to roles requires Azure AD Premium. As a workaround add users directly
  # assignable_to_role = true
}
