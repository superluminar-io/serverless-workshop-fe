PROJECT := sac-workshop
DEPENDENCIES = $(shell git ls-files)
TEMPLATE_FILENAME ?= initial.template

AWS_REGION ?= eu-central-1
INIT_BUCKET_NAME := $(PROJECT)-$(AWS_REGION)-init

bucket:
	@ if [[ `aws s3 ls | grep -e ' $(AWS_BUCKET_NAME)$$' | wc -l` -eq 1 ]]; then \
		echo "Bucket exists"; \
	else \
		aws s3 mb s3://$(AWS_BUCKET_NAME); \
	fi

frontend-init.zip: $(DEPENDENCIES)
	git archive -o $@ HEAD

init: frontend-init.zip
	aws s3 cp $^ s3://$(INIT_BUCKET_NAME)/$^

clean:
	rm frontend-init.zip
