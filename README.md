
# Pulsed ToF LiDAR Receiver Front-End Design


<img width="1212" height="438" alt="image" src="https://github.com/user-attachments/assets/ea7ebd1e-37db-4588-ab70-8dd0fc9bc7e8" />

>For more details, please see docs/presentation/캡스톤_설계_최종_보고서.pdf.

>더 자세한 내용을 확인하고 싶으시면 docs/presentation/캡스톤_설계_최종_보고서.pdf를 확인하시면 됩니다.

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

<img width="619" height="457" alt="image" src="https://github.com/user-attachments/assets/5c96d696-8fab-4ddb-9cee-db1239fdf047" />

The receiver design started from system-level requirements such as rise time, bandwidth, SNR, and dynamic range rather than only schematic-level implementation.

### 2. High-Speed Analog Front-End Design

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/60044875-55da-41ad-8a6d-c11272e79e83" /><img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/4e9c9022-57b2-4a2d-8ae6-060af7fb7ba0" />


Special attention was given to:
- minimizing parasitic capacitance between APD and TIA
- bias stability
- output swing limits
- ringing reduction at the post-amplifier stage

### 3. Practical Hardware Validation

<img width="916" height="528" alt="image" src="https://github.com/user-attachments/assets/868d0997-1a4c-4631-a758-67a4a81ea094" />


The design was not limited to simulation.  
The front-end was implemented on a real PCB and validated through:
- oscilloscope measurements
- OD filter-based attenuation tests
- CSV export and MATLAB-based waveform averaging

### 4. Tuning and Debugging

<img width="714" height="186" alt="image" src="https://github.com/user-attachments/assets/7a50f561-7174-407a-98db-5c5616257a0d" />
<img width="645" height="312" alt="image" src="https://github.com/user-attachments/assets/3faefea6-cf70-40e3-a4c6-d57cfc7b56a5" />


During validation, several practical issues were identified and improved:
- APD / laser alignment mismatch
- OPA855 stability issues
- RISO-related noise behavior
- ringing at the OPA695 output stage

## Results
<img width="799" height="268" alt="image" src="https://github.com/user-attachments/assets/ef53c742-668f-43b7-ac47-5ecc76aa8437" />

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
