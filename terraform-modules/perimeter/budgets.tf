
resource "azurerm_consumption_budget_subscription" "subscription_budget" {
  name            = var.subscription_budget_name
  subscription_id = data.azurerm_subscription.current.id

  amount     = var.subscription_budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00'Z'", timestamp())
  }

  notification {
    enabled   = true
    threshold = 80.0
    operator  = "EqualTo"

    contact_emails = var.budget_contact_emails
  }

  notification {
    enabled        = true
    threshold      = 100.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = var.budget_contact_emails
  }
  lifecycle {
    ignore_changes = [time_period[0].start_date]
  }
}
