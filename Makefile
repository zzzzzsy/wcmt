INFRA_BASE=./infra

.PHONY: build push all

# infra module
gen-tfstate:
	cd ${INFRA_BASE}/tfstate && terraform init && \
	terraform apply

tf-init:
	cd ${INFRA_BASE} && terraform init
tf-fmt:
	cd ${INFRA_BASE} && terraform fmt
tf-plan:tf-fmt
	cd ${INFRA_BASE} && terraform plan
tf-apply:tf-plan
	cd ${INFRA_BASE} && terraform apply

# API module
test:
	go test -cover -v ./...
run-local: ## Run locally (requires local install of go)
	go run main.go run

build: ## Builds the docker container
	@docker build --pull -t ${IMAGETAG} .

push: ## Push the built container to the repo (requires login either public or private registry)
	@docker push ${IMAGETAG}

run-docker: build ## Run locally in docker (requires local access to a docker daemon).
	docker run -i -t -p 8080:8080 ${IMAGETAG}