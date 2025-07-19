variable "RENDER_API_KEY" {
  description = "Render API Key"
  type        = string
  sensitive   = true
}

variable "OWNER_ID" {
  description = "Owner ID"
  type        = string
  sensitive   = true
}

variable "repo_url" {
  description = "GitHub repo URL"
  type        = string
}

variable "repo_branch" {
  description = "Git branch to deploy"
  type        = string
  default     = "devs"
}

variable "DATABASE_URL" {
  description = "Database"
  type        = string
}
