
Compile and Install of the SystemC and TLM Library
==================================================

This repository contains make file for easy compile and install of the SystemC and TLM Library.

Get tool and source code
========================

## ed_systemc
```bash
git clone https://github.com/embed-dsp/ed_systemc.git
```

## SystemC / TLM Source
```bash
# Enter the ed_systemc directory.
cd ed_systemc

# Edit the Makefile for selecting the SystemC / TLM source version.
vim Makefile
PACKAGE = systemc-2.3.2

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
# Install build products.
sudo make install
```

The build products are installed in the following locations:
```bash
opt
└── systemc
    └── systemc-2.3.2
        ├── docs            # Documentation.
        │   ├── ...
        │
        ├── include         # Include files.
        │   ├── systemc.h
        │   ├── tlm.h
        │       ...
        ├── lib-linux64     # 64-bit libraries for Linux
        │   ├── libsystemc.a
        │       ...
        ├── lib-linux       # 32-bit libraries for Linux
        │   ├── libsystemc.a
        │       ...
```

Notes
=====
