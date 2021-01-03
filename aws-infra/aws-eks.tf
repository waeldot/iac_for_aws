resource "aws_eks_cluster" "ggr_eks" {
  name     = "ggr_eks"
  ## assign a role with AmazonEKSClusterPolicy for EKS
  role_arn = var.role_for_eks_cluster
  version = "1.18"

  vpc_config {
    subnet_ids = [ aws_subnet.ggr_subnet1.id, aws_subnet.ggr_subnet2.id ]
    security_group_ids = [ aws_default_security_group.ggr_secgrp1.id ]
    public_access_cidrs = [ "0.0.0.0/0" ]
    endpoint_public_access = true
    endpoint_private_access = true
  }
}

resource "aws_eks_node_group" "ggr_eksng" {
  cluster_name    = aws_eks_cluster.ggr_eks.name
  node_group_name = "ggr_eksng"
  node_role_arn   = var.role_for_eks_nodegroup
  subnet_ids = [ aws_subnet.ggr_subnet1.id, aws_subnet.ggr_subnet2.id ]
  version = "1.18"

  remote_access {
    ec2_ssh_key = var.ssh_keypair
  }

  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 1
  }
}
