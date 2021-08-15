
INFRA_BASE=./infra

tf-init:
	cd ${INFRA_BASE} && terraform init
tf-fmt:
	cd ${INFRA_BASE} && terraform fmt
tf-plan:tf-fmt
	cd ${INFRA_BASE} && terraform plan
tf-apply:tf-plan
	cd ${INFRA_BASE} && terraform apply