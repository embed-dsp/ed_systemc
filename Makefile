
# Copyright (c) 2018-2024 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


PACKAGE_NAME = systemc

PACKAGE_VERSION = 2.3.3

PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# ==============================================================================

# Determine system.
SYSTEM = unknown
ifeq ($(findstring Linux, $(shell uname -s)), Linux)
	SYSTEM = linux
endif
ifeq ($(findstring MINGW64, $(shell uname -s)), MINGW64)
	SYSTEM = mingw64
endif

# Determine machine.
MACHINE = $(shell uname -m)

# ==============================================================================

# Set number of simultaneous jobs (Default 8)
ifeq ($(J),)
	J = 8
endif

# System configuration.
CONFIGURE_FLAGS =

# NOTE: We use this C++ compiler flag to match the defaults used in Verilator.
CXXFLAGS = -std=gnu++17

# Configuration for linux system.
ifeq ($(SYSTEM),linux)
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++

	# Installation directory.
	INSTALL_DIR = /opt
endif

# Configuration for mingw64 system.
ifeq ($(SYSTEM),mingw64)
	# NOTE: This is required so SystemC-SCV can find the library directory.
	CONFIGURE_FLAGS += --with-arch-suffix=-mingw

	# Compiler.
	CC = /mingw64/bin/gcc
	CXX = /mingw64/bin/g++

	# Installation directory.
	INSTALL_DIR = /c/opt
endif

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

PREFIX = $(INSTALL_DIR)/$(PACKAGE_NAME)/$(ARCH)/$(PACKAGE)

# ==============================================================================

all:
	@echo "ARCH   = $(ARCH)"
	@echo "PREFIX = $(PREFIX)"
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
	@echo "[sudo] make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo "make distclean"
	@echo ""


.PHONY: download
download:
	-mkdir src
	cd src && wget -nc https://github.com/accellera-official/systemc/archive/refs/tags/$(PACKAGE_VERSION).tar.gz


.PHONY: prepare
prepare:
	-mkdir build
	cd build && tar zxf ../src/$(PACKAGE_VERSION).tar.gz


.PHONY: configure
configure:
	cd build/$(PACKAGE) && ./configure CC=$(CC) CXX=$(CXX) CXXFLAGS=$(CXXFLAGS) --prefix=$(PREFIX) --disable-shared --enable-silent-rules=no $(CONFIGURE_FLAGS)


.PHONY: compile
compile:
	cd build/$(PACKAGE) && make -j$(J)


.PHONY: install
install:
	-cd build/$(PACKAGE) && make install


.PHONY: clean
clean:
	# -rm -rf build
	cd build/$(PACKAGE) && make clean


.PHONY: distclean
distclean:
	cd build/$(PACKAGE) && make distclean
