# linux-utils

> A curated suite of modern, interactive CLI utilities and terminal power-tools powered by Python 3 and `fzf`.

---

## 🚀 Overview

`linux-utils` is a centralized repository for lightweight, high-performance terminal utilities designed for modern Linux environments. Each tool features ANSI color rendering, interactive `fzf` integration, rich filtering, and pipeline-friendly execution.

---

## 🛠 Included Utilities

### 1. `dlog` — Smart Docker Log Streamer & Interactive FZF Explorer
Universal Docker log streaming tool with real-time log parsing, structured log formatting, and interactive container browsing.

- **Interactive Container Picker**: Run `dlog` without arguments to launch an interactive `fzf` fuzzy selector displaying all running and stopped containers.
- **Log Level Parsing**: Automatically parses standard text and structured JSON logs (Pino, Bunyan, Winston, Morgan) and color-codes log severity (`TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`).
- **Real-Time Follow & Tail**: Streams container logs with `-f` / `--follow` and customizable tail depth (`-n 200`).
- **Severity Filtering**: Filter logs on-the-fly using `-l` / `--level` (e.g., `dlog my-app -l error`).
- **Keyword & Regex Search**: Search within streamed logs via `-s` / `--search <regex>`.
- **JSON Formatting**: Pretty-print multiline structured JSON logs with `-m` / `--json`.

```bash
# Interactive container picker
dlog

# Stream logs of a specific container with error filtering
dlog api-gateway -l error

# Search for specific queries with trailing 200 lines
dlog redis-server -n 200 -s "AUTH"
```

---

### 2. `pmem` — Process Memory Explorer & RAM Profiler
Universal smart, fast, and visual process memory analyzer and system RAM profiler.

- **Sorted Memory Breakdown**: Lists running processes sorted descending by physical memory (RSS) by default, with intuitive colored usage meters and percentage gauges.
- **System Memory Overview**: Instant RAM and Swap summary banners with total, used, free, and cached statistics.
- **Application Grouping**: Consolidates multi-process applications (Chrome, Firefox, Electron, VS Code) using `-g` / `--group` into aggregated memory totals.
- **Interactive FZF Explorer**: Launch full-screen interactive navigation with `-i` / `--fzf` (or `-f`), complete with live preview breakdown and quick process termination controls.
- **Live Watch Dashboard**: Continuously update top memory consumers in real-time with `-w` / `--watch [interval]`.
- **PID Deep Inspection**: Inspect detailed virtual memory, threads, open files, and command lines with `--inspect <PID>`.
- **Machine-Readable JSON**: Export live process memory snapshots via `--json` for automation and jq filtering.

```bash
# Top 20 processes sorted by RAM usage
pmem -n 20

# Grouped memory consumption by application
pmem -g

# Interactive FZF browser with process management
pmem -i

# Live auto-refreshing watch dashboard (every 2 seconds)
pmem -w 2

# Inspect a specific process by PID
pmem --inspect 1234
```

> **Note on `pmap` vs `pmem`:** Standard Linux systems ship with `/usr/bin/pmap` from `procps` for mapping memory addresses of a single PID. `pmem` is designed as a full-spectrum system RAM explorer and interactive process profiler without clashing with the system binary.

---

## 📦 Installation & Setup

### Prerequisites
- **Python 3.8+**
- **fzf** (`sudo pacman -S fzf` / `sudo apt install fzf`)
- **python-psutil** (`sudo pacman -S python-psutil` or `pip install -r requirements.txt`)
- **Docker** (optional, required for `dlog`)

### Quick Install
Clone the repository and execute the installer script to symlink all utilities into `~/.local/bin/`:

```bash
git clone https://github.com/cggithub333/linux-utils.git ~/Projects/37-Linux-Utils
cd ~/Projects/37-Linux-Utils
./install.sh
```

Ensure `~/.local/bin` is in your `$PATH`:
```bash
export PATH="${HOME}/.local/bin:${PATH}"
```

---

## ➕ Adding New Utilities

1. Place your executable script or binary inside the `bin/` directory:
   ```bash
   chmod +x bin/my-tool
   ```
2. Re-run `./install.sh` to automatically link it to `~/.local/bin`.
3. Update the `README.md` documentation with command flags and examples.
4. Commit and push your changes:
   ```bash
   git add bin/my-tool README.md
   git commit -m "feat: add my-tool utility"
   git push
   ```

---

## 📄 License
MIT License. Created and maintained for personal Linux terminal workflows.
