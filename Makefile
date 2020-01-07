.PHONY: help

terraform=docker run -it -e AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID -e AWS_SESSION_TOKEN \
	--rm -v `pwd`:/app/ -w /app/ hashicorp/terraform:0.12.18

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

tf-init: ## terraform init
	$(terraform) init

## Using workspace

#
# create a workspace in advance
#   $terraform workspace new workspace1
#

tf-setup-workspace1: ## terraform setup workspace1
	$(terraform) workspace select workspace1

tf-plan-workspace1: tf-setup-workspace1 ## terraform plan workspace1
	$(terraform) plan -var-file=terraform.workspace1.tfvars

tf-apply-workspace1: tf-setup-workspace1 ## terraform apply workspace1
	$(terraform) apply -var-file=terraform.workspace1.tfvars

tf-plan-destroy-workspace1: tf-setup-workspace1 ## terraform plan destroy workspace1
	$(terraform) plan -destroy -var-file=terraform.workspace1.tfvars

tf-destroy-workspace1: tf-setup-workspace1 ## terraform destroy workspace1
	$(terraform) destroy -var-file=terraform.workspace1.tfvars
