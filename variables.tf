variable "ado_project_names" {
  type        = list(string)
  description = "List of Azure DevOps project names where to create the agent pool. An empty list will create the pool in all projects."
  default     = []
}

variable "ado_projects_state" {
  type        = string
  description = "The state of Azure DevOps project state the data resource should be filtered on."
  default     = null
}

variable "ado_skip_auth_all_projects" {
  type        = list(string)
  description = "List of Azure DevOps projects to exclude from authorizing all pipelines."
  default     = []
}

variable "ado_service_connection_id" {
  type        = string
  description = "Azure DevOps AzureRm service connection ID"
}

variable "ado_vmss_id" {
  type        = string
  description = "Azure Virtual Machine Scale Set Resource ID if not created by the module"
  default     = ""
}

variable "ado_service_connection_project_name" {
  type        = string
  description = "Azure DevOps project name where service connection exists"
}

variable "ado_pool_desired_idle" {
  type        = number
  description = "Number of machines to have ready waiting for jobs"
  default     = 0
}

variable "ado_pool_max_capacity" {
  type        = number
  description = "Maximum number of machines that will exist in the elastic pool"
  default     = 2
}

variable "ado_pool_name" {
  type        = string
  description = "Azure DevOps agent pool name"
  default     = "azdo-vmss-pool-001"
}

variable "ado_pool_recycle_after_use" {
  type        = bool
  description = "Discard machines after each job completes"
  default     = false
}

variable "ado_pool_ttl_mins" {
  type        = number
  description = "The minimum time in minutes to keep idle agents alive"
  default     = 30
}

variable "ado_pool_auth_all_pipelines" {
  type        = bool
  description = "Setting to determine if all pipelines are authorized to use this TaskAgentPool by default (at create only)"
  default     = false
}

variable "ado_pool_auto_update" {
  type        = string
  description = "Specifies whether or not agents within the pool should be automatically updated"
  default     = true
}

variable "ado_pool_auto_provision_projects" {
  type        = string
  description = "Setting to automatically provision TaskAgentQueues in every project for the new pool"
  default     = false
}

variable "ado_pool_agent_interactive_ui" {
  type        = bool
  description = "Set whether agents should be configured to run with interactive UI"
  default     = false
}
