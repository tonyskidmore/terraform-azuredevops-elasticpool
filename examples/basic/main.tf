data "azuredevops_project" "main" {
  name = var.ado_service_connection_project_name
}

data "azuredevops_serviceendpoint_azurerm" "main" {
  project_id            = data.azuredevops_project.main.id
  service_endpoint_name = var.ado_service_connection_name
}

data "azurerm_virtual_machine_scale_set" "main" {
  name                = var.vmss_name
  resource_group_name = var.vmss_resource_group_name
}

module "terraform-azuredevops-elasticpool" {
  # source                    = "tonyskidmore/elasticpool/azuredevops"
  # version                   = "0.1.0"
    source                              = "../../"
    ado_pool_name                       = var.ado_pool_name
    ado_project_names                   = var.ado_project_names
  # ado_project_id                      = data.azuredevops_project.main.id
    ado_service_connection_id           = data.azuredevops_serviceendpoint_azurerm.main.id
    ado_service_connection_project_name = var.ado_service_connection_project_name
    ado_pool_desired_idle               = var.ado_pool_desired_idle
    ado_pool_max_capacity               = var.ado_pool_max_capacity
    ado_vmss_id                         = data.azurerm_virtual_machine_scale_set.main.id
    ado_pool_ttl_mins                   = var.ado_pool_ttl_mins
    ado_pool_auto_update                = var.ado_pool_auto_update
    ado_pool_auto_provision_projects    = var.ado_pool_auto_provision_projects
    ado_pool_recycle_after_use          = var.ado_pool_recycle_after_use
    ado_pool_auth_all_pipelines         = var.ado_pool_auth_all_pipelines
}
