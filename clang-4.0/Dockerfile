FROM base:latest

# install iwyu without pulling the python dependency
RUN apt-get -qq update \
    && mkdir /tmp/iwyu \
    && chown _apt /tmp/iwyu \
    && cd /tmp/iwyu \
    && apt-get -qq download iwyu \
    && dpkg -x iwyu_*.deb . \
    && cp usr/bin/include-what-you-use /usr/local/bin \
    && cd / \
    && rm -rf /tmp/iwyu \
    && rm -rf /var/lib/apt/lists/*

RUN VERSION=4.0 \
    && apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends clang-${VERSION} \
    && mkdir /tmp/clang-tidy \
    && chown _apt /tmp/clang-tidy \
    && cd /tmp/clang-tidy \
    && apt-get -qq download clang-tidy-${VERSION} \
    && dpkg -x clang-tidy-${VERSION}_*.deb . \
    && cp usr/bin/clang-tidy-${VERSION} /usr/bin \
    && cp usr/lib/llvm-${VERSION}/bin/clang-tidy /usr/lib/llvm-${VERSION}/bin/ \
    && cd / \
    && rm -rf /tmp/clang-tidy \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -qq update
RUN apt-get -qq upgrade

RUN apt-get install -y zlib1g-dev libbz2-dev mpich
RUN apt-get install -y python-dev python-pip python-tk python-lxml python-six
RUN apt-get install -y libssl-dev #for OPpenSSl
RUN apt-get install -y libicu-dev # for ICU
RUN apt-get install -y libiconv-dev # for iconv
RUN apt-get install -y libgmp-dev
RUN apt-get install -y libntl-dev
RUN apt-get install -y libgmp3-dev

ENV CC="/usr/lib/llvm-4.0/bin/clang" \
    CXX="/usr/lib/llvm-4.0/bin/clang++" \
    PATH=/usr/lib/llvm-4.0/bin:$PATH
