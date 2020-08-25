# Create a virtual environment with all tools installed
# ref: https://hub.docker.com/_/debian
FROM debian:latest AS env
LABEL maintainer="mizux.dev@gmail.com"
# Install system build dependencies
ENV PATH=/usr/local/bin:$PATH
RUN apt-get update -qq \
&& apt-get install -yq git wget libssl-dev build-essential \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install CMake 3.18.1
RUN wget "https://cmake.org/files/v3.18/cmake-3.18.1-Linux-x86_64.sh" \
&& chmod a+x cmake-3.18.1-Linux-x86_64.sh \
&& ./cmake-3.18.1-Linux-x86_64.sh --prefix=/usr/local/ --skip-license \
&& rm cmake-3.18.1-Linux-x86_64.sh
CMD [ "/bin/sh" ]

FROM env AS devel
WORKDIR /home/project
COPY . .

FROM devel AS build
RUN cmake -version
RUN cmake -S. -Bbuild
RUN cmake --build build --target all
RUN cmake --build build --target install

FROM build AS test
RUN cmake --build build --target test
