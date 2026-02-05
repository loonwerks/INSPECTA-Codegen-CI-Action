# Container image that runs your code
FROM ghcr.io/loonwerks/inspecta-ci-action-container:sha256-d76d6a1bab6682451e8d8ac0ffc5e4300f45d7c8b53b3408549d8fbada6c268d

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
