FROM base:latest

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends g++-6 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -qq update
RUN apt-get -qq upgrade

RUN apt-get install -y zlib1g-dev libbz2-dev mpich
RUN apt-get install -y python-dev python-pip python-tk python-lxml python-six
RUN apt-get install -y libssl-dev #for OPpenSSl
RUN apt-get install -y libicu-dev # for ICU
RUN apt-get install -y libiconv-dev # for iconv

ENV CC="/usr/bin/gcc-6" \
    CXX="/usr/bin/g++-6" \
    COVERAGE_COMMAND="/usr/bin/gcov-6" \
    COVERAGE_FLAGS="--coverage"
