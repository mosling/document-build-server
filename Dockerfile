FROM asciidoctor/docker-asciidoctor:latest

ENV PANDOC_VERSION 2.16.2
ENV PANDOC_DOWNLOAD_URL https://github.com/jgm/pandoc/archive/$PANDOC_VERSION.tar.gz

RUN apk add --no-cache \
    py3-pip \
    cmake \
    ninja \
    gmp \
    libffi \
    gcc \
    linux-headers \
    python3-dev \
    musl-dev \
    libffi-dev \
# ADD Pandoc and build executable
&& mkdir -p /pandoc-build && cd /pandoc-build \
&& curl -fsSL "$PANDOC_DOWNLOAD_URL" -o pandoc.tar.gz \
&& tar -xzf pandoc.tar.gz && rm -f pandoc.tar.gz \
&& cd pandoc-$PANDOC_VERSION \
&& cabal update \
&& cabal install --only-dependencies \
&& cabal configure \
&& cabal build \
&& cabal install exe:pandoc lib:pandoc

ENV PATH $PATH:~/.cabal/bin




