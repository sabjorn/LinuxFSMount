FROM debian:stretch-slim

RUN runDeps='vim' \
    && set -x \
    && apt-get update \
    && apt-get install -y $runDeps --no-install-recommends  \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["bash"]