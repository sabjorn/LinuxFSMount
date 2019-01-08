FROM debian:stretch-slim

RUN runDeps='vim simg2img img2simg patch' \
    && set -x \
    && apt-get update \
    && apt-get install -y $runDeps --no-install-recommends  \
    && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
