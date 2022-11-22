SERVER_HOST=tilde.club
SERVER_DIR=/home/jbaty/public_html
PUBLIC_DIR=/Users/jbaty/sites/tilde.club/public_html/
TARGET=tilde.club
STARTTIME:=`date`

.POSIX:
.PHONY: help build checkpoint deploy

checkpoint:
	git add .
	git diff-index --quiet HEAD || git commit -m "Publish checkpoint"

push:
	git push

deploy: checkpoint
	@echo "Deploying updates to $(TARGET)..."
	rsync -v -rz --checksum --delete --no-perms $(PUBLIC_DIR) $(SERVER_HOST):$(SERVER_DIR)
	@echo "Finished deploy to $(TARGET) at `date`"

