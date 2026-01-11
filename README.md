# Bits of Code

Personal collection of experiments, proofs of concept, and utilities spanning multiple decades.

**License:** [Unlicense](LICENSE) (Public Domain)

## Structure

| Directory | Language | Status |
|-----------|----------|--------|
| [js/](js/) | JavaScript | Web utilities, bookmarklets, userscripts |
| [shell/](shell/) | Bash | System utilities, router stats, smart home |
| [php/](php/) | PHP | Web scrapers, profiler, minifier |
| [python/](python/) | Python | System monitoring, audio recording |
| [c/](c/) | C | Minifiers, disk benchmarks (mostly third-party) |
| [meteor/](meteor/) | Meteor.js | Leaderboard demo app |
| [pascal/](pascal/) | Turbo Pascal | High school experiments (1990s legacy) |
| [html/](html/) | HTML/CSS | Experiments |
| [scr/](scr/) | Shell | Additional scripts |
| [shell-win/](shell-win/) | Batch | Windows utilities |

## Quick Start

```bash
# Shell scripts
chmod +x shell/script.sh && ./shell/script.sh

# Python
python python/sensors.py

# PHP
php php/caps.php < input.txt

# C (compile)
gcc c/jsmin/jsmin.c -o jsmin
```

## Notes

- No build system or CI/CD
- No formal test suites
- Mix of personal code and third-party utilities
- Legacy code preserved for historical purposes
