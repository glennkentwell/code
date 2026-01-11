# JavaScript

Web utilities, bookmarklets, and browser userscripts.

## Projects

### ADSL speed calculator/
ADSL attenuation lookup tables mapping dB to expected speeds.
- `attenuation.js` - Main lookup table. Clean data structure.
- `lookups.js` - Combined module exports. Good modularization.
- `gradient-*.js` - Partial gradient data. Incomplete.
- `one.js` - Empty stub.

### harvest/
- `ff.js` - Image URL harvester with auto-scroll. **Issues:** Infinite setInterval loops, sparse array bug from `delete`, hardcoded localhost endpoint.
- `ffimg.js` - 528KB data dump of Tumblr image URLs.

### jokes/
Chuck Norris joke API integrations.
- `joke.js` - Multi-provider joke fetcher. **Broken:** Syntax errors prevent execution.
- `spikes/*.js` - JSON experiments, mostly educational.
- `randomjoke.com-topics.js` - **Broken:** `appendNode` typo, doesn't execute.

### userscripts/
- `seek-cleaner-upper.js` - Greasemonkey script to clean Seek.com.au listings. Works, jQuery-dependent.

## Standalone Files

| File | Purpose | Issues |
|------|---------|--------|
| `gebi.js` | `getElementById` wrapper with fallback | Creates fake elements on failure—masks bugs |
| `imagescroller.js` | Scroll to next image | No jQuery guard, auto-executes |
| `animate-box-shadow.js` | jQuery shadow animation | HTTP script load, external dependency |
| `string.rotate.js` | String rotation method | **Anti-pattern:** Modifies native prototype |
| `window.title.flasher.js` | Flash title on blur | Good IIFE pattern, no stop mechanism |
| `leadingzero.js` | Zero-pad numbers | **Bug:** Missing return for normal case |
| `mkbkmklet.js` | Bookmarklet encoder | Minimal, works |
| `noderepl.js` | Node REPL launcher | Trivial, works |
| `scope.js` | Closure pattern demo | Educational |
| `burrow.js` | Object traverser | **Bug:** Wrong `this` context, no circular ref protection |
| `apk_dl.js` | APK downloader redirect | **Bug:** Undefined variable access |
| `imgurlsaner.js` | WordPress image scraper | **Critical:** Async in while loop, XSS via innerHTML |
| `navigator.geolocation.js` | Geolocation check | **Bug:** `console.log2000` typo |
| `funnie.st.js` | Image URL sanitizer | **Bug:** Invalid createElement syntax |
| `thumbsdown-bookmarklet.js` | Emoji inserter | **Bug:** Missing closing brace |
| `image-scroll-fixer.js` | Snap to image scroll | Overcomplicated, scroll performance issue |

## Common Issues

- Heavy jQuery dependency without fallbacks
- Multiple XSS vulnerabilities (innerHTML from fetched content)
- Several incomplete/broken scripts
- No ES6+ modernization
- No error handling
