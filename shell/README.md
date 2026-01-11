# Shell Scripts

Bash utilities for system administration, monitoring, and automation.

## Projects

### usagestats/
2Wire router (2701HGV-W) bandwidth monitoring.
- `updatestats` - Polls router, outputs timestamp/TX/RX bytes. Fragile HTML scraping.
- `statslogger` - Daemon wrapper. **Issue:** 0.1s sleep = busy loop, wrong redirect syntax.
- `display` / `displayawk` - Live bandwidth display with AWK formatting.

### philips-hue/
- `hueapi-curl.sh` - Hue light control via REST API. **Issue:** Broken file existence test (`[ -z response.json ]`), hardcoded IP.

## Utilities

### Display/Desktop
| Script | Purpose | Notes |
|--------|---------|-------|
| `xrandr.sh` | Display scaling | Good debug logging, uses `bc` |
| `gkrandr` | Display presets (work/home) | **Bug:** Line 25 overwrites all previous settings |
| `rndbg.sh` | Random wallpaper | Handles spaces in filenames correctly |
| `lllock` | Screen lock wrapper | Trivial |

### System
| Script | Purpose | Notes |
|--------|---------|-------|
| `checktemp.sh` | CPU temp monitor with speech alerts | Complex sed, hardcoded core count |
| `checkbattery.sh` | Battery monitor with notifications | Uses `ibam`, multiple alert methods |
| `checkrygel.sh` | Rygel media server launcher | Good defensive checks |
| `clear.cache` | Drop kernel caches | **Bug:** Shebang `!#` instead of `#!` |
| `bluetoothery` | BT module reload | **Dangerous:** Unguarded rmmod/sudo |

### Networking
| Script | Purpose | Notes |
|--------|---------|-------|
| `googlesearch.sh` | CLI Google search | Opens first result, injection risk |
| `pingsummary` | Formatted ping stats | Clean, works |
| `getrouterstats` | Technicolor router scraper | Hardcoded IP, fragile HTML parsing |
| `grephttpheaders` | Filter HTTP headers | Simple, unquoted variable |
| `update-cloudns` | Dynamic DNS update | **Security:** Hardcoded API key in source |
| `update-cloudns-ip.glenn.io` | Dynamic DNS (from config) | Better: reads key from file |
| `update-kentwell.net-ip` | Conditional IP update | Good hostname check |
| `setupsshtunnel.sh` | Persistent SSH tunnel | ps grep could match itself |

### Synergy
| Script | Purpose | Notes |
|--------|---------|-------|
| `synergyclient` | Kill/start synergyc | `killall` without `-w` is dangerous |
| `synergyserver` | Kill/start synergys | Same issue |

### Files/Backup
| Script | Purpose | Notes |
|--------|---------|-------|
| `backup.sh` | Full backup system with remote sync | **Bugs:** Wrong tar arg order, inverted isin() logic, DB password in /root/.p |
| `yiideploy` | Yii app packager | Works, uses backticks |
| `lsbymdate` | List files by mtime | Good find/sort usage |
| `randompic` | Random image from dir | MIME validation, uses `shuf` |

### Misc
| Script | Purpose | Notes |
|--------|---------|-------|
| `makessl` | Self-signed cert generator | No input validation |
| `kindlemount` | MTP Kindle mount | Trivial |
| `meld` | Diff tool wrapper | Dead code after exit |
| `sleep-dbus` | Lock and suspend | Works |
| `secondstonow` | Date diff calculator | GNU-only (`date --date`) |
| `wordpress-getlatest` | Download WP tarball | One-liner, no validation |
| `update-etc-git` | Commit /etc changes | No error handling |

### Examples/Tests
| Script | Purpose | Notes |
|--------|---------|-------|
| `args.sh` | Argument handling demo | Incomplete `[ -v ]` test |
| `array.sh` | Array syntax demo | Wrong shebang (sh vs bash) |
| `iftest.sh` | Conditionals demo | **Bug:** Missing brackets in comparison |
| `shellargs` | Print arguments | Uses `$*` instead of `"$@"` |
| `exists` | File test demo | Hardcoded paths |

### Library
- `.bash_functions` - Note-taking functions with git integration. Well-structured, exports functions.

## Common Issues

- Unquoted variables throughout
- GNU-specific tools (date, stat) limit portability
- Missing error handling
- Hardcoded IPs/paths
- Some security concerns (hardcoded credentials, unguarded sudo)
