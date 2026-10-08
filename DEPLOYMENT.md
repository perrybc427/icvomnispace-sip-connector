# iCV OmniSpace SIP connector deployment

## Build and deploy target

The image builds Asterisk from the official `22.11.0` source tag. GitHub Actions builds and smoke-tests the image on pushes and pull requests targeting `main`. A push to `main` also publishes the versioned image to GitHub Container Registry.

The KVM deployment job is intentionally gated. Before enabling it, make the container package publicly pullable so the VPS can fetch it, add the GitHub Actions secret `HOSTINGER_API_KEY`, and set the repository Actions variable `HOSTINGER_DEPLOY_ENABLED` to `true`. The workflow targets KVM 2, virtual machine `1888948`. The deployment action uses the root `docker-compose.yml` and project name `icv-sip-connector`.

## Safe initial state

The Compose file publishes no host ports. The PJSIP configuration contains no transport, account, provider endpoint, or credentials; AMI and ARI are not configured. This keeps the initial container isolated and prevents an unauthenticated SIP service from being exposed. No SIP provider registration or calls are configured by this build.

Provider settings must be added later through an approved protected server-side secret path. Do not commit SIP usernames, passwords, tokens, or customer call data to this repository. Expose only the specific SIP and RTP ports needed after authenticated provider settings and firewall rules are ready.
