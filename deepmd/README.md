# deepmd 

A fast, interactive dual-pane Markdown explorer, live Glamour terminal renderer, and full-screen reader CLI with pure Go file traversal and `fzf` algorithm.

Pre-compiled as a self-contained static binary (`CGO_ENABLED=0`) with zero external runtime dependencies.

> 📦 **Origin Repository & Source Code**:  
> **[https://github.com/cggithub333/deepmd](https://github.com/cggithub333/deepmd)**

---

## 🚀 Key Highlights

- **Zero External Toolchain Dependencies**: Embeds pure Go file traversal (respecting `.gitignore`, max depth 5) and pure Go `fzf` algorithm. No external `glow`, `fd`, or `fzf` required.
- **Dual-Pane Real-Time Preview**: Live Glamour terminal rendering updates as you navigate through files on the left pane.
- **Mouse Divider Dragging**: Click and drag the vertical border between the file list and preview pane to slide the split left and right in real time.
- **Tmux-like Resizing**: Press `Alt+q` to toggle Resize Mode and use `←`/`→` or `h`/`l` to adjust pane widths (or directly use `Alt+←` and `Alt+→`).
- **In-Preview Grep**: Press `Ctrl+f` or `/` in preview to activate an in-preview search box at the top right of the preview pane with `Enter`/`n` match navigation.
- **Border-Free Shaded Code Blocks**: Markdown code blocks (` ```...``` `) are displayed inside a modern, borderless card with a solid dark gray background, language badge, and vibrant Chroma syntax highlighting with auto-wrapping for long lines.
- **Touchpad & Wheel Scrolling on Preview**: Mouse wheel and 2-finger trackpad smoothly scroll the Preview Box and Full-Screen Reader, while the File Explorer list remains strictly guarded against accidental inertia jumps.
- **Persistent Configuration**: Saved automatically to `~/.deepmd/config.json`.

---

## 💻 CLI Usage

```bash
# 1. Interactive Explorer (Dual-Pane TUI) in current directory
./deepmd

# 2. Explore markdown under a specific path
./deepmd ./docs --depth 3

# 3. Open a single file directly in full-screen reader
./deepmd README.md

# 4. Dump ANSI rendered markdown to stdout / pager
./deepmd -p README.md | less -R

# 5. List discovered markdown files
./deepmd -l
```

---

## ⌨️ Keybindings (Dual-Pane Explorer)

| Key / Gesture | Action |
| :--- | :--- |
| **Mouse Click on File Explorer** | Focus the file explorer pane; click any file item to directly select and preview |
| **Mouse Click on Preview Box** | Focus the preview pane for scrolling or searching |
| **Mouse Click & Drag Divider** | Press on the middle border between List and Preview to slide the split left <-> right |
| `Alt+q` / `Alt+Q` | Tmux-like leader chord to toggle **Leader Mode** (`←`/`→` to switch view, `Alt+←`/`Alt+→` to resize, `Enter`/`Esc` to exit) |
| `Leader` then `←` / `h` | Switch active focus to **File Explorer** |
| `Leader` then `→` / `l` | Switch active focus to **Preview Box** |
| `Leader` then `Alt+←` / `Alt+h` | Nudge divider left (shrinks file list, widens preview box) |
| `Leader` then `Alt+→` / `Alt+l` | Nudge divider right (widens file list, narrows preview box) |
| `Ctrl+p` / `Ctrl+y` | **Copy Full Absolute Filepath** to system clipboard (when focused on file explorer) |
| `Ctrl+a` | **Copy Full Content** to system clipboard (works for both file explorer and preview focus) |
| `Ctrl+f` / `/` | Open / close in-preview grep search pill on the top right of Preview box |
| `Tab` / `Enter` | **Traverse to next match** in preview grep (active match in magenta, other matches in gold/yellow) |
| `Shift+Tab` / `Shift+Enter` | **Traverse to previous match** in preview grep |
| `Backspace` | Edit search input (deletes characters without switching pane focus) |
| `n` / `N` | Next / previous match navigation (when preview is focused without active search input) |
| `↑` / `k` | Move cursor up in file list (or scroll up when Preview focused) |
| `↓` / `j` | Move cursor down in file list (or scroll down when Preview focused) |
| `d` / `u` | Scroll half-page down / up when Preview focused |
| `Enter` | Open selected file in full-screen reader (or exit if search query is `exit` / `quit` / `:q`) |
| `Ctrl+r` | Rescan directory and refresh ScoutCache (`~/.deepmd/<timestamp>/md-scout.md`) |
| `Esc` | Close preview search box or return focus to file list |
| `Ctrl+c` / `Ctrl+q` / `exit` | **Exit deepmd immediately** (`q` does not exit) |
