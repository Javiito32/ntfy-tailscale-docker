FROM debian

LABEL org.opencontainers.image.authors="github.com/Javiito32"
LABEL org.opencontainers.image.url="https://github.com/Javiito32/ntfy-tailscale-docker"
LABEL org.opencontainers.image.documentation="https://github.com/Javiito32/ntfy-tailscale-docker"
LABEL org.opencontainers.image.source="https://github.com/Javiito32/ntfy-tailscale-docker"
LABEL org.opencontainers.image.vendor="Javiito32"
LABEL org.opencontainers.image.licenses="AGPL-3.0-only"
LABEL org.opencontainers.image.title="ntfy-tailscale"
LABEL org.opencontainers.image.description="Ntfy integration with tailscale"

ARG TARGETARCH

# Update
RUN apt update
RUN apt install curl gnupg2 -y

# Install ntfy
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://archive.heckel.io/apt/pubkey.txt | gpg --dearmor -o /etc/apt/keyrings/archive.heckel.io.gpg
RUN apt install apt-transport-https
RUN sh -c "echo 'deb [arch=$TARGETARCH signed-by=/etc/apt/keyrings/archive.heckel.io.gpg] https://archive.heckel.io/apt debian main' \
    > /etc/apt/sources.list.d/archive.heckel.io.list"
RUN apt update
RUN apt install ntfy -y

RUN curl -fsSL https://tailscale.com/install.sh | sh

COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 80
EXPOSE 443

CMD ["/init.sh"]
