FROM base:latest

RUN echo 'deb http://ftp.debian.org/debian experimental main' >> /etc/apt/sources.list \
    && apt-get -qq update \
    && apt-get -qq -t experimental install -y --no-install-recommends g++-8 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -qq update
RUN apt-get -qq upgrade

RUN apt-get install -y zlib1g-dev libbz2-dev mpich
RUN apt-get install -y python-dev python-pip python-tk python-lxml python-six
RUN apt-get install -y libssl-dev #for OPpenSSl
RUN apt-get install -y libicu-dev # for ICU
RUN apt-get install -y libiconv-dev # for iconvRUN apt-get install -y libicu-dev # for ICU
RUN apt-get install -y libgmp-dev
RUN apt-get install -y libntl-dev
RUN apt-get install -y libgmp3-dev

ENV CC="/usr/bin/gcc-9" \
    CXX="/usr/bin/g++-9" \
    COVERAGE_COMMAND="/usr/bin/gcov-9" \
    COVERAGE_FLAGS="--coverage"
