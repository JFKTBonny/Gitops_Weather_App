
# node group resource
resource "aws_eks_node_group" "eks-cluster-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "gitops-${var.environment}-workers"
  node_role_arn   = aws_iam_role.eks-worker-role.arn
  subnet_ids      = aws_subnet.eks-node-subnet.*.id

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes  = [scaling_config] # ignore size changes if you scale outside Terraform
  }

  #  Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.worker-node-policy,
    aws_iam_role_policy_attachment.worker-node-cni,
    aws_iam_role_policy_attachment.worker-node-ecr,
    

  ]
}




# # for the workers nodes,we must create an iam role to attach to: AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, AmazonEC2ContainerRegistryReadOnly
resource "aws_iam_role" "eks-worker-role" {
  name = "eks-worker-role"

  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Sid": ""
      }
    ]
  }
POLICY

}


resource "aws_iam_role_policy_attachment" "worker-node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-worker-role.name
}


resource "aws_iam_role_policy_attachment" "worker-node-cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-worker-role.name
}


resource "aws_iam_role_policy_attachment" "worker-node-ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-worker-role.name
}


