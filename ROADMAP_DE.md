# Pits n' Giggles — Roadmap zu v4.0

> Vom Telemetrie-HUD zur vollwertigen Race-Engineering-Plattform.

Pits n' Giggles v4.0 ist ein Major Release, das die Anwendung von einem Live-Telemetrie-Overlay in ein umfassendes Rennanalyse-Tool verwandelt — auf Augenhöhe mit und über das hinausgehend, was Tools wie Team Telemetry, F1Laps und Racelens bieten.

---

## Aktuell implementiert

- **Live Race Table** — Alle 20 Fahrer mit Positionen, Abständen, Reifen-Info und Pit-Strategie in Echtzeit
- **Engineer View** — Detailliertes Telemetrie-Grid mit Drill-Down pro Fahrer
- **HUD Overlay** — Desktop-Overlay (Windows/macOS) mit konfigurierbaren Panels
- **Stream Overlay** — Transparente Browser-Quelle für OBS/Twitch
- **SVG Track Maps** — Hochwertige SVG-Streckenumrisse aus Weltkoordinaten generiert, mit Sub-Pixel-genauer Fahrerpositionierung über Affintransformationen, interaktivem Zoom/Pan und Vollbild-Modus. Alle 27 F1 25 Strecken abgedeckt; F1 23 und F1 24 Strecken per Dev-Tool generiert
- **Reifenverschleiß-Vorhersage** — Regressionsbasierte Degradations-Extrapolation
- **Wetter-Graph** — Live-Wettervorhersage-Visualisierung
- **Kollisions- & Überholtracking** — Automatische Erkennung und Protokollierung
- **Multi-Session Support** — Mehrere Spiele gleichzeitig auf separaten Frontends
- **Post-Race Auto-Save** — Session-Daten automatisch als JSON gespeichert
- **F1 23 / F1 24 / F1 25 Support**

---

## Phase 1: Telemetrie-Plattform 📊

Die Features, die jeder ernsthafte Sim-Racer erwartet — richtig umgesetzt.

### Distanzbasierte Telemetrie-Aufzeichnung
Speed, Throttle, Brake, Gang und Drehzahl als Funktion der Streckendistanz aufzeichnen. Pro Runde, pro Fahrer, persistent über Sessions hinweg. Das Fundament für alles was folgt.

### Rundenvergleich (Lap Comparison)
Zwei beliebige Runden auswählen — Telemetrie-Traces übereinanderlegen mit synchronisierter Delta-Kurve. Schnellste Runde vs. konstante Runde. Qualifying vs. Rennpace. Sieh genau, wo du Zeit gewinnst und verlierst.

### 4-Ecken Reifentemperatur-Visualisierung
Oberflächen- und Innentemperaturen pro Rad als Live-Heatmap. Graining-Risiko erkennen, Setup-Probleme diagnostizieren (Über-/Unterdruck), und verstehen wie der Fahrstil die Reifenlebensdauer beeinflusst. Die Daten waren immer da — jetzt werden sie sichtbar.

### Daten-Export (CSV + JSON)
Session-Daten für Analyse in Excel, Python, R oder jedem beliebigen Tool exportieren. Spezifische Runden, Metriken und Fahrer auswählbar. Deine Daten, dein Weg.

---

## Phase 2: Race Intelligence 🧠

Features, die über das Anzeigen von Daten hinausgehen — hin zum Verstehen.

### Corner-by-Corner Performance-Analyse
Die Strecke in Kurven unterteilen. Zeitverlust pro Kurve berechnen. Klick auf eine Kurve in der Track Map — sieh die Telemetrie für diesen Abschnitt. Von "0,3s in Sektor 2 verloren" zu "0,2s in Kurve 7 verloren weil 3 Meter zu spät gebremst."

### Race Strategy Simulator
"Was wäre wenn ich in Runde 18 statt 22 pittte? Medium→Hard oder Hard→Medium? Was bei einem VSC?" Ein szenarienbasierter Strategierechner, angetrieben von echten Reifendegradationsdaten, Kraftstoffverbrauchsmodellen und Wettervorhersagen. Kein anderes Tool macht das wirklich gut — wir ändern das.

### Post-Race Dashboard
Eine eigene Ansicht, die nach Rennende erscheint. Positionsverlaufs-Diagramm, Stint-Vergleich, Pace-Trends, Degradationskurven, Überholmanöver-Timeline, Strafen-Log — alles was du für dein Renn-Debriefing brauchst.

