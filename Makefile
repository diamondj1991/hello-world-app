# Variables (?= will allow us to override versioning `make build {major.minor.patch}` via the CLI without editing the file)
IMAGE_NAME := jdiamond1991/hello-world-app
VERSION ?= v4.0.0
TAG := $(VERSION)

.PHONY: install test build push clean

# 1. Install dependencies
install:
	pip install -r requirements.txt
	pip install pytest

# 2. Run Unit Tests
test:
	python3 -m pytest tests/

# 3. Build the Docker Image
build:
	docker build -t $(IMAGE_NAME):$(TAG) .

# 4. Push to Docker Hub
push:
	docker push $(IMAGE_NAME):$(TAG)

# 5. Cleanup
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	rm -rf .pytest_cache
	rm -rf .venv