# cluster resource
resource "aws_eks_cluster" "eks-cluster" {
  name     = "gitops-${var.environment}-cluster"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    security_group_ids     = [aws_security_group.eks-cluster-sg.id]
    subnet_ids             = aws_subnet.eks-node-subnet.*.id
    endpoint_public_access = "true"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-policy-cluster-attachment,
    aws_iam_role_policy_attachment.eks-policy-cluster-attach,
  ]
}



# create an iam role to be attached to the following policies: AmazonEKSClusterPolicy ,AmazonEKSServicePolicy
resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Sid": ""
      }
    ]
  }
POLICY

}

resource "aws_iam_role_policy_attachment" "eks-policy-cluster-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "eks-policy-cluster-attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

