# Python

System monitoring and audio utilities.

## Files

| File | Purpose | Issues |
|------|---------|--------|
| `sensors.py` | CPU temp monitor with TTS | **Bugs:** Undefined `x`, shadows `temp` class, Python 2 syntax |
| `recordsound.py` | 5-second audio recorder | Sample rate inconsistency (44100 vs 48000), Python 2 |
| `statscrape.py` | SABnzbd stats scraper | **Broken:** Syntax error line 19, deprecated curl module |
| `watchdoghandler.py` | File system watcher | **Incomplete:** observer.start() never called |
| `inspectory.py` | Object introspection | Unused getdoc() result, Python 2 |
| `dirx.py` | dir() with filter | Use `in` operator instead of `.find()` |
| `args.py` | Argument display | Dead code (unused `longest` var), Python 2 |
| `ttysz.py` | Terminal size via ioctl | Works, imports inside function |

## Data Files

- `*.wav` - Audio recordings
- `*.xwd` - X11 window dumps
- `*.png` - Screenshots
- `*.pyc` - Compiled bytecode

## Dependencies

- `pyttsx` - Text-to-speech (sensors.py)
- `pyaudio` - Audio recording (recordsound.py)
- `watchdog` - Filesystem monitoring (watchdoghandler.py)

## Common Issues

- Python 2 syntax throughout (print statements)
- Missing error handling
- Several scripts have bugs preventing execution
- No type hints or docstrings
