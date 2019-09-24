PROJECT := sac-workshop
DEPENDENCIES = $(shell git ls-files)
TEMPLATE_FILENAME ?= initial.template

AWS_REGION ?= eu-central-1
INIT_BUCKET_NAME := $(PROJECT)-$(AWS_REGION)-init

bucket:
	@ if [[ `aws s3 ls | grep -e ' $(INIT_BUCKET_NAME)$$' | wc -l` -eq 1 ]]; then \
		echo "Bucket exists"; \
	else \
		aws s3 mb s3://$(INIT_BUCKET_NAME); \
	fi

frontend-init.zip: $(DEPENDENCIES)
	git archive -o $@ HEAD

init: bucket frontend-init.zip
	aws s3 cp frontend-init.zip s3://$(INIT_BUCKET_NAME)/frontend-init.zip

clean:
	rm frontend-init.zip
