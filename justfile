server_host := "tilde.club"
server_dir := "/home/jbaty/public_html"
public_dir := justfile_directory() / "public_html/"

# List recipes
default:
    @just --list

# Commit everything as a publish checkpoint
checkpoint:
    git add .
    git diff-index --quiet HEAD || git commit -m "Publish checkpoint"

# Push commits to the remote
push:
    git push

# Checkpoint, then rsync public_html to the server
deploy: checkpoint
    @echo "Deploying updates to {{server_host}}..."
    rsync -v -rz --checksum --delete --no-perms "{{public_dir}}" {{server_host}}:{{server_dir}}
    @echo "Finished deploy to {{server_host}} at $(date)"
