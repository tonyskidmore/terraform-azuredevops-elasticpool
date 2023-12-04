# terraform-azuredevops-elasticpool

[![GitHub Super-Linter](https://github.com/tonyskidmore/terraform-azuredevops-elasticpool/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)

Azure DevOps Elastic Pool (Virtual Machine Scale Set) Terraform module.
It forms the starting point for the creation of a Windows or Linux
[Azure virtual machine scale set agent][scale-agents]
pool in Azure DevOps.

This module is used by the [terraform-azurerm-vmss-devops-agent](https://registry.terraform.io/modules/tonyskidmore/vmss-devops-agent/azurerm/latest)
to create the Azure DevOps self-hosted Azure DevOps Scale Set agent pool.

<!-- BEGIN_TF_DOCS -->



## Basic example

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
## Resources

| Name | Type |
|------|------|
| [azuredevops_agent_queue.main](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/agent_queue) | resource |
| [azuredevops_elastic_pool.main](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/elastic_pool) | resource |
| [azuredevops_pipeline_authorization.main](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/pipeline_authorization) | resource |
| [azuredevops_project.main](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azuredevops_projects.main](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/projects) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ado_pool_agent_interactive_ui"></a> [ado\_pool\_agent\_interactive\_ui](#input\_ado\_pool\_agent\_interactive\_ui) | Set whether agents should be configured to run with interactive UI | `bool` | `false` | no |
| <a name="input_ado_pool_auth_all_pipelines"></a> [ado\_pool\_auth\_all\_pipelines](#input\_ado\_pool\_auth\_all\_pipelines) | Setting to determine if all pipelines are authorized to use this TaskAgentPool by default (at create only) | `bool` | `false` | no |
| <a name="input_ado_pool_auto_provision_projects"></a> [ado\_pool\_auto\_provision\_projects](#input\_ado\_pool\_auto\_provision\_projects) | Setting to automatically provision TaskAgentQueues in every project for the new pool | `string` | `false` | no |
| <a name="input_ado_pool_auto_update"></a> [ado\_pool\_auto\_update](#input\_ado\_pool\_auto\_update) | Specifies whether or not agents within the pool should be automatically updated | `string` | `true` | no |
| <a name="input_ado_pool_desired_idle"></a> [ado\_pool\_desired\_idle](#input\_ado\_pool\_desired\_idle) | Number of machines to have ready waiting for jobs | `number` | `0` | no |
| <a name="input_ado_pool_max_capacity"></a> [ado\_pool\_max\_capacity](#input\_ado\_pool\_max\_capacity) | Maximum number of machines that will exist in the elastic pool | `number` | `2` | no |
| <a name="input_ado_pool_name"></a> [ado\_pool\_name](#input\_ado\_pool\_name) | Azure DevOps agent pool name | `string` | `"azdo-vmss-pool-001"` | no |
| <a name="input_ado_pool_recycle_after_use"></a> [ado\_pool\_recycle\_after\_use](#input\_ado\_pool\_recycle\_after\_use) | Discard machines after each job completes | `bool` | `false` | no |
| <a name="input_ado_pool_ttl_mins"></a> [ado\_pool\_ttl\_mins](#input\_ado\_pool\_ttl\_mins) | The minimum time in minutes to keep idle agents alive | `number` | `30` | no |
| <a name="input_ado_project_names"></a> [ado\_project\_names](#input\_ado\_project\_names) | List of Azure DevOps project names where to create the agent pool. An empty list will create the pool in all projects. | `list(string)` | `[]` | no |
| <a name="input_ado_projects_state"></a> [ado\_projects\_state](#input\_ado\_projects\_state) | The state of Azure DevOps project state the data resource should be filtered on. | `string` | `null` | no |
| <a name="input_ado_service_connection_id"></a> [ado\_service\_connection\_id](#input\_ado\_service\_connection\_id) | Azure DevOps AzureRm service connection id | `string` | n/a | yes |
| <a name="input_ado_service_connection_project_name"></a> [ado\_service\_connection\_project\_name](#input\_ado\_service\_connection\_project\_name) | Azure DevOps project name where service connection exists | `string` | n/a | yes |
| <a name="input_ado_skip_auth_all_projects"></a> [ado\_skip\_auth\_all\_projects](#input\_ado\_skip\_auth\_all\_projects) | List of Azure DevOps projects to exclude from authorizing all pipelines. | `list(string)` | `[]` | no |
| <a name="input_ado_vmss_id"></a> [ado\_vmss\_id](#input\_ado\_vmss\_id) | Azure Virtual Machine Scale Set Resource ID if not created by the module | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ado_vmss_pool_output"></a> [ado\_vmss\_pool\_output](#output\_ado\_vmss\_pool\_output) | Azure DevOps VMSS Agent Pool output |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | >= 0.10.0 |


<!-- END_TF_DOCS -->

## Troubleshooting

### Linux

Use the Serial console in the portal or via the Azure CLI to help troubleshoot deployment issues:

````bash

# Press enter to get a login
vmss-agent-pool-linux-003000000 login: adminuser
Password:

Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1052-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Dec  2 13:18:05 UTC 2023

  System load:  0.04              Processes:             122
  Usage of /:   7.5% of 28.89GB   Users logged in:       0
  Memory usage: 5%                IPv4 address for eth0: 192.168.0.4
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

2 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.


````


### Windows

Use the Serial console in the portal or via the Azure CLI to help troubleshoot deployment issues:

````bash

# specify the VMSS name (-n), Resource group (-g) and instance number (e.g. 0)
az serial-console connect -n vmss-win-ado-001 -g rg-vmss-win-001 --instance-id 0

````

````bash

cmd
ch
ch -si 1

Please enter login credentials.
?Username: ?adminuser
Domain  : ?
Password: ?********************

````

[scale-agents]: https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents
