PROJECT := url-shortener
AWS_REGION ?= eu-central-1
BUCKET_NAME := $(PREFIX)-$(PROJECT)-$(REGION)-frontend

bucket: guard-PREFIX
	@ if [ `aws s3 ls | grep -e ' $(BUCKET_NAME)$$' | wc -l` -eq 1 ]; then \
		echo "Bucket exists"; \
	else \
		aws s3 mb s3://$(BUCKET_NAME) --region $(AWS_REGION); \
	fi

build:
	@ npm run-script build

deploy: guard-PREFIX bucket build
	@ aws s3 sync build s3://$(BUCKET_NAME) --acl public-read --delete
	@ echo "Frontend got deployed to: https://$(BUCKET_NAME).s3.eu-central-1.amazonaws.com/index.html"

guard-%:
	@ if [ -z '${${*}}' ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

.PHONY: deploy build
