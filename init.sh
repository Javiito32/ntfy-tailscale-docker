#!/bin/bash

if [ ! -f /initialized ]; then
  tailscaled --tun=userspace-networking & tailscale up --authkey=$TAILSCALE_AUTH_KEY --hostname=$TAILSCALE_HOSTNAME
  if [ -n "$TAILSCALE_NET_DOMAIN" ]; then
    tailscale cert $TAILSCALE_NET_DOMAIN
  fi
  touch /initialized
else
    tailscaled --tun=userspace-networking & tailscale up
fi

tailscale serve --bg https+insecure://localhost:443
ntfy serve