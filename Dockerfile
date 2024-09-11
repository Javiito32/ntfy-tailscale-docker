FROM debian

# Update and upgrade
RUN apt update && apt upgrade -y
RUN apt install curl gnupg2 -y

# Install ntfy
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://archive.heckel.io/apt/pubkey.txt | gpg --dearmor -o /etc/apt/keyrings/archive.heckel.io.gpg
RUN apt install apt-transport-https
RUN sh -c "echo 'deb [arch=arm64 signed-by=/etc/apt/keyrings/archive.heckel.io.gpg] https://archive.heckel.io/apt debian main' \
    > /etc/apt/sources.list.d/archive.heckel.io.list"
RUN apt update
RUN apt install ntfy -y

RUN curl -fsSL https://tailscale.com/install.sh | sh

COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 80
EXPOSE 443

CMD ["/init.sh"]