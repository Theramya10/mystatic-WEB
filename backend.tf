terraform {
  backend "s3" {
    bucket         = "theramya10"
    key            = "My1stWEB/tfstate/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
