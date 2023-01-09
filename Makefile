
# Copyright (c) 2018-2023 embed-dsp, All Rights Reserved.
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
ifeq ($(findstring MINGW32, $(shell uname -s)), MINGW32)
	SYSTEM = mingw32
endif
ifeq ($(findstring MINGW64, $(shell uname -s)), MINGW64)
	SYSTEM = mingw64
endif
ifeq ($(findstring CYGWIN, $(shell uname -s)), CYGWIN)
	SYSTEM = cygwin
endif

# Determine machine.
MACHINE = $(shell uname -m)

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

# ==============================================================================

# Set number of simultaneous jobs (Default 8)
ifeq ($(J),)
	J = 8
endif

# System configuration.
CONFIGURE_FLAGS =

# Configuration for linux system.
ifeq ($(SYSTEM),linux)
	# Compile for 32-bit on a 64-bit machine.
	ifeq ("$(MACHINE):$(M)","x86_64:32")
		MACHINE = "x86"
		CONFIGURE_FLAGS += --host=i686-linux-gnu
	endif
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++
	# Installation directory.
	INSTALL_DIR = /opt
endif

# Configuration for mingw32 system.
ifeq ($(SYSTEM),mingw32)
	# NOTE: This is required so SystemC-SCV can find the library directory.
	CONFIGURE_FLAGS += --with-arch-suffix=-mingw
	# Compiler.
	CC = /mingw32/bin/gcc
	CXX = /mingw32/bin/g++
	# Installation directory.
	INSTALL_DIR = /c/opt
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

# Configuration for cygwin system.
ifeq ($(SYSTEM),cygwin)
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++
	# Installation directory.
	INSTALL_DIR = /cygdrive/c/opt
endif

PREFIX = $(INSTALL_DIR)/$(PACKAGE_NAME)/$(ARCH)/$(PACKAGE)
# PREFIX = $(INSTALL_DIR)/$(PACKAGE_NAME)/$(PACKAGE)
# EXEC_PREFIX = $(PREFIX)/$(ARCH)

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
	@echo "make configure [M=32]"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "[sudo] make install [M=32]"
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
	cd build/$(PACKAGE) && ./configure CC=$(CC) CXX=$(CXX) --prefix=$(PREFIX) --disable-shared --enable-silent-rules=no $(CONFIGURE_FLAGS)


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
