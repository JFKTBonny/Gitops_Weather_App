# EKS Cluster
resource "aws_eks_cluster" "gitops_eks" {
  name     = "gitops-${var.environment}-eks"
  role_arn = aws_iam_role.eks_role.arn

  version = var.cluster_version

  vpc_config {
    subnet_ids             = [aws_subnet.default_subnet.id, aws_subnet.eks_subnet.id]
    endpoint_public_access = "true"
  }

}


resource "aws_security_group" "eks_nodes" {
  name        = "gitops-real-workers-sg"
  vpc_id      = aws_vpc.gitops_vpc.id

  ingress {
    description     = "Allow HTTPS traffic from EKS control plane"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_eks_cluster.gitops_eks.vpc_config[0].cluster_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}