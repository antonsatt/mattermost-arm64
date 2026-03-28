# Mattermost ARM64 Docker Images

Automated ARM64 (`aarch64`) Docker builds for [Mattermost](https://mattermost.com/), since the official images only support `amd64`.

Uses official Mattermost ARM64 binaries from [releases.mattermost.com](https://releases.mattermost.com/) — no source compilation needed.

## Usage

```bash
docker pull ghcr.io/antonsatt/mattermost-arm64:latest
```

Or a specific version:

```bash
docker pull ghcr.io/antonsatt/mattermost-arm64:11.5.0
```

## How it works

A GitHub Actions workflow runs weekly (every Monday) and:

1. Checks the latest Mattermost release version
2. Skips if the image already exists in GHCR
3. Verifies the official ARM64 tarball is available
4. Builds and pushes to GitHub Container Registry

You can also trigger a build manually from the Actions tab.

## Building locally

```bash
docker build --build-arg MM_VERSION=11.5.0 -t mattermost-arm64:11.5.0 .
```

## Kubernetes

```yaml
image: ghcr.io/antonsatt/mattermost-arm64:11.5.0
```
