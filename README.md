# terraform-aws-codepipeline
Terraform Module for CD(contunious delivery) with AWS Code Pipeline.<br/>
Allows to update S3 Bucket and connect it to GitHub repository.<br/>
**Important:** S3 Bucket has to be already created 
<br/>
## Example:
```
  module "codepipeline-s3" {
  source = "git::https://github.com/AlyonaTiki/terraform-aws-codepipeline.git?ref=tags/v0.1.4"
  bucket-codepipeline = "bucket-id"
  bucket-destination = "bucket-name"
  oauthtoken = "xxxxxxxxxxxxxx"
  repo = "repo-name"
  owner = "owner-name"
  name = "app"
  stage   = "staging"
}
```
