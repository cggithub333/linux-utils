# redis ⚡

A modern, high-performance, single-binary Redis CLI tool supporting Docker/Kubernetes-style context management, non-blocking `SCAN` iteration, syntax-highlighted value inspection, bounded collection preview, and dual Human/AI Agent developer experience.

Pre-compiled as a self-contained static binary (`CGO_ENABLED=0`) with zero external runtime dependencies.

> 📦 **Origin Repository & Source Code**:  
> **[https://github.com/cggithub333/redis-cli-tool](https://github.com/cggithub333/redis-cli-tool)**

---

## 🚀 Key Highlights

- **Docker/Kubernetes-style Context Management**: Seamlessly switch between local Docker Redis engines and cloud instances (`redis context ls/use/create/rename/delete/export/import`).
- **Cloud URI Support**: Directly connect with `redis://` or `rediss://` connection strings (Upstash, Layerbase, AWS ElastiCache, Redis Official) with automatic TLS 1.2+ configuration.
- **Supplier Auto-Detection**: Contexts automatically identify and display hosting providers (`Layerbase`, `Redis Official`, `Local container`, `Upstash`, `AWS ElastiCache`, etc.).
- **Accurate Warm-Ping Latency**: Calibrates connection pooling to report true Redis query response time (~300ms across WAN) rather than one-off cold TCP/TLS handshake overhead.
- **Syntax-Highlighted Output**: TTY terminal output renders colorful JSON with keys (cyan), strings (green), numbers (yellow), and booleans (pink). Cleanly strips ANSI codes when piped to `jq` or files.
- **Safety First (Zero `KEYS *`)**: Uses non-blocking pipelined `SCAN` (batch 50) and chunked `UNLINK` (500 keys per batch). Pattern deletion requires explicit `--force` in non-interactive environments.
- **AI Agent DX**: Supports `--json --compact` for token-efficient single-line outputs (<500B), `--fields` projection, and semantic exit codes (0 to 5).
- **Interactive TUI Key Explorer**: Full-screen split-pane TUI powered by Bubble Tea (`redis explore`).

---

## 💻 CLI Usage

```bash
# 1. Multi-Context Management
./redis context ls                             # List contexts with health, provider, and latency
./redis context create local --host 127.0.0.1 --port 6379  # Local Docker context
./redis context create cloud --uri "rediss://default:pass@host:6379/0" # Cloud context
./redis context use cloud                      # Switch active context
./redis context rename cloud prod-cluster      # Rename context profile
./redis context export                         # Export sanitized YAML config

# 2. Key Browsing & Scanning (Non-blocking)
./redis show --pattern "user:*" --limit 20     # Browse matching keys
./redis show --pattern "session:*" --json --compact --fields=key,type,ttl

# 3. Key Inspection & Value Preview
./redis inspect user:1001:profile              # Type, encoding, TTL, memory, decoded value
./redis get user:1001:profile                  # Get string value
./redis set cache:auth "token123" --ttl 300s   # Set key with TTL

# 4. Health Snapshot
./redis summary                                # Human terminal card
./redis summary --json --compact               # Agent-friendly compact JSON (<500B)

# 5. Safe Key Deletion (UNLINK)
./redis del cache:auth                         # Delete single key
./redis del "temp:*" --dry-run                 # Preview matched keys without deleting
./redis del "temp:*" --force                   # Delete matching pattern with UNLINK

# 6. Interactive TUI Key Explorer
./redis explore                                # Full-screen TUI (requires TTY)
```

---

## 🤖 AI Agent Skill

This utility includes an AI agent skill located in:
`skills/redis-cli/SKILL.md`

Agents can view this skill to learn parameter syntax, semantic exit codes, safety guardrails, and token-saving flags (`--compact --fields`).
