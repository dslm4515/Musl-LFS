# Musl LFS Build SCripts

As a means of convenience, these buld scripts will automate building the cross tools and tool chain for x86 CPU's.

To Use:
Unpack each pacakge and run script inside:
```
tar xf binutils-2.32.tar.xz
cd binutils-2.32
sh ../scripts/cross/01-binutils 2
```

Each build script accepts 1 argument for number of make jobs. For example, to buld with 8 make jobs (`-j8`) then:
```
sh ../scripts/cross/01-binutils 8
```

Omiting the argument will run `make` without any specified number of jobs.


Directory

01-corss -- Build scripts to build `/cross-tools`
02-tools -- Build scripts to build `/tools`
