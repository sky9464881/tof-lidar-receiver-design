
# Pulsed ToF LiDAR Receiver Front-End Design

## Overview
This project focuses on the design and validation of a receiver front-end for a Pulsed Time-of-Flight (ToF) LiDAR system.  
The main objective was to reduce walk error caused by variations in received signal amplitude while maintaining wide dynamic range under practical hardware and budget constraints.

## Project Goal
- Design a Pulsed ToF LiDAR receiver front-end that minimizes walk error
- Target dynamic range: 60 dB
- Target detection range: 5.4 m to 117.9 m
- Target resolution: 15 mm or less (100 ps walk)

## Final Outcome
- Reported dynamic range: 73 dB
- Reported detection range: 3.03 m to 134.8 m
- Reported walk error: 2.2 ns
- Reported range resolution: 33 cm

## System Architecture
The receiver was designed with the following signal chain:

`APD → OPA855 (TIA) → OPA695 (Post Amplifier) → TLV3604 (Comparator / Time Discriminator)`

## Key Work
- Derived system requirements based on bandwidth, SNR, dynamic range, and detection range
- Designed APD-based receiver front-end for current-to-voltage conversion
- Implemented TIA and post-amplifier stages for weak pulse amplification
- Built comparator stage with adjustable threshold for timing extraction
- Modeled APD behavior in PSpice based on datasheet parameters
- Designed and fabricated a 4-layer PCB considering high-speed analog layout constraints
- Performed oscilloscope-based validation using OD filters and waveform averaging

## Technical Highlights
### 1. Requirement-Driven Design
The receiver design started from system-level requirements such as rise time, bandwidth, SNR, and dynamic range rather than only schematic-level implementation.

### 2. High-Speed Analog Front-End Design
Special attention was given to:
- minimizing parasitic capacitance between APD and TIA
- bias stability
- output swing limits
- ringing reduction at the post-amplifier stage

### 3. Practical Hardware Validation
The design was not limited to simulation.  
The front-end was implemented on a real PCB and validated through:
- oscilloscope measurements
- OD filter-based attenuation tests
- CSV export and MATLAB-based waveform averaging

### 4. Tuning and Debugging
During validation, several practical issues were identified and improved:
- APD / laser alignment mismatch
- OPA855 stability issues
- RISO-related noise behavior
- ringing at the OPA695 output stage

## Results
The final implementation achieved a wider dynamic range and longer detectable distance than the initial target range.  
However, walk error performance did not meet the original resolution target, mainly due to ringing and threshold-setting limitations in the measured waveform.

## Limitations
- Walk error remained larger than the original target
- Ringing at the later analog stage limited threshold reduction
- Mechanical alignment issues affected repeatability
- Some simulation constraints and model inconsistencies reduced early-stage verification efficiency

## What I Learned
This project strengthened my understanding of how system requirements, analog front-end design, PCB layout, and measurement conditions interact in real hardware development.  
It also showed that signal integrity, impedance behavior, and practical tuning are critical in converting a theoretical design into a working measurement system.

## Tech Stack
- PSpice / OrCAD Capture
- Allegro PCB Designer
- MATLAB
- Oscilloscope
- Function Generator
- DC Power Supply

## Repository Structure
```text
.
├─ design/
├─ docs/
├─ results/
├─ simulation/
└─ README.md