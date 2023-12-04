variable "ado_org" {
  type        = string
  description = "Azure DevOps Organization name. AZDO_ORG_SERVICE_URL environment variable can be used instead."
  default     = null
}

variable "ado_token" {
  type        = string
  description = "Azure DevOps Authentication Token (PAT). AZDO_PERSONAL_ACCESS_TOKEN environment variable can be used instead."
  sensitive   = true
  default     = null
}

variable "ado_project_names" {
  type        = list(string)
  description = "List of Azure DevOps project names where to create the agent pool. An empty list will create the pool in all projects."
  default     = []
}

variable "ado_pool_name" {
  type        = string
  description = "Azure DevOps Agent Pool name"
}

variable "ado_service_connection_name" {
  type        = string
  description = "Azure DevOps azure service connection name"
}

variable "ado_service_connection_project_name" {
  type        = string
  description = "Azure DevOps azure service connection name"
}

variable "vmss_name" {
  type        = string
  description = "Azure Virtual Machine Scale Set name"
}

variable "vmss_resource_group_name" {
  type        = string
  description = "Azure Virtual Machine Scale Set resurce group name"
}

variable "ado_pool_max_capacity" {
  type        = number
  description = "Maximum number of machines that will exist in the elastic pool"
  default     = 2
}

variable "ado_pool_desired_idle" {
  type        = number
  description = "Number of machines to have ready waiting for jobs"
  default     = 0
}

variable "ado_pool_ttl_mins" {
  type        = number
  description = "Number of minutes to keep a machine in the pool after it has been used"
  default     = 10
}

variable "ado_pool_recycle_after_use" {
  type        = bool
  description = "Number of minutes to keep a machine in the pool after it has been used"
  default     = false
}

variable "ado_pool_auto_update" {
  type        = string
  description = "Specifies whether or not agents within the pool should be automatically updated"
  default     = true
}

variable "ado_pool_auto_provision_projects" {
  type        = string
  description = "Specifies whether a queue should be automatically provisioned for each project collection"
  default     = true
}

variable "ado_pool_auth_all_pipelines" {
  type        = bool
  description = "Setting to determine if all pipelines are authorized to use this TaskAgentPool by default (at create only)"
  default     = false
}

variable "ado_projects" {
  type = list(string)
  description = "List of Azure DevOps projects where to create the agent pool. An empty list will create the pool in all projects."
  default = []
}
