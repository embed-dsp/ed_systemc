
Compile and Install of the SystemC and TLM Library
==================================================

This repository contains make file for easy compile and install of [SystemC / TLM](http://www.accellera.org/downloads/standards/systemc).

Get Source Code
===============

## ed_systemc
```bash
git clone https://github.com/embed-dsp/ed_systemc.git
```

## SystemC / TLM
```bash
# Enter the ed_systemc directory.
cd ed_systemc

# Edit the Makefile for selecting the SystemC / TLM source version.
vim Makefile
PACKAGE_VERSION = 2.3.2

# Download SystemC source package into src/ directory.
make download
```

Build
=====
```bash
# Unpack source code into build/ directory.
make prepare

# Configure source code for 64-bit compile (Default: M=64).
make configure
make configure M=64

# Configure source code for 32-bit compile.
make configure M=32

# Compile source code using 4 simultaneous jobs (Default: J=4).
make compile
make compile J=4
```

Install
=======
```bash
# Install 64-bit build products (Default: M=64).
sudo make install
sudo make install M=64

# Install 32-bit build products.
sudo make install M=32
```

The build products are installed in the following locations:

FIXME: Why this particular directory structure ...
```bash
opt/
└── systemc/
    ├── linux_x86_64/           # 64-bit binaries and libraries for Linux
    │   └── systemc-2.3.2/
    │       ├── docs/           # Documentation.
    │       │   ├── ...
    │       │
    │       ├── include/        # Include directory.
    │       │   ├── systemc.h
    │       │   ├── tlm.h
    │       │       ...
    │       ├── lib-linux64/    # Library directory.
    │       │   ├── libsystemc.a
    │               ...
    └── linux_x86/              # 32-bit binaries and libraries for Linux
        └── systemc-2.3.2/
            ...
```

Notes
=====

This has been testes with the following Linux distributions and compilers:
* `Fedora-27 (64-bit)` and `gcc-7.2.1`