### ERS-Deployment-Visualisierung
Energiespeicher-Level, Deployment-Modus, gewonnene und eingesetzte Energie als distanzbasierte Kurven. Sieh ob du zu früh deployst, genug unter dem Bremsen recuperierst, oder Energie an den falschen Stellen verschwendest.

### Fahrstil-Analyse (MotionEx)
Automatische Übersteuern/Untersteuern-Erkennung über Schräglaufwinkel. Blockier- und Durchdreh-Erkennung über Raddrehzahl-Differenzen. Federungsweg-Analyse für Fahrwerksqualität. Die Daten, die dein realer Performance-Ingenieur nutzen würde — automatisiert für Sim-Racer.

---

## Phase 3: Legacy Game Support 🕹️

Voller Anwendungssupport für ältere F1-Spiele.

### F1 2019 — F1 2022 Telemetrie-Parsing
Minimal-Parser für Motion-, LapData- und Session-Pakete für F1 2019–2022. Header-Größenunterschiede (23B → 24B → 29B) und unterschiedliche Auto-Anzahlen (20 vs. 22) werden transparent gehandhabt. Die App erkennt die Spielversion automatisch aus dem UDP-Header und wählt den richtigen Parser.

### Track Maps für alle Spiele
Track Maps für ältere Spiele werden mit dem gleichen Dev-Tool (`generate_track_map.py`) generiert — eine Live-Runde pro Strecke aufzeichnen. Strecken, die nicht mehr im Kalender sind (Paul Ricard, Sotschi, Hockenheim, Hanoi, Portimão), werden unterstützt wenn sie in einem älteren Spiel gefahren werden.

### Stretch Goal: Volle Legacy-Telemetrie
Volle Telemetrie-Unterstützung (Reifenverschleiß, Strategie, Rundenzeiten, Race Table) für F1 2019–2022 — das komplette Pits n' Giggles Erlebnis für ältere Spiele.

---

## Phase 4: User Experience ✨

### Einheitliche Navigation
Eine App, nicht vier. Top-Level-Navigation: **LIVE → POST-RACE → TIME TRIAL → HISTORY → SETTINGS**. Nahtlose Übergänge während die Session fortschreitet.

### Design auf einen Blick
Farbbalken statt Prozentzahlen. Team-Farbakzente. Weniger Spalten als Default, volle Details auf Wunsch. Designt für den 1,5-Sekunden-Blick zwischen den Kurven.

### Tablet-Optimierung
48px Touch-Targets. Responsive Layouts. Große Schrift und farbcodierte Indikatoren. Weil jeder Sim-Racer ein Tablet neben dem Rig stehen hat.

### F1-Ästhetik
Dark Theme inspiriert von F1 TV und der offiziellen Live Timing App. Monospace-Schrift für Rundenzeiten. Subtile Gradienten. Team-Farben überall.

### Time Trial Dashboard
Eine eigene Ansicht für Pace-Arbeit. Personal-Best-Datenbank, Session-über-Session-Vergleich, integrierte Telemetrie-Traces und Rundenvergleich — alles an einem Ort.

### First-Time Experience
Eine mitgelieferte Demo-Session, damit neue Nutzer sofort eine funktionierende App sehen. Quick-Start-Guide. Keine leeren Bildschirme.

---

## Phase 5: Infrastruktur 🔧

- **Modernes Frontend-Tooling** — Vite Build-System, TypeScript, ES Modules
- **High-Performance Charting** — uPlot für 10.000+ Datenpunkt-Traces bei 60fps
- **Automatisierte Releases** — Tag → Build → GitHub Release mit Binaries
- **Docker Support** — Produktionsreifes Compose-Setup für Server-/Liga-Deployments
- **Dependency Security Scanning** — Automatische CVE-Erkennung in CI
- **Health Monitoring Endpoint** — Version, Uptime, verbundene Sessions

---

## Release-Kriterien für v4.0

- [ ] Distanzbasierte Telemetrie-Aufzeichnung + Rundenvergleich
- [ ] Mindestens zwei Intelligence-Features (Corner-by-Corner und/oder Strategy Simulator)
- [ ] Legacy Game Support für F1 2019–2022 (Minimal-Parser + Track Maps)
- [ ] Einheitliche Navigation + verbessertes visuelles Design
- [ ] Alle Tests grün, Live-getestet mit F1 25
- [ ] Automatisierte CI/CD-Pipeline mit Docker-Images

## Über v4.0 hinaus

- Cloud-Sync und Benutzerkonten
- Community-Benchmarks und Leaderboards
- Voice Coaching und Audio-Callouts
- Mobile Companion App
- Setup-Empfehlungen basierend auf Telemetrie-Analyse
- Historische Cross-Session Performance-Trends
