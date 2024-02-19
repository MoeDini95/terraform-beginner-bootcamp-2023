variable "user_uuid" {
  description = "User UUID in the desired format"
  type        = string

    validation {
        condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
        error_message = "User UUID must be in the format 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' where x is a hexadecimal character."
    }
}
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = (
      length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && 
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
    )
    error_message = "The bucket name must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
  }
}


variable "index_html_filepath" {
  description = "Filepath to the index.html file"
  type = string
  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified file path for index.html does not exist."
  }
}

variable "error_html_filepath" {
  description = "Filepath to the error.html file"
  type = string
  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified file path for error.html does not exist."
  }
}