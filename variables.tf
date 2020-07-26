variable "enabled" {
  type = bool
  default = true
  description = "Set to false to prevent resource creation"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "namespace" {
  type        = string
  default     = ""
  description = "Your organization name or abbreviation of it"
}

variable "stage" {
  type        = string
  default     = ""
  description = "For example: 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags"
}

variable "bucket" {
  type = "string"
  description = "bucket name"
}

variable "owner-source" {
  type = "string"
  default = "ThirdParty"
  description = "Possible values are AWS, Custom and ThirdParty"
}

variable "owner-deploy" {
  type = "string"
  default = "AWS"
  description = "Possible values are AWS, Custom and ThirdParty"
}

variable "oauthtoken" {
  type = "string"
  description = "Authentication Token"
}
variable "repo" {
  type = "string"
  description = "GitHub repository name"
}

variable "owner" {
  type = "string"
  description = "GitHub account name"
}

variable "branch" {
  type = "string"
  default = "master"
  description = "GitHub branch name"
}

variable "version_" {
  type = "string"
  default = ""
  description = "version name"
}

variable "provider_source" {
  type = "string"
  default = "GitHub"
  description = "Provider of stage 'source' name, e.g. 'CodeBuild', 'GitHub', 'S3'"
}

variable "provider_deploy" {
  type = "string"
  default = "S3"
  description = "Provider of stage 'source' name, e.g. 'CodeBuild', 'GitHub', 'S3'"
}