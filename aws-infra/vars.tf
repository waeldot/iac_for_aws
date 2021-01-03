variable "region" {
  default = "ap-northeast-2"
}

variable "access_key" {
  default = "ACCESS_KEY"
}

variable "secret_key" {
  default = "SECRET_KEY"
}

variable "role_for_eks_cluster" {
  default = "arn:aws:iam::355401122621:role/EKSCluster_admin"
}

variable "role_for_eks_nodegroup" {
  default = "arn:aws:iam::355401122621:role/EKSEC2_admin"
}

variable "ssh_keypair" {
  default = "ggr_sshkey"
}
