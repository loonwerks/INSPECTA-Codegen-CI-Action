# Container image that runs your code
FROM ghcr.io/loonwerks/inspecta-sireum-minimal-container:v4.20260217.a747d3e6

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
