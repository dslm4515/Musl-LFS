#  Musl-LFS Automated Build Script

As a means of convenience, these buld scripts will automate building the cross tools for x86 CPU's. Eventually there will be scripts to automate the tool-chain to build the final system.

## Usage

Scripts should be placed in a `scripts` directory under the source tree, i.e. `$MLFS/sources/scripts` but executed in `$MLFS/sources`.

To build the cross-tools:
```
cd $MLFS/sources
sh scripts/001-CT-BUILD 4
```
Syntax: `001-CT-BUILD <number of make jobs>`

## Configuration

The `000-autobuild.config` will be used to configure the build, such as setting target arch, and any often used code.`
