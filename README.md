# ntfy-tailscale-docker

Docker container integrating ntfy with Tailscale to provide secure and private notifications through a mesh VPN network. This project is under development.

## Getting Started 🚀

This is a guide for deploying the ntfy container with Tailscale.

Check the **Installation** section for more information.

## Requirements 📋

Required programs:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Installation 🔧

### - Docker run (Not recommended)
```
docker run -e TAILSCALE_AUTH_KEY=tskey-auth-<your-auth-key-here> -e TAILSCALE_HOSTNAME=ntfy ghcr.io/javiito32/ntfy-tailscale-docker:latest
```
### ⚠️ Important

> **You will need to accept the connection in your Tailscale admin console if the Auth Key is not pre-approved.**

If the Auth Key is not configured to auto-approve connections, you must manually approve the connection request in the [Tailscale Admin Console](https://login.tailscale.com/admin). Failing to do so will prevent the service from joining your network.

Now your ntfy server should be working, you can change the environment variables according to your needs, more information in the “Environment variables” section.

---

### - Docker compose
```
services:
  ntfy:
    image: ghcr.io/javiito32/ntfy-tailscale-docker:latest
    container_name: ntfy
    environment:
      - TAILSCALE_AUTH_KEY=tskey-auth-<your-auth-key-here>
      - TAILSCALE_HOSTNAME=ntfy
      - TAILSCALE_NET_DOMAIN=ntfy.<your-tailnet-name>.ts.net
    volumes:
      - ./cache:/var/cache/ntfy
      - ./etc:/etc/ntfy
#    ports:
#      - 443:443
#      - 80:80
    healthcheck: # optional: remember to adapt the host:port to your environment
        test: ["CMD-SHELL", "wget -q --no-check-certificate --tries=1 https://127.0.0.1:443/v1/health -O - | grep -Eo '\"healthy\"\\s*:\\s*true' || exit 1"]
        interval: 60s
        timeout: 10s
        retries: 3
        start_period: 40s
    restart: unless-stopped # optional: this will keep your server up unless you stop it
```
### ⚠️ Important

> **You will need to accept the connection in your Tailscale admin console if the Auth Key is not pre-approved.**

If the Auth Key is not configured to auto-approve connections, you must manually approve the connection request in the [Tailscale Admin Console](https://login.tailscale.com/admin). Failing to do so will prevent the service from joining your network.

## Environment variables

Below are the environment variables required for configuring the project:

- **`TAILSCALE_AUTH_KEY`**: *(Required)*  
  The authentication key for Tailscale, needed to connect the service to the Tailscale network domain. This key can be generated from the Tailscale admin console.

- **`TAILSCALE_HOSTNAME`**: *(Required)*  
  The hostname for the device in the Tailscale network. This name should be unique and descriptive to help identify the device or service within the network.

- **`TAILSCALE_NET_DOMAIN`**: *(Optional)*  
  Specifies the Tailscale network domain that the service will connect to. If not provided, no certificate will be requested, you should be able to access it anyway over http.

## 🛠️ Ntfy Configuration

Ntfy can be configured by editing the `server.yml` file located at:

```bash
/etc/ntfy/server.yml
```
You can customize any Ntfy settings in this file according to your needs. For detailed configuration options and examples, please refer to the official [Ntfy documentation](https://docs.ntfy.sh/config/#example-config).

> Tip: Make sure to restart the Ntfy service after editing the configuration file to apply your changes.

## 🙏 Acknowledgements

This integration would not be possible without the incredible work of the [Ntfy project](https://ntfy.sh) and its creator, [binwiederhier](https://github.com/binwiederhier). Thank you for developing such a powerful and user-friendly notification service that inspired this project. 


## License 📄

This project is under AGPL-3.0-only - Checkout [LICENSE](LICENSE) for more detail

---
⌨️ with ❤️ by [Javiito32](https://github.com/Javiito32) 😊
