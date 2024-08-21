variable "tags" {
  description = "Tags to apply to all resources"
  type = map(string)
  default = {}
}

variable "location" {
  description = "Default Project location"
  type        = string
}