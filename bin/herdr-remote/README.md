# herdr-remote multi-OS binaries

This directory contains prebuilt binaries for `herdr-remote` organized by operating system and CPU architecture:

- `linux-x86_64/herdr-remote`: Linux x86-64 ELF executable
- `darwin-arm64/`: macOS Apple Silicon (M1/M2/M3/M4)
- `darwin-x86_64/`: macOS Intel (x86_64)

The root `./install.sh` script automatically detects your current platform (`uname -s` and `uname -m`) and symlinks the appropriate binary into `~/.local/bin/herdr-remote`.

For source builds or compiling Darwin binaries, visit:
https://github.com/cggithub333/28-Plugins-Herdr-RemoteUse
