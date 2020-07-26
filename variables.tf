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

variable "bucket-codepipeline" {
  type = "string"
  description = "bucket name where files will be stored"
}

variable "bucket-destination" {
  type = "string"
  description = "bucket name to extract files to"
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

