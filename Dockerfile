# Container image that runs your code
FROM ghcr.io/loonwerks/inspecta-sireum-minimal-container:4.20260213.2425a28d

# Add a minimal CLoC -- this should be moved to the base container
RUN apt update && apt install -y --no-install-recommends cloc \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
