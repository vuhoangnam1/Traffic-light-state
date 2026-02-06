# Traffic-light-controller - SystemVerilog
## Overview
This project implements a **Traffic Light Controller** using SystemVerilog
The design models a finite state machine (FSM) controlling traffic lights and verifies correct state transitions and timing behavior through simulation.
This project is suitable for **digital design practice**, **FSM verification**, and **RTL testbench development**.

---

## Design Description
The traffic light controller is implemented as a **finite state machine (FSM)** with three main states:
- RED
- GREEN
- YELLOW
Each state remains active for a predefined number of clock cycles before transitioning to the next state
in a fixed sequence.

---

## Testbench
The testbench focuses on functional and timing verification of the DUT.

### Testbench Features
- Clock and reset generation
- Stimulus generation for traffic light operation
- State transition verification
- Timing verification for each traffic light phase
- Output monitoring and result checking
- Verification of correct traffic light sequencing
- Functional coverage is implemented to evaluate the quality and completeness of verification
---

## Test Scenarios
The following test scenarios are covered:

- Reset and initial state verification
- Normal operation through all traffic light states
- Correct order of state transitions (Red → Green → Yellow → Red)
- Correct duration of each state
- Continuous operation without illegal states

---

## Simulation
- Simulator: ModelSim / Quartus
- Language: SystemVerilog

### How to Run
1. Compile RTL and testbench files
2. Run Makefile
3. Observe waveform and console output to verify correctness

---

## Project Scope
- RTL implementation of traffic light
- Verification using both traditional testbench and UVM
- Learning and practicing FSM and UVM methodology

---

## Author
Vu Hoang Nam  
Design Verification

