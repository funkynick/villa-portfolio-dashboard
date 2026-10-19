#!/usr/bin/env sh
# Pull the latest main on the postone server and reload Caddy.
# Usage: ./deploy/deploy.sh   (push to GitHub first: the server pulls from origin)
set -eu
DEPLOY_HOST="${DEPLOY_HOST:-postone}"
DEPLOY_PATH="${DEPLOY_PATH:-/home/postone/sites/villa-portfolio-dashboard}"
CADDY="${CADDY_CONTAINER:-postone-prod-caddy-1}"
ssh "$DEPLOY_HOST" "set -e
  git -C '$DEPLOY_PATH' pull --ff-only
  git -C '$DEPLOY_PATH' log -1 --format='Deployed: %h %s'
  docker exec $CADDY caddy validate --config /etc/caddy/Caddyfile --adapter caddyfile
  docker exec $CADDY caddy reload --config /etc/caddy/Caddyfile --adapter caddyfile"
