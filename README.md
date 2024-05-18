
# Compile and Install of the SystemC and TLM Library

This repository contains a **make** file for easy compile and install of [SystemC / TLM](http://www.accellera.org/downloads/standards/systemc).

This **make** file can build the SystemC / TLM library on the following systems:
* Linux
* Windows
    * [MSYS2](https://www.msys2.org)/mingw64

# Get Source Code

## ed_systemc

```bash
git clone https://github.com/embed-dsp/ed_systemc.git
```

## SystemC / TLM

```bash
# Enter the ed_systemc directory.
cd ed_systemc
```

```bash
# Edit the Makefile for selecting the SystemC / TLM source version.
vim Makefile
PACKAGE_VERSION = 2.3.3
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
```

```bash
# Compile source code using 8 simultaneous jobs (Default).
make compile
```


# Install

The SystemC package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures and simple 
interoperability with the SCV package:

## Linux

```bash
# Install build products.
sudo make install
```

```bash
/opt/
└── systemc/
    └── linux_x86_64/           # 64-bit binaries and libraries for Linux
        └── systemc-2.3.3/
            ├── docs/           # Documentation.
            │   ├── ...
            │
            ├── include/        # Include directory.
            │   ├── systemc.h
            │   ├── tlm.h
            │       ...
            ├── lib-linux64/    # Library directory.
            │   ├── libsystemc.a
                    ...
```

## Windows: MSYS2/mingw64

```bash
# Install build products.
make install
```

```bash
/c/opt/
└── systemc/
    └── mingw64_x86_64/         # 64-bit binaries and libraries for Windows
        └── systemc-2.3.3/
            ├── docs/           # Documentation.
            │   ├── ...
            │
            ├── include/        # Include directory.
            │   ├── systemc.h
            │   ├── tlm.h
            │       ...
            ├── lib-mingw/      # Library directory.
            │   ├── libsystemc.a
                    ...
```
