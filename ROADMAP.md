# Pits n' Giggles — Roadmap to v4.0

> From telemetry HUD to full race engineering platform.

Pits n' Giggles v4.0 is a major release that transforms the application from a live telemetry overlay into a comprehensive race analysis tool — competing with and exceeding what tools like Team Telemetry, F1Laps, and Racelens offer.

---

## Currently Implemented

- **Live Race Table** — All 20 drivers with positions, gaps, tyre info, pit strategy in real-time
- **Engineer View** — Detailed telemetry grid with per-driver drill-down
- **HUD Overlay** — Desktop overlay (Windows/macOS) with customizable panels
- **Stream Overlay** — Transparent browser source for OBS/Twitch
- **SVG Track Maps** — High-quality SVG track outlines generated from world coordinates, with sub-pixel driver positioning via affine transforms, interactive zoom/pan, and fullscreen mode. All 27 F1 25 circuits covered; F1 23 and F1 24 tracks generated via dev tool
- **Tyre Wear Prediction** — Regression-based tyre degradation extrapolation
- **Weather Graph** — Live weather forecast visualization
- **Collision & Overtake Tracking** — Automatic detection and logging
- **Multi-Session Support** — Multiple games feeding into separate frontends simultaneously
- **Post-Race Auto-Save** — Session data automatically saved as JSON
- **F1 23 / F1 24 / F1 25 Support**

---

## Phase 1: Telemetry Platform 📊

The features every serious sim racer expects — done right.

### Distance-Based Telemetry Recording
Record speed, throttle, brake, gear, and RPM as a function of track distance. Per lap, per driver, persistent across sessions. The foundation for everything that follows.

### Lap Comparison
Select any two laps — overlay their telemetry traces with a synchronized delta curve. Your fastest lap vs. your consistent lap. Qualifying vs. race pace. See exactly where you gain and lose time.

### 4-Corner Tyre Temperature Visualization
Surface and inner temperatures per wheel as a live heatmap. Spot graining risk, diagnose setup issues (over/underpressure), and understand how your driving style affects tyre life. The data has always been there — now it's visible.

### Data Export (CSV + JSON)
Export session data for analysis in Excel, Python, R, or any tool of your choice. Select specific laps, metrics, and drivers. Your data, your way.

---

## Phase 2: Race Intelligence 🧠

Features that go beyond displaying data — towards understanding it.

### Corner-by-Corner Performance Analysis
Divide the track into corners. Calculate time loss per corner. Click a corner on the track map — see the telemetry for that section. Move from "I lost 0.3s in Sector 2" to "I lost 0.2s in Turn 7 because I braked 3 meters too late."

### Race Strategy Simulator
"What if I pit on Lap 18 instead of 22? Medium→Hard or Hard→Medium? What if there's a VSC?" A scenario-based strategy calculator powered by real tyre degradation data, fuel consumption models, and weather forecasts. No other tool does this well — we aim to change that.

### Post-Race Dashboard
A dedicated view that appears after the race finishes. Position history chart, stint comparison, pace trends, degradation curves, overtake timeline, penalty log — everything you need to debrief your race.

### ERS Deployment Visualization
Energy store level, deployment mode, harvested and deployed energy as distance-based curves. See whether you deploy too early, harvest enough under braking, or waste energy in the wrong places.

### Driving Style Analysis (MotionEx)
Automatic oversteer/understeer detection via slip angles. Lock-up and wheelspin identification via wheel speed differentials. Suspension travel analysis for ride quality assessment. The data your real-world performance engineer would use — automated for sim racers.

---

## Phase 3: Legacy Game Support 🕹️

Full application support for older F1 games.

### F1 2019 — F1 2022 Telemetry Parsing
Minimal parser covering Motion, LapData, and Session packets for F1 2019–2022. Header-size differences (23B → 24B → 29B) and car-count changes (20 vs. 22) are handled transparently. The app detects the game version automatically from the UDP header and selects the correct parser.

### Track Maps for All Games
Track maps for older games are generated using the same dev tool (`generate_track_map.py`) — record one lap of live game data per circuit. Circuits no longer on the calendar (Paul Ricard, Sochi, Hockenheim, Hanoi, Portimão) are supported when driven in an older game.

### Stretch Goal: Full Legacy Telemetry
Full telemetry support (tyre wear, strategy, lap times, race table) for F1 2019–2022 — bringing the complete Pits n' Giggles experience to older games.

---

## Phase 4: User Experience ✨

### Unified Navigation
One app, not four. Top-level navigation: **LIVE → POST-RACE → TIME TRIAL → HISTORY → SETTINGS**. Seamless transitions as your session progresses.

### Glanceable Design
Color bars instead of percentages. Team color accents. Fewer columns by default, full detail on demand. Designed for the 1.5-second glance between corners.

### Tablet Optimization
48px touch targets. Responsive layouts. Large fonts and color-coded indicators. Because every sim racer has a tablet next to their rig.

### F1 Aesthetic
Dark theme inspired by F1 TV and the official Live Timing app. Monospace fonts for lap times. Subtle gradients. Team colors everywhere.

### Time Trial Dashboard
A dedicated view for pace work. Personal best database, session-over-session comparison, integrated telemetry traces, and lap comparison — all in one place.

### First-Time Experience
A bundled demo session so new users see a working app immediately. Quick-start guide. No empty screens.

---

## Phase 5: Infrastructure 🔧

- **Modern frontend tooling** — Vite build system, TypeScript, ES Modules
- **High-performance charting** — uPlot for 10,000+ data point traces at 60fps
- **Automated releases** — Tag → Build → GitHub Release with binaries
- **Docker support** — Production-ready compose setup for server/league deployments
- **Dependency security scanning** — Automated CVE detection in CI
- **Health monitoring endpoint** — Version, uptime, connected sessions

---

## Release Criteria for v4.0

- [ ] Distance-based telemetry recording + lap comparison
- [ ] At least two intelligence features (Corner-by-Corner and/or Strategy Simulator)
- [ ] Legacy game support for F1 2019–2022 (minimum parser + track maps)
- [ ] Unified navigation + improved visual design
- [ ] All tests passing, live-tested with F1 25
- [ ] Automated CI/CD pipeline with Docker images

## Beyond v4.0

- Cloud sync and user accounts
- Community benchmarks and leaderboards
- Voice coaching and audio callouts
- Mobile companion app
- Setup recommendations based on telemetry analysis
- Historical cross-session performance trends
