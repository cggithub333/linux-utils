#!/usr/bin/env bash
#
# install.sh: Symlink linux-utils CLI tools into ~/.local/bin
#

set -euo pipefail

TARGET_DIR="${TARGET_DIR:-${HOME}/.local/bin}"
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

# Detect current host platform
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "$ARCH" in
    x86_64|amd64) ARCH_TAG="x86_64" ;;
    aarch64|arm64) ARCH_TAG="arm64" ;;
    *) ARCH_TAG="$ARCH" ;;
esac

for item in "${SOURCE_DIR}"/*; do
    [ -L "$item" ] && continue
    name="$(basename "$item")"
    if [ -f "$item" ]; then
        chmod +x "$item"
        ln -sf "$item" "${TARGET_DIR}/${name}"
        echo "  [+] Linked ${name} -> ${TARGET_DIR}/${name}"
    elif [ -d "$item" ]; then
        # Multi-OS directory tool (e.g. bin/herdr-remote/)
        CANDIDATES=(
            "${item}/${OS}-${ARCH_TAG}/${name}"
            "${item}/${OS}-${ARCH}/${name}"
            "${item}/${OS}/${name}"
        )
        LINKED=0
        for candidate in "${CANDIDATES[@]}"; do
            if [ -f "$candidate" ]; then
                chmod +x "$candidate"
                ln -sf "$candidate" "${TARGET_DIR}/${name}"
                echo "  [+] Linked ${name} (${OS}-${ARCH_TAG}) -> ${TARGET_DIR}/${name}"
                LINKED=1
                break
            fi
        done
        if [ $LINKED -eq 0 ]; then
            echo "  [!] No prebuilt ${name} binary found for ${OS}-${ARCH_TAG} in ${item}"
        fi
    fi
done

# If herdr-remote was installed, provide convenient 'remote' alias
if [ -f "${TARGET_DIR}/herdr-remote" ]; then
    ln -sf herdr-remote "${TARGET_DIR}/remote"
    echo "  [+] Linked alias remote -> ${TARGET_DIR}/herdr-remote"
fi

echo ""
echo "Installation complete! Ensure '${TARGET_DIR}' is in your PATH."
echo "You can now run: dlog --help, pmem --help, herdr-remote --help (or remote --help)"
