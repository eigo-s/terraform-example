terraform {
  required_version = "~> 0.11.0"
}

provider "aws" {
  version = "~> 1.5.0"
  region  = "ap-northeast-1"
}

provider "null" {}
