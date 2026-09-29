# linux-utils 🐧

A curated collection of standalone CLI utilities for Linux developer workstations, system diagnosis, container inspection, Redis database operations, and document navigation.

---

## 󰈙 Utilities Catalog

| Tool | Folder / Location | Type | Description | Origin / Source |
| :--- | :--- | :--- | :--- | :--- |
| **`deepmd`** | [`deepmd/`](./deepmd/) | Standalone Binary (Go) | Fast dual-pane Markdown explorer, live Glamour renderer, and full-screen reader CLI with pure Go `fd` and `fzf`. | [github.com/cggithub333/deepmd](https://github.com/cggithub333/deepmd) |
| **`redis`** | [`redis/`](./redis/) | Standalone Binary (Go) | Modern multi-context Redis CLI with Docker-style context switching, non-blocking `SCAN`, warm-ping latency, and Agent DX. | [github.com/cggithub333/redis-cli-tool](https://github.com/cggithub333/redis-cli-tool) |
| **`dlog`** | [`./dlog`](./dlog) | Script (Python) | Docker container log stream analyzer, colorized viewer, and multi-container follower. | Internal |
| **`dps`** | [`./dps`](./dps) | Script (Python) | Enhanced Docker container process status viewer with formatted ports, health, and uptime. | Internal |
| **`pmem`** | [`./pmem`](./pmem) | Script (Python) | Process memory breakdown and inspector for diagnosing RAM usage and leaks. | Internal |

---

##  deepmd — Markdown Explorer & Reader

`deepmd` is provided in [`deepmd/`](./deepmd/) as a pre-compiled, self-contained static binary (`CGO_ENABLED=0`) with zero external runtime dependencies.

> 📖 **Full Documentation & Keybindings**: See [`deepmd/README.md`](./deepmd/README.md)  
> 📦 **Source Repository**: [github.com/cggithub333/deepmd](https://github.com/cggithub333/deepmd)

### Key Features
- **Zero External Toolchain Dependencies**: Embeds pure Go file traversal and `fzf` fuzzy-finding algorithm.
- **Dual-Pane Real-Time Preview**: Live Glamour terminal rendering updates as you navigate through files on the left pane.
- **Mouse Divider Dragging**: Click and drag the vertical border between panes to slide the split in real time.
- **In-Preview Grep**: Press `Ctrl+f` or `/` in preview to activate an in-preview search box with match navigation.
- **Border-Free Shaded Code Blocks**: Modern, borderless cards with solid dark background and Chroma syntax highlighting.

```bash
# Launch interactive explorer in current directory
./deepmd/deepmd
```

---

## ⚡ redis — Modern Multi-Context Redis CLI

`redis` is provided in [`redis/`](./redis/) as a pre-compiled, self-contained static binary (`CGO_ENABLED=0`) supporting Docker/Kubernetes-style context management.

> 📖 **Full Documentation & Subcommands**: See [`redis/README.md`](./redis/README.md)  
> 🤖 **Agent Skill**: See [`redis/skills/redis-cli/SKILL.md`](./redis/skills/redis-cli/SKILL.md)  
> 📦 **Source Repository**: [github.com/cggithub333/redis-cli-tool](https://github.com/cggithub333/redis-cli-tool)

### Key Features
- **Multi-Context Management**: Switch seamlessly between local Docker Redis engines and cloud instances (`redis context ls/use/create/rename/delete`).
- **Cloud URI Support**: Native parsing for `redis://` and `rediss://` (Layerbase, Upstash, AWS, Redis Official).
- **Supplier Auto-Detection**: Displays hosting providers (`Layerbase`, `Redis Official`, `Local container`) in context tables.
- **Calibrated Latency**: Measures true warm Redis round-trip latency (~300ms) rather than cold TLS handshake overhead.
- **Syntax-Highlighted Output**: Colorful JSON for terminal TTY, clean raw JSON when piped to `jq`.
- **Safety First**: Non-blocking `SCAN` iteration, chunked `UNLINK`, and `--force` guardrails on pattern deletion.
- **Agent DX**: Single-line compact outputs (`--json --compact`), field projection (`--fields`), and semantic exit codes (0–5).

```bash
# List connection contexts
./redis/redis context ls

# Connect with cloud URI
./redis/redis context create cloud --uri "rediss://default:pass@host:6379/0"

# Compact health snapshot
./redis/redis summary --json --compact
```

---

## 🐳 Docker & System Utilities

### `dlog` — Docker Log Stream Viewer
Colorized log stream viewer for Docker containers with multi-container following.
```bash
./dlog <container-name>
```

### `dps` — Docker Container Process Status
Clean, tabular overview of running containers, mapped ports, and health status.
```bash
./dps
```

### `pmem` — Process Memory Breakdown
Inspect process RAM usage, memory allocations, and diagnose leaks.
```bash
./pmem
```

---

## 󰐥 Global Installation

To make all utilities available globally across your shell session:

```bash
# Symlink all tools to ~/.local/bin
mkdir -p ~/.local/bin
ln -sf $(pwd)/deepmd/deepmd ~/.local/bin/deepmd
ln -sf $(pwd)/redis/redis   ~/.local/bin/redis
ln -sf $(pwd)/dlog          ~/.local/bin/dlog
ln -sf $(pwd)/dps           ~/.local/bin/dps
ln -sf $(pwd)/pmem          ~/.local/bin/pmem
```
