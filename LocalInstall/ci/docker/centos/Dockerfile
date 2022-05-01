# Create a virtual environment with all tools installed
# ref: https://quay.io/repository/centos/centos
FROM quay.io/centos/centos:stream AS env
# Install system build dependencies
ENV PATH=/usr/local/bin:$PATH
RUN dnf -y update \
&& dnf -y install git wget openssl-devel \
&& dnf -y groupinstall "Development Tools" \
&& dnf clean all \
&& rm -rf /var/cache/dnf

# Install CMake 3.23.1
RUN wget -q "https://cmake.org/files/v3.23/cmake-3.23.1-linux-x86_64.sh" \
&& chmod a+x cmake-3.23.1-linux-x86_64.sh \
&& ./cmake-3.23.1-linux-x86_64.sh --prefix=/usr/local/ --skip-license \
&& rm cmake-3.23.1-linux-x86_64.sh
CMD [ "/usr/bin/bash" ]

FROM env AS devel
WORKDIR /home/project
COPY . .

FROM devel AS build
RUN cmake -version
RUN cmake -H. -Bbuild
RUN cmake --build build --target all
RUN cmake --build build --target install

FROM build AS test
RUN cmake --build build --target test
