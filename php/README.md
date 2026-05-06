# PHP

Web utilities, scrapers, and profiling tools.

## Projects

### scraper/
Web scraping with Goutte library.
- `scrape.php` - Wiki authentication and page downloader. **Security:** Hardcoded credentials visible in source, SSL verification disabled.
- `goutte.phar` - Bundled Goutte library (1.4MB).

#### simplexml/
- `scrape.php` - Carsales.com.au scraper. **Incomplete:** Only loads URL, simplexml won't parse HTML.

### pqp/ (PHP Quick Profiler)
Third-party profiler from Particletree (~2009).
- `PhpQuickProfiler.php` - Metrics collection (time, memory, queries). Well-structured.
- `MySqlDatabase.php` - Query logger. **Deprecated:** Uses removed `mysql_*` functions.
- `Console.php` - Static logging to globals. Works but outdated pattern.
- `display.php` - HTML/JS output. **XSS risk:** Unescaped variables in JS.
- `index.php` - Demo page. Good documentation.

### cssmin/
- `cssmin-v3.0.1.php` - Third-party CSS minifier by Joe Scylla. **Production-ready**, well-documented, MIT licensed.
- `test` - Test executable.

## Standalone Files

| File | Purpose | Issues |
|------|---------|--------|
| `caps.php` | STDIN to title case | Works, minimal |
| `csv2sql.php` | CSV to INSERT statements | Good fgetcsv usage, hardcoded campaign ID |
| `callback.php` | map() function demo | Use array_map() instead |
| `debug.php` | FirePHP setup | **Outdated:** FirePHP is legacy |
| `garbogal.php` | Image gallery generator | **Security:** Path traversal, command injection via exec() |
| `homakov-open-redirect.php` | Redirect vulnerability demo | Educational security research |
| `isobject.php` | Unserialization test | **Critical:** unserialize() on arbitrary data = RCE risk |
| `join_array.php` | implode() demo | Trivial |
| `loop.php` | Wraparound sequence | Unclear purpose, off-by-one in rand() |
| `memory_limit.php` | ini_set() demo | Works |
| `parent.php` | Path separator util | Overcomplicated for `../` |
| `pathy.php` / `pathy2.php` | Path function demos | pathy2 shows traversal prevention |
| `rent.php` | Financial calculator | Personal utility, hardcoded values |
| `robotstxtfix.php` | WordPress robots.txt filter | Incomplete, unprofessional comment |

## Common Issues

- Deprecated `<?` short tags throughout
- `mysql_*` functions (removed in PHP 7.0)
- No PSR compliance
- Security vulnerabilities (unserialize, path traversal, XSS)
- Most code targets PHP 5.x era
