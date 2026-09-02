# the-moment-before

**Status: ONE-OFF EXPERIMENT — fabrication & control files for a specific physical art installation ("The Moment Before" / "Weigt of Air"). Not a general-purpose tool or library; kept here as the build/source archive for that piece.**

## What this is

This repo holds the design and control-system files for a kinetic installation built around a
motorized bellows/air-pump mechanism. It's the working archive used to design, fabricate, and run
the physical piece — not reusable software.

Contents:

- `blender/` — 3D scene/assembly files for the installation (room + assembly).
- `models/` — OpenSCAD (`.scad`) source and exported `.stl` / sliced `.gcode.3mf` files for
  3D-printed parts (bellows caps, motor mounts, anti-vibration feet, guides, etc.).
- `lasercuts/` — LightBurn (`.lbrn2`) and RDWorks (`.rd`) laser-cutter files for the bellows and
  support structure. (These `.rd` files are why GitHub misidentifies the repo's primary language
  as "R" — there is no R code here.)
- `electronics/` — Fritzing schematics (`.fzz`) and Gerber/PCB fabrication files for a custom
  Arduino Nano motor-controller and relay board.
- `code/linear-actuator/` — PlatformIO/Arduino sketch (`src/main.cpp`) for an Arduino that drives
  a stepper motor (via a step/dir driver) through a bellows push/pull cycle, with homing, limit
  switches, randomized run/pause timing, and a safety fault state indicated by the onboard LED.
- `code/macmini-ssr/` — a second PlatformIO project (ATmega328/Nano) for solid-state-relay control.
- `code/relay-control/` — Python scripts (`pyhid_usb_relay`) and udev setup notes to switch a USB
  HID relay board (e.g. to power auxiliary equipment) from a Mac mini/Linux host.
- `patches/ambient.pd` — a Pure Data patch, presumably for the installation's ambient sound.
- `gallery contract/`, `texts/` — exhibition paperwork, artist bio, and installation description
  (Dutch gallery submission for "Jaar van de Jonge Kunst" / "Weigt of Air").
- `images/` — installation photos.

## How it was used

1. Parts were 3D-printed/laser-cut from `models/` and `lasercuts/`.
2. The Arduino Nano Every in `code/linear-actuator/src/main.cpp` was flashed via PlatformIO to
   drive the stepper motor between two limit switches with randomized run/pause cycles, per the
   motor-driver DIP-switch configuration documented below.
3. `code/relay-control/` scripts were used from a host machine to toggle auxiliary power via a
   USB relay.

## Motor driver configuration

```
SW1 SW2 SW3 SW4 SW5 SW6 SW7 SW8
ON  ON  ON  ON  OFF ON  OFF ON
```
No microstepping. Motor type 57. SW5 = OFF → CCW, SW6 = ON → PM.

Code targets an **Arduino Nano Every**.

## Onboard LED indications

- OFF — homing
- ON — running
- Slow blink — paused
- Fast blink — fault (requires manual reset)

## Dependencies

- PlatformIO + `AccelStepper` library (Arduino code)
- OpenSCAD (to regenerate STLs from `.scad` sources)
- LightBurn / RDWorks (laser files)
- Python 3 + `pyhid_usb_relay` (relay-control scripts)
- Pure Data (`.pd` patch)

![the moment before](./images/Mauricio_van%20der%20Maesen%20de%20Sombreff_The%20moment%20before_installation.jpg)
