FROM base:latest

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends g++-7 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -qq update
RUN apt-get -qq upgrade

RUN apt-get install -y zlib1g-dev libbz2-dev mpich
RUN apt-get install -y python3-dev python3-pip python3-tk python3-lxml python3-six
RUN apt-get install -y libssl-dev #for OPpenSSl
RUN apt-get install -y libicu-dev # for ICU

ENV CC="/usr/bin/gcc-7" \
    CXX="/usr/bin/g++-7" \
    COVERAGE_COMMAND="/usr/bin/gcov-7" \
    COVERAGE_FLAGS="--coverage"
