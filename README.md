
# Compile and Install of the SystemC and TLM Library

This repository contains a **make** file for easy compile and install of [SystemC / TLM](http://www.accellera.org/downloads/standards/systemc).

This **make** file can build the GTKWave tool on the following systems:
* Linux
* Windows
    * [MSYS2](https://www.msys2.org)/mingw64
    * [MSYS2](https://www.msys2.org)/mingw32
    * **FIXME**: [Cygwin](https://www.cygwin.com)

# Get Source Code

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
```

```bash
# Download SystemC source package into src/ directory.
make download
```


# Build

```bash
# Unpack source code into build/ directory.
make prepare
```

```bash
# Configure source code.
make configure

# Configure source code for 32-bit compile on a 64-bit system.
make configure M=32
```

```bash
# Compile source code using 4 simultaneous jobs (Default).
make compile

# Compile source code using 2 simultaneous jobs.
make compile J=2
```


# Install

```bash
# Install build products.
# FIXME: sudo
sudo make install

# Install 32-bit build products.
# FIXME: sudo
sudo make install M=32
```


The SystemC package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures and simple 
interoperability with the SCV package:

FIXME: linux, arm, ...
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

FIXME: windows 64-bit, mingw32, mingw64


# Tested System Configurations

System  | M=                | M=32  
--------|-------------------|-------------------
linux   | Fedora-28 64-bit  | Fedora-28 64-bit
mingw64 | Windows-10 64-bit |
mingw32 | Windows-10 64-bit |
cygwin  | **FIXME**         |

This has been testes with the following Linux distributions and compilers:
* `Fedora-27 (64-bit)`
    * `gcc-7.2.1`
    * `gcc-7.3.1`
