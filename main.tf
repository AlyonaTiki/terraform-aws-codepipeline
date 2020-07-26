###naming label in format: {namespace}-{stage}-{name}
module "label_role" {
  source     = "github.com/cloudposse/terraform-null-label.git?ref=0.16.0"
  enabled    = var.enabled
  delimiter  = var.delimiter
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
  tags       = var.tags
}

module "label_codepipeline" {
  source     = "github.com/cloudposse/terraform-null-label.git?ref=0.16.0"
  enabled    = var.enabled
  delimiter  = var.delimiter
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
  tags       = var.tags
}

resource "aws_iam_policy" "codebuild" {
  count  = var.enabled ? 1 : 0
  name   = module.label_codepipeline.id
  policy = data.aws_iam_policy_document.policy_doc.json
}

#Policy for the codepipeline service role
data "aws_iam_policy_document" "policy_doc" {
  statement {
    sid = ""

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision",
      "ec2:*",
      "cloudwatch:*",
      "s3:*",
      "cloudformation:*",
//      "lambda:*",
      "codebuild:*",

    ]

    resources = "*"
    effect    = "Allow"

  }
}

###CodePipeline service role
resource "aws_iam_role" "default" {
  count              = var.enabled ? 1 : 0
  name               = module.label_role.id
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
}

data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    effect = "Allow"
  }
}

###attach the policy to the service role
resource "aws_iam_role_policy_attachment" "serice-role-github" {
  count      = var.enabled ? 1 : 0
  role       = join("", aws_iam_role.default.*.id)
  policy_arn = join("", aws_iam_policy.codebuild.*.arn)
}

### CI/CD Pipeline
resource "aws_codepipeline" "pipeline" {
  name     = module.label_codepipeline.id
  role_arn = join("", aws_iam_role.default.*.arn)

  artifact_store {
    location = var.bucket-codepipeline
    type     = "S3"
  }

  //source where to get files
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = var.version_
      output_artifacts = ["SourceArtifact"]

      configuration = {
        Owner  = var.owner
        Repo   = var.repo
        Branch = var.branch
        OAuthToken = var.oauthtoken
      }
    }
  }

  //where to deploy files
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["SourceArtifact"]
      version         = var.version_

      //unzip files and upload to bucket
      configuration = {
        BucketName = var.bucket-destination
        Extract = "true"
      }
    }
  }
}
//resource "aws_codepipeline_webhook" "webhook" {
//  count           = var.enabled && var.webhook_enabled ? 1 : 0
//  name            = module.label_codepipeline.id
//  authentication  = var.webhook_authentication
//  target_action   = var.webhook_target_action
//  target_pipeline = join("", aws_codepipeline.pipeline.*.name)
//
//  authentication_configuration {
//    secret_token = local.webhook_secret
//  }
//
//  filter {
//    json_path    = var.webhook_filter_json_path
//    match_equals = var.webhook_filter_match_equals
//  }
//}

//resource "github_repository_webhook" "foo" {
//  repository = ""
//
//  name = "web"
//
//  configuration {
//    url          = "https://google.de/"
//    content_type = "form"
//    insecure_ssl = false
//  }
//
//  active = false
//
//  events = ["issues"]
//}
