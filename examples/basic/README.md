<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| azuredevops | >= 0.10.0 |
| azurerm | >=3.1.0 |

## Providers

| Name | Version |
|------|---------|
| azuredevops | 0.10.0 |
| azurerm | 3.83.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| terraform-azuredevops-elasticpool | ../../ | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ado\_org | Azure DevOps Organization name. AZDO\_ORG\_SERVICE\_URL environment variable can be used instead. | `string` | `null` | no |
| ado\_pool\_auth\_all\_pipelines | Setting to determine if all pipelines are authorized to use this TaskAgentPool by default (at create only) | `bool` | `false` | no |
| ado\_pool\_auto\_provision\_projects | Specifies whether a queue should be automatically provisioned for each project collection | `string` | `true` | no |
| ado\_pool\_auto\_update | Specifies whether or not agents within the pool should be automatically updated | `string` | `true` | no |
| ado\_pool\_desired\_idle | Number of machines to have ready waiting for jobs | `number` | `0` | no |
| ado\_pool\_max\_capacity | Maximum number of machines that will exist in the elastic pool | `number` | `2` | no |
| ado\_pool\_name | Azure DevOps Agent Pool name | `string` | n/a | yes |
| ado\_pool\_recycle\_after\_use | Number of minutes to keep a machine in the pool after it has been used | `bool` | `false` | no |
| ado\_pool\_ttl\_mins | Number of minutes to keep a machine in the pool after it has been used | `number` | `10` | no |
| ado\_project\_names | List of Azure DevOps project names where to create the agent pool. An empty list will create the pool in all projects. | `list(string)` | `[]` | no |
| ado\_service\_connection\_name | Azure DevOps azure service connection name | `string` | n/a | yes |
| ado\_service\_connection\_project\_name | Azure DevOps azure service connection name | `string` | n/a | yes |
| ado\_token | Azure DevOps Authentication Token (PAT). AZDO\_PERSONAL\_ACCESS\_TOKEN environment variable can be used instead. | `string` | `null` | no |
| vmss\_name | Azure Virtual Machine Scale Set name | `string` | n/a | yes |
| vmss\_resource\_group\_name | Azure Virtual Machine Scale Set resurce group name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | Azure DevOps VMSS Agent Pool |



Example

```hcl
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
  source            = "../../"
  ado_pool_name     = var.ado_pool_name
  ado_project_names = var.ado_project_names
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
```
<!-- END_TF_DOCS -->
