locals {
  base_projects = (
    length(var.ado_project_names) != 1 ?
    { for p in data.azuredevops_projects.main[0].projects : p.name => p } :
    { data.azuredevops_project.main[0].name = {
      name       = data.azuredevops_project.main[0].name
      project_id = data.azuredevops_project.main[0].project_id
      }
    }
  )

  projects = (
    length(var.ado_project_names) > 1 ?
    { for p in local.base_projects : p.name => p if contains(var.ado_project_names, p.name) } :
    local.base_projects
  )

  auth_all_pipelines_projects = (
    var.ado_pool_auth_all_pipelines ?
    local.projects :
    {}
  )

  pipeline_auth_projects = (
    length(var.ado_skip_auth_all_projects) == 0 ?
    local.auth_all_pipelines_projects :
    { for p in local.auth_all_pipelines_projects : p.name => p if !contains(var.ado_skip_auth_all_projects, p.name) }
  )


  # service_endpoint_scope = local.projects[var.ado_service_connection_project_name]
  # service_endpoint_scope = { for k, v in local.projects : k => v if k == var.ado_service_connection_project_name }
  service_endpoint_scope = (
    { (var.ado_pool_name) = {
      name       = var.ado_pool_name
      project_id = local.projects[var.ado_service_connection_project_name].project_id # data.azuredevops_project.main[0].project_id
      }
    }
  )
}
