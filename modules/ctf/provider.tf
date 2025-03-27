terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}

/*
  Note: Provider configuration (e.g., region) should be specified in the root module or via environment variables.
*/
