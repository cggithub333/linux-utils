#!/usr/bin/env bash
#
# install.sh: Symlink linux-utils CLI tools into ~/.local/bin
#

set -euo pipefail

TARGET_DIR="${HOME}/.local/bin"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin"

echo "=========================================="
echo "      Linux-Utils CLI Suite Installer     "
echo "=========================================="
echo "Source directory: ${SOURCE_DIR}"
echo "Target directory: ${TARGET_DIR}"
echo ""

# Ensure target directory exists
mkdir -p "${TARGET_DIR}"

# Check dependencies
echo "==> Checking dependencies..."
MISSING_DEPS=0

for cmd in python3 fzf; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "  [✓] $cmd is installed"
    else
        echo "  [✗] $cmd is missing"
        MISSING_DEPS=$((MISSING_DEPS + 1))
    fi
done

# Check optional docker
if command -v docker >/dev/null 2>&1; then
    echo "  [✓] docker is installed (for dlog)"
else
    echo "  [!] docker is missing (required for dlog)"
fi

# Check python psutil
if python3 -c "import psutil" >/dev/null 2>&1; then
    echo "  [✓] python-psutil is available"
else
    echo "  [!] python-psutil is missing (required for pmem: sudo pacman -S python-psutil or pip install -r requirements.txt)"
fi

echo ""
echo "==> Symlinking binaries into ${TARGET_DIR}..."

for script in "${SOURCE_DIR}"/*; do
    if [ -f "$script" ]; then
        name="$(basename "$script")"
        chmod +x "$script"
        ln -sf "$script" "${TARGET_DIR}/${name}"
        echo "  [+] Linked ${name} -> ${TARGET_DIR}/${name}"
    fi
done

echo ""
echo "Installation complete! Ensure '${TARGET_DIR}' is in your PATH."
echo "You can now run: dlog --help, pmem --help"
