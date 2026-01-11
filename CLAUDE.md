# CLAUDE.md - AI Assistant Guidelines for This Repository

## Repository Overview

This is a personal collection of experimental code, proofs of concept, and utilities accumulated over time. The repository contains "bits of code" spanning multiple decades and programming languages, from high school Turbo Pascal projects to modern web experiments.

**Repository URL:** https://github.com/glennkentwell/code
**License:** Unlicense (Public Domain)

## Codebase Structure

```
/home/user/code/
├── pascal/       # Legacy Turbo Pascal experiments (1990s era)
├── shell/        # Bash shell scripts and system utilities
├── js/           # JavaScript utilities, bookmarklets, userscripts
├── php/          # PHP utilities and web scraping tools
├── python/       # Python scripts for system monitoring
├── c/            # C language utilities and tools
├── cpp/          # C++ experimental code
├── meteor/       # Meteor.js framework demo application
├── html/         # HTML/CSS experiments
├── scr/          # Additional shell scripts
├── shell-win/    # Windows shell scripts
├── README.md     # Repository overview
└── LICENSE       # Unlicense (public domain)
```

## Programming Languages

| Language | Location | Description |
|----------|----------|-------------|
| **JavaScript** | `/js/` | Web utilities, bookmarklets, userscripts, ADSL calculator |
| **PHP** | `/php/` | Web scraping (goutte), CSS minifier, profiler, utilities |
| **Python** | `/python/` | CPU sensors, audio recording, system monitoring |
| **Bash/Shell** | `/shell/`, `/scr/` | System utilities, router stats, Philips Hue control |
| **C** | `/c/` | jsmin, seeker utility, memory tools |
| **Pascal** | `/pascal/` | Historical Turbo Pascal programs (legacy) |
| **Meteor.js** | `/meteor/` | Leaderboard demo application |

## Key Projects

### JavaScript (`/js/`)
- **ADSL speed calculator/** - ADSL attenuation calculation tool
- **harvest/** - Web harvesting utilities
- **jokes/** - Chuck Norris joke API integrations
- **userscripts/** - Browser userscripts (Seek website cleaner)
- Standalone utilities: gebi.js, imagescroller.js, animate-box-shadow.js

### Shell Scripts (`/shell/`)
- **usagestats/** - 2Wire router usage statistics logging and display
- **philips-hue/** - Philips Hue light control via API (hueapi-curl.sh)
- Various utilities: xrandr.sh, pingsummary, grephttpheaders, googlesearch.sh

### PHP (`/php/`)
- **scraper/** - Web scraping with goutte.phar
- **pqp/** - PHP Quick Profiler (PhpQuickProfiler class)
- **cssmin/** - CSS minifier with test executable
- Utilities: csv2sql.php, caps.php, rent.php

### Python (`/python/`)
- **sensors.py** - CPU temperature monitoring with text-to-speech
- **statscrape.py** - SABnzbd download stats scraper
- **recordsound.py** - Audio recording utility

### C (`/c/`)
- **jsmin/** - JavaScript minifier (Douglas Crockford's implementation)
- **seeker/** - Search utility
- **atemyram/** - Memory consumption utility (munch.c)

**Note:** Much of the C code is third-party. See `/c/README.md`.

### Meteor (`/meteor/leaderboard/`)
- Complete Meteor 0.6.4 demo application
- Features: MongoDB collection, score tracking, player management

## Development Workflow

### No Build System
This repository has no formal build system, package manager configurations, or CI/CD pipelines. Projects are standalone and self-contained.

### Running Code
- **Shell scripts:** Execute directly with `bash script.sh` or `./script.sh`
- **Python:** Run with `python script.py` (may require dependencies like pyttsx)
- **PHP:** Run with `php script.php` (some require goutte.phar)
- **JavaScript:** Browser-based or Node.js depending on the script
- **C:** Pre-compiled binaries exist; recompile with `gcc source.c -o output`
- **Meteor:** Use `meteor run` from the project directory (requires Meteor)

### File Conventions
- Shell scripts typically have no extension or `.sh`
- No consistent naming convention across languages
- Some directories contain compiled binaries alongside source

## Important Notes for AI Assistants

### Code Attribution
- The C directory contains third-party code (see `/c/README.md` which states "Most of this code isn't mine!")
- Always verify code ownership before making modifications

### Legacy Code
- The `/pascal/` directory contains historical code from the Turbo Pascal era
- This code is preserved for historical/nostalgic purposes
- Avoid modifying unless specifically requested

### No Testing Framework
- No formal test suites exist
- Some ad-hoc test files exist (test.c, cssmin/test)
- When adding features, consider adding basic tests

### Dependencies
- PHP scraper uses goutte.phar (bundled)
- Python scripts may require: pyttsx (text-to-speech)
- Meteor project uses: autopublish, insecure, preserve-inputs, random packages

### Binary Files
- Pre-compiled C binaries exist in `/c/` subdirectories
- Python bytecode (.pyc) files are present
- Large binary data files exist in `/python/` (.xwd, .wav)

## Common Tasks

### Adding a New Script
1. Place in the appropriate language directory
2. For shell scripts, add shebang (`#!/bin/bash`)
3. Make executable if needed (`chmod +x script`)

### Modifying Existing Code
1. Understand the purpose by reading the file and any related README
2. Check if compiled binaries need to be rebuilt
3. Test changes manually before committing

### Git Workflow
- Main development happens on master branch
- Use descriptive commit messages
- Push changes to origin with `git push -u origin <branch>`

## Directory Quick Reference

| Path | What It Contains |
|------|------------------|
| `/js/ADSL speed calculator/` | ADSL line calculations with gradient data |
| `/shell/usagestats/` | Router usage monitoring scripts |
| `/shell/philips-hue/` | Smart home light control |
| `/php/scraper/` | Web scraping tools with goutte |
| `/php/pqp/` | PHP performance profiling |
| `/python/sensors.py` | CPU temperature monitoring |
| `/c/jsmin/` | JavaScript minification tool |
| `/meteor/leaderboard/` | Meteor.js demo app |

## Troubleshooting

### Shell Script Issues
- Ensure execute permissions: `chmod +x script.sh`
- Check shebang line is correct
- Verify dependencies are installed

### Python Scripts
- May require Python 2 or 3 (check syntax)
- Install dependencies with pip as needed

### PHP Scripts
- Ensure PHP CLI is installed
- Some scripts require the goutte.phar to be present

---

*Last updated: 2026-01-11*
