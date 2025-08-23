# EKS Node Group
resource "aws_eks_node_group" "gitops_node_group" {
  cluster_name    = "gitops-${var.environment}-eks"
  node_group_name = "gitops-${var.environment}-workers-nodes"
  node_role_arn   = aws_iam_role.worker_nodes_role.arn
  subnet_ids      = [aws_subnet.default_subnet.id, aws_subnet.eks_subnet.id]
  capacity_type   = "ON_DEMAND"
  

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }


  disk_size = 30


  tags = {
    Name = "gitops-${var.environment}-workers-nodes"
  }

  depends_on = [aws_iam_role.worker_nodes_role, aws_eks_cluster.gitops_eks]
}

# resource "aws_security_group" "eks_worker_nodes" {
#   name        = "gitops-real-nodes-sg"
#   description = "SG for EKS worker nodes"
#   vpc_id      = aws_vpc.gitops_vpc.id

#   ingress {
#     description      = "Allow all traffic within the SG"
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     self             = true
#   }

#   ingress {
#     description      = "Allow HTTPS traffic from EKS control plane"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     security_groups  = [aws_security_group.eks_nodes]
#   }

#   egress {
#     description = "Allow all outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "gitops-real-nodes-sg"
#   }
# }
