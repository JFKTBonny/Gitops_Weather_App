# EKS Cluster
resource "aws_eks_cluster" "gitops_eks" {
  name     = "gitops-${var.environment}-eks"
  role_arn = aws_iam_role.eks_role.arn

  version = var.cluster_version

  vpc_config {
    subnet_ids             = [aws_subnet.default_subnet.id, aws_subnet.eks_subnet.id]
    endpoint_public_access = "true"
    security_group_ids      = [aws_security_group.cluster_sg.id]
  }

}


