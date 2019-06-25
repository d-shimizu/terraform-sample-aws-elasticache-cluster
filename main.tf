provider "aws" {
	region = "${var.region}"
	profile = "${var.profile}"
}

module "aws_elasticache" {
	source = "./modules/elasticache"
}
