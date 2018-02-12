help:
	@echo "usage:"
	@echo "make docker: generate docker devel images"
	@echo "make configure: run cmake using the devel image container"
	@echo "make build: execute the cmake target all using the devel image container"
	@echo "make test: execute the cmake target test using the devel image container"
	@echo "make install: execute the cmake target install using the devel image container, then create an install image with it"
	@echo "make test_install: configure a sample project against it using the install image container"
	@echo "make clean: execute the cmake target clean"
	@echo "make distclean: execute clean and also remove all docker images"
	@echo ""
	@echo "note: Currently test are done on alpine and ubuntu, you can add \"_<distro>\"" \
" at end of the previous targets to run only test on this distro (e.g make test_install_alpine)."
	@echo "note: All generated code will be located in the cache/ folder, use distclean to remove it"

# Need to add cmd_distro to PHONY otherwise target are ignored since they don't
# contain recipe (using FORCE don't work here)
.PHONY: help all
all: build

IMAGE := cmake_ortools
#UID := $(shell id -u)
#GID := $(shell id -g)
#DOCKER_DEVEL_CMD := docker run --rm -it -v ${PWD}:/project -w /project --user ${UID}:${GID}
DOCKER_DEVEL_CMD := docker run --rm -it -v ${PWD}:/project -w /project
DOCKER_INSTALL_CMD := docker run --rm -it -v ${PWD}/cmake/sample:/project -w /project

# $* stem
# $< first prerequist
# $@ target name

# DOCKER
.PHONY: docker docker_alpine docker_ubuntu
docker: docker_alpine docker_ubuntu
docker_alpine: cache/alpine/docker_devel.tar
docker_ubuntu: cache/ubuntu/docker_devel.tar
cache/%/docker_devel.tar: cmake/docker/%/Dockerfile cmake/docker/%/setup.sh
	mkdir -p cache/$*
	@docker image rm -f ${IMAGE}_$*:devel 2>/dev/null
	docker build --no-cache -t ${IMAGE}_$*:devel -f $< cmake/docker/$*
	docker save ${IMAGE}_$*:devel -o $@

# DOCKER BASH
.PHONY: bash_alpine bash_ubuntu
bash_alpine: cache/alpine/docker_devel.tar
	${DOCKER_DEVEL_CMD} ${IMAGE}_alpine:devel /bin/sh
bash_ubuntu: cache/ubuntu/docker_devel.tar
	${DOCKER_DEVEL_CMD} ${IMAGE}_ubuntu:devel /bin/bash

# CONFIGURE
.PHONY: configure configure_alpine configure_ubuntu
configure: configure_alpine configure_ubuntu
configure_alpine: cache/alpine/configure.log
configure_ubuntu: cache/ubuntu/configure.log
cache/%/configure.log: cache/%/docker_devel.tar \
	CMakeLists.txt */CMakeLists.txt \
	cmake/*.CMakeLists.txt cmake/*Config.cmake.in
	@docker load -i $<
	${DOCKER_DEVEL_CMD} ${IMAGE}_$*:devel /bin/sh -c \
		"cmake -H. -Bcache/$*"
	@date > $@

# BUILD
.PHONY: build build_alpine build_ubuntu
build: build_alpine build_ubuntu
build_alpine: cache/alpine/build.log
build_ubuntu: cache/ubuntu/build.log
cache/%/build.log: cache/%/configure.log Foo FooApp
	${DOCKER_DEVEL_CMD} ${IMAGE}_$*:devel /bin/sh -c \
		"cmake --build cache/$* --target all"
	@date > $@

# TEST
.PHONY: test test_alpine test_ubuntu
test: test_alpine test_ubuntu
test_alpine: cache/alpine/test.log
test_ubuntu: cache/ubuntu/test.log
cache/%/test.log: cache/%/build.log
	${DOCKER_DEVEL_CMD} ${IMAGE}_$*:devel /bin/sh -c \
		"cmake --build cache/$* --target test -- CTEST_OUTPUT_ON_FAILURE=1"
	@date > $@

# INSTALL
.PHONY: install install_alpine install_ubuntu
install: install_alpine install_ubuntu
install_alpine: cache/alpine/install.log
install_ubuntu: cache/ubuntu/install.log
cache/%/install.log: cmake/docker/%/InstallDockerfile cache/%/build.log
	${DOCKER_DEVEL_CMD} ${IMAGE}_$*:devel /bin/sh -c \
		"cmake --build cache/$* --target install -- DESTDIR=install"
	@docker image rm -f ${IMAGE}_$*:install 2>/dev/null
	docker build --no-cache -t ${IMAGE}_$*:install -f $< .
	docker save ${IMAGE}_$*:install -o cache/$*/docker_install.tar
	@date > $@

# DOCKER BASH INSTALL
.PHONY: bash_install_alpine bash_install_ubuntu
bash_install_alpine: cache/alpine/install.log
	@docker load -i cache/alpine/docker_install.tar
	${DOCKER_INSTALL_CMD} ${IMAGE}_alpine:install /bin/sh
bash_install_ubuntu: cache/ubuntu/install.log
	@docker load -i cache/ubuntu/docker_install.tar
	${DOCKER_INSTALL_CMD} ${IMAGE}_ubuntu:install /bin/bash

# TEST INSTALL of ProjectConfigs.cmake
.PHONY: test_install test_install_alpine bash_isntall_ubuntu
test_install: test_install_alpine test_install_ubuntu
test_install_alpine: cache/alpine/test_install.log
test_install_ubuntu: cache/ubuntu/test_install.log
cache/%/test_install.log: cache/%/install.log cmake/sample
	@docker load -i cache/$*/docker_install.tar
	${DOCKER_INSTALL_CMD} ${IMAGE}_$*:install /bin/sh -c \
		"cmake -H. -B/cache; \
		cmake --build /cache; \
		cmake --build /cache --target test; \
		cmake --build /cache --target install"
	@date > $@

# CLEAN
.PHONY: clean clean_alpine clean_ubuntu
clean: clean_alpine clean_ubuntu
clean_alpine: clean-alpine
clean_ubuntu: clean-ubuntu
clean-%:: cache/%/docker_devel.tar
	@docker load -i $<
	${DOCKER_DEVEL_CMD} ${IMAGE}_$*:devel /bin/sh -c \
		"cmake --build cache/$* --target clean"
	${DOCKER_DEVEL_CMD} ${IMAGE}_$*:devel /bin/sh -c \
		"rm -rf cache/$*/install"
	@rm -f cache/$*/test.log
	@rm -f cache/$*/build.log
	@rm -f cache/$*/configure.log
	@rm -f cache/$*/install.log
	@rm -f cache/$*/test_install.log

# DISTCLEAN
.PHONY: distclean distclean_alpine distclean_ubuntu
distclean: distclean_alpine distclean_ubuntu
	docker image prune -f
	rmdir cache
distclean_alpine: distclean-alpine
distclean_ubuntu: distclean-ubuntu
distclean-%::
	${DOCKER_DEVEL_CMD} ${IMAGE}_$*:devel /bin/sh -c \
		"rm -rf cache/$*"
	docker image rm -f ${IMAGE}_$*:devel 2>/dev/null
	docker image rm -f ${IMAGE}_$*:install 2>/dev/null
