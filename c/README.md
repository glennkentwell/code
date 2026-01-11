# C

Utilities and tools. **Most code here is third-party.**

## Projects

### jsmin/
Douglas Crockford's JavaScript minifier.
- `jsmin.c` - **High quality.** State machine parser, handles strings/regex/comments correctly. Global state limits thread safety. Stdin/stdout only.

### seeker/
Disk seek benchmark utility.
- `seeker.c` - Random read latency tester. Good error handling, proper 64-bit file ops. Linux-specific (linux/fs.h), uses deprecated BLKGETSIZE.

### atemyram/
Memory pressure testing.
- `munch.c` - Allocates memory blocks to consume RAM. **Issues:** No malloc() success check before memset(), atoi() doesn't handle errors. Intentional leak.

## Standalone Files

| File | Purpose | Issues |
|------|---------|--------|
| `return.c` | Exit code test | **Broken:** Malformed main() signature |
| `writeperf.c` | Write performance test | **Broken:** Syntax error (`#include <stdio .h>`), VLA misuse |
| `test.c` | Empty loop | Discards shift result, no-op |

## Binaries

Pre-compiled executables exist alongside source:
- `jsmin/jsmin`
- `seeker/seeker`
- `atemyram/munch`

Recompile: `gcc source.c -o output`

## Notes

- jsmin is the only production-quality code
- Linux-specific where system calls are used
- No Makefile; compile individually
