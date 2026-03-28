FROM ubuntu:noble

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG PUID=2000
ARG PGID=2000
ARG MM_VERSION=11.5.0
ARG MM_PACKAGE="https://releases.mattermost.com/${MM_VERSION}/mattermost-${MM_VERSION}-linux-arm64.tar.gz"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    ca-certificates curl media-types mailcap unrtf wv poppler-utils tidy tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid ${PGID} mattermost && \
    useradd --uid ${PUID} --gid ${PGID} --comment "" --home-dir /mattermost mattermost && \
    mkdir -p /mattermost/data /mattermost/plugins /mattermost/client/plugins && \
    curl -L "$MM_PACKAGE" | tar -xvz && \
    chown -R mattermost:mattermost /mattermost

ENV PATH="/mattermost/bin:${PATH}"
ENV MM_INSTALL_TYPE="docker"

USER mattermost
WORKDIR /mattermost

HEALTHCHECK --interval=30s --timeout=10s \
  CMD ["mmctl", "system", "status", "--local"]

CMD ["mattermost"]

EXPOSE 8065 8067 8074 8075

VOLUME ["/mattermost/data", "/mattermost/logs", "/mattermost/config", "/mattermost/plugins", "/mattermost/client/plugins"]
