# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**ChessTime** — a zero-dependency PWA chess clock with time-odds support, battle chess mode, random openings, and ELO tracking. Built with vanilla JavaScript, HTML, and CSS in a single-file architecture.

## Development Commands

```bash
# Start local dev server (Python HTTP server on port 8080)
./start-server.bat
# or manually:
python -m http.server 8080

# Run merger algorithm tests (Node.js)
node test-merger-node.js

# Browser-based tests: open test-merger-auto.html in a browser
```

There is no build step, no bundler, no package manager. Files are served as-is.

## Architecture

### Core Application: `chess-clock.html` (~3,500 lines)

Single HTML file containing all markup, styles, and JavaScript. Organized as:

- **CSS** — Dark theme (#1e0c03 bg, #c89858 gold), Google Fonts (Bebas Neue, Barlow), responsive with `clamp()` and `safe-area-inset-*`
- **HTML** — Multiple screen `<div>`s toggled via the view system
- **JavaScript** — Single `<script>` block at end of file

**View/Screen System:** `switchView(fromEl, toEl, onSwitch)` manages cross-fade transitions between screens: intro → home → time select → player assign → game clock → game over.

**Game Loop:** `tick(ts)` runs via `requestAnimationFrame` at 60 FPS, updating active clock countdown.

**Game Modes:**
- Standard clock (configurable presets or custom time)
- Battle Chess (special abilities: Splash Damage, Ghost Move)
- Random Openings (carousel with chess opening database)

**Data Persistence:** LocalStorage with JSON for players, head-to-head records, and ELO ratings. Key functions: `getPlayers()`/`savePlayers()`, `getRecords()`/`saveRecords()`, `getElo()`/`saveElo()`.

**Browser APIs:** WakeLock (`startNoSleep()`), Service Worker, Canvas (icon gen), requestAnimationFrame.

### PWA Layer

- `manifest.json` — app name "ChessTime", standalone display, dark theme
- `sw.js` — cache-first strategy, cache name `chess-clock-v1`, offline fallback to chess-clock.html

### Other Tools

- `gen-icons.html` — Canvas-based PNG icon generator for PWA assets

## Conventions

- **Constants:** UPPERCASE (`PRESETS`, `TIMEOUT_MSGS`, `OPENINGS`)
- **IDs:** semantic (`#home-screen`, `#pa-white-btns`, `#gameover-content`)
- **Classes:** BEM-like (`.home-tile`, `.ts-grid`, `.battle-atk-btn`)
- **Section comments:** decorated with `══` markers
- **No external dependencies** — everything is vanilla JS/CSS/HTML
