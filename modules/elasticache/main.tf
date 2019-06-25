resource "aws_security_group" "this" {
  // name_prefix = "${var.namespace}"
  name_prefix = "cahce-default-tf-sg"
  //vpc_id      = "${aws_vpc.default.id}"
  vpc_id	= "${var.default_vpc}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_elasticache_replication_group" "this" {
  replication_group_id           = "redis-cluster-tf"
  replication_group_description = "redis cluster description"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  // number_cache_clusters       = 1
  parameter_group_name = "default.redis5.0.cluster.on"
  engine_version       = "5.0.4"
  port                 = 6379
  subnet_group_name    = "default"
  // security_group_ids   = "${aws_security_group.this.id}"
  security_group_ids   = ["${aws_security_group.this.id}"]

  automatic_failover_enabled    = true

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 1
  }
}
