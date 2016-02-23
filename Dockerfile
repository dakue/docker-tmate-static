FROM debian:jessie

ENV TMATE_VERSION="2.2.0"

RUN set -x && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl ca-certificates build-essential cmake libssl-dev autoconf automake pkg-config libtool libevent-dev libncurses-dev zlib1g-dev && \
  mkdir -p /tmate && \
  # curl -sSL "https://github.com/tmate-io/tmate/archive/${TMATE_VERSION}.tar.gz" \
  curl -sSL "https://github.com/tmate-io/tmate/archive/master.tar.gz" \
  | tar xz --strip-components=1 -C /tmate && \
  # curl -sSL "https://raw.githubusercontent.com/tmate-io/tmate/master/Makefile.static-build" -o /tmate/Makefile.static-build && \
  sed -i 's|wget -O|curl -sSL -o|g' /tmate/Makefile.static-build && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["build-tmate"]
