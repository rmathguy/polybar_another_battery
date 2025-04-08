# About

Simple battery charge level watcher with notifications (libnotify)

# Requirements

- (Build) go1.17
- (Build) libnotify-dev, pkg-config
- (Run) Font for battery indicator - 3270Medium NF
- (Run) libnotify
- (Run) UPower (`-time-to` flag)

# Build manually

```
make build
```

# Usage

Run with key `-h` for get actual help
```
$ ./polybar-ab -h
Usage of ./polybar-ab:
  -debug
    	Enable debug output to stdout
  -font int
    	Set font numbler for polybar output (default 1)
  -all
        Print information for bulk batteries.
  -once
    	Check state and print once
  -polybar
    	Print battery level in polybar format
  -simple
    	Print battery level to stdout every check
  -thr int
    	Set threshould battery level for notifications (default 10)
  -time-to
    	Print "time to full" or "time to empty"
  -version
    	Print version info and exit

```

## Polybar

Built in [polybar](https://github.com/jaagr/polybar) support.
Add flag `-polybar` for get stdout output in polybar format:
![Charging](/screenshots/charging.gif?raw=true "Charging")

### Polybar module example
```
See polybar-part.ini
```

### TODO

- [ ] Update the -h info in the file to reflect -all changes.
- [ ] Update the polybar-battery-switcher.sh to allow for swapping between
    multi and single battery configurations.

- [ ] Fix the issue of duplicate *annoying* notifications of low battery.
