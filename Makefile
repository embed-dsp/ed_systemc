
# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


CC = /usr/bin/gcc
CXX = /usr/bin/g++

# Package.
PACKAGE_NAME = systemc
PACKAGE_VERSION = 2.3.2
PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# Architecture.
ARCH = $(shell ./bin/get_arch.sh)

# Installation.
PREFIX = /opt/systemc/$(ARCH)/$(PACKAGE)
# PREFIX = /opt/systemc/$(PACKAGE)
# EXEC_PREFIX = $(PREFIX)/$(ARCH)

# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif


all:
	@echo ""
	@echo "## Get Source Code"
	@echo "make download"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "sudo make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo ""


.PHONY: download
download:
	-mkdir src
	cd src && wget -nc http://www.accellera.org/images/downloads/standards/systemc/$(PACKAGE).tar.gz


.PHONY: prepare
prepare:
	-mkdir build
	cd build && tar zxf ../src/$(PACKAGE).tar.gz


.PHONY: configure
configure:
	cd build/$(PACKAGE) && ./configure CC=$(CC) CXX=$(CXX) --prefix=$(PREFIX) --disable-shared --enable-silent-rules=no


.PHONY: compile
compile:
	cd build/$(PACKAGE) && make -j$(J)


.PHONY: install
install:
	-cd build/$(PACKAGE) && make install


.PHONY: clean
clean:
	-rm -rf build
