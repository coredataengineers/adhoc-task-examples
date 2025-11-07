locals {
  redshift_tags = {
    Service-Name = "Redshift"
  }
}

resource "aws_iam_role" "redshift_role" {
  name = "redshift-dedicated-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(local.generic_tag, local.redshift_tags)
}

data "aws_iam_policy_document" "redshift_role_policy" {
  statement {
    sid = "S3ReadAndWrite"

    actions = [
      "s3:*List*",
      "s3:*Get*",
      "s3:*Put*"
    ]

    resources = [
      "arn:aws:s3:::cde-redshift-spectrum-demo",
      "arn:aws:s3:::cde-redshift-spectrum-demo/*",
    ]
  }

  statement {
    sid = "GlueAccess"

    actions = [
      "Glue:*"
    ]

    resources = [
      "*",
    ]
  }

}

resource "aws_iam_policy" "redshift_policy" {
  name   = "dedicated-redshift-policy"
  policy = data.aws_iam_policy_document.redshift_role_policy.json
}

resource "aws_iam_role_policy_attachment" "redshift_role_policy_bind" {
  role       = aws_iam_role.redshift_role.name
  policy_arn = aws_iam_policy.redshift_policy.arn
}


resource "random_password" "redshift_password" {
  length  = 16
  special = false
}

resource "aws_ssm_parameter" "redshift_db_password" {
  name  = "/dev/redshift/db_password"
  type  = "String"
  value = random_password.redshift_password.result
}

data "aws_ssm_parameter" "redshift_db_username" {
  name = "/dev/redshift/db_username"
}


resource "aws_redshift_cluster" "cde_cluster" {
  cluster_identifier  = "core-data-engineers-cluster"
  database_name       = "core_data_engineers"
  master_username     = data.aws_ssm_parameter.redshift_db_username.value
  master_password     = aws_ssm_parameter.redshift_db_password.value
  node_type           = "ra3.large"
  cluster_type        = "multi-node"
  number_of_nodes     = 2
  publicly_accessible = true
  skip_final_snapshot = true
  iam_roles           = [aws_iam_role.redshift_role.arn]

  tags = merge(
    local.generic_tag,
    local.redshift_tags
  )
}