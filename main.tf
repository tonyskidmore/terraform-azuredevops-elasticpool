data "azuredevops_project" "main" {
  count = (var.ado_project_names != null) && (length(var.ado_project_names) == 1) ? 1 : 0
  name  = var.ado_project_names[0]
}

data "azuredevops_projects" "main" {
  count = (length(var.ado_project_names) == 0) || (length(var.ado_project_names) != 1) ? 1 : 0
  state = var.ado_projects_state
}

resource "azuredevops_elastic_pool" "main" {
  for_each               = local.service_endpoint_scope
  name                   = var.ado_pool_name
  service_endpoint_id    = var.ado_service_connection_id
  service_endpoint_scope = each.value.project_id
  desired_idle           = var.ado_pool_desired_idle
  max_capacity           = var.ado_pool_max_capacity
  azure_resource_id      = var.ado_vmss_id
  recycle_after_each_use = var.ado_pool_recycle_after_use
  time_to_live_minutes   = var.ado_pool_ttl_mins
  agent_interactive_ui   = var.ado_pool_agent_interactive_ui
  auto_provision         = var.ado_pool_auto_provision_projects
  auto_update            = var.ado_pool_auto_update
}

resource "azuredevops_agent_queue" "main" {
  for_each      = local.projects
  project_id    = each.value.project_id
  agent_pool_id = azuredevops_elastic_pool.main[var.ado_pool_name].id
}

resource "azuredevops_pipeline_authorization" "main" {
  for_each    = local.pipeline_auth_projects
  project_id  = each.value.project_id
  resource_id = azuredevops_agent_queue.main[each.key].id
  type        = "queue"
}
