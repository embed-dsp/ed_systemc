
# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# Package.
PACKAGE_NAME = systemc
PACKAGE_VERSION = 2.3.2
PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# Build for 32-bit or 64-bit (Default)
ifeq ($(M),)
	M = 64
endif

# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif

# Kernel.
KERN = $(shell ./bin/get_kernel.sh)

# Machine.
MACH = $(shell ./bin/get_machine.sh $(M))

# Architecture.
ARCH = $(KERN)_$(MACH)

# Compiler.
CC = /usr/bin/gcc
CXX = /usr/bin/g++

# Installation directory.
PREFIX = /opt/systemc/$(ARCH)/$(PACKAGE)

# ...
CONFIGURE_FLAGS =

ifeq ($(M),64)
	CONFIGURE_FLAGS +=
else
	# FIXME: Linux: x86 (32-bit) application running on x86_64 (64-bit) kernel
	CONFIGURE_FLAGS += --host=i686-linux-gnu
endif

# MinGW specifics.
ifeq ($(KERN),mingw32)
	CC = /mingw/bin/gcc
	CXX = /mingw/bin/g++
	PREFIX = /c/opt/systemc/$(ARCH)/$(PACKAGE)
endif

# MinGW-W64 specifics.
ifeq ($(KERN),mingw64)
	CC = /mingw64/bin/gcc
	CXX = /mingw64/bin/g++
	PREFIX = /c/opt/systemc/$(ARCH)/$(PACKAGE)
endif

# Cygwin specifics.
ifeq ($(KERN),cygwin)
	PREFIX = /cygdrive/c/opt/systemc/$(ARCH)/$(PACKAGE)
endif

# EXEC_PREFIX = $(PREFIX)/$(ARCH)


all:
	@echo ""
	@echo "## Get Source Code"
	@echo "make download"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure [M=...]"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "sudo make install [M=...]"
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
	cd build/$(PACKAGE) && ./configure CC=$(CC) CXX=$(CXX) --prefix=$(PREFIX) --disable-shared --enable-silent-rules=no $(CONFIGURE_FLAGS)


.PHONY: compile
compile:
	cd build/$(PACKAGE) && make -j$(J)


.PHONY: install
install:
	-cd build/$(PACKAGE) && make install


.PHONY: clean
clean:
	-rm -rf build
