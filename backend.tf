terraform {
  backend "s3" {
    bucket         = "deepaksabane0438"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    profile        = "arati_sdlc"
  }
}