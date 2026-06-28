# Round-Robin Arbiter — Verilog HDL 🔄

**VLSI Open Ended Lab | EL-408 | NED University of Engineering and Technology**  
Course Instructor: Ms. Mariam Jamshaid

---

## 📌 Project Title
**Design and Implementation of a Verilog-based Round-Robin Arbiter with Fixed-Time Slice Allocation**

---

## 📖 Overview

A **4-input Round-Robin Arbiter** implemented in Verilog HDL that fairly allocates shared resource access among four requesters (REQ0–REQ3). Each requester is granted access for a fixed number of clock cycles (**time slice = 4**), after which the arbiter rotates to the next requester.

The design prevents **starvation** and ensures **fair, predictable scheduling** — concepts widely used in bus arbitration and multiprocessor systems.

---

## ⚙️ Features

- ✅ 4-input Round-Robin scheduling
- ✅ Fixed Time Slice allocation (4 clock cycles per request)
- ✅ One-hot encoded GRANT output
- ✅ Fully synchronous design (clock-driven)
- ✅ Handles inactive requests (skips and moves to next)
- ✅ Parameterized — easily scalable (`N`, `TIME_SLICE`)

---

## 🗂️ File Structure

```
round-robin-arbiter-verilog/
│
├── round_robin_counter.v        # 2-bit counter cycling 0 to N-1
├── round_robin_arbiter.v        # Main arbiter with time-slice logic
├── tb_round_robin_arbiter.v     # Testbench with multiple test cases
└── README.md
```

---

## 🔌 Block Diagram

```
REQ[3:0] ──┐
CLK ────────┤  Round-Robin Arbiter  ├──► GRANT[3:0]
RST ────────┘  ┌──────────────────┐
               │ RR Counter       │
               │ Time-Slice Ctr   │
               │ Arbitration Logic│
               └──────────────────┘
```

---

## 📊 State Transitions

| State | GRANT Output | Active Request |
|-------|-------------|----------------|
| 0     | `0001`      | REQ0           |
| 1     | `0010`      | REQ1           |
| 2     | `0100`      | REQ2           |
| 3     | `1000`      | REQ3           |

Transitions occur every **4 clock cycles** in circular order: `REQ0 → REQ1 → REQ2 → REQ3 → REQ0`

---

## 🧪 Simulation

Simulated using **ModelSim**. Test cases include:
1. System initialization after reset
2. All 4 requests active — full round-robin rotation
3. Selective requests active (REQ0 + REQ3 only)
4. Single request active (REQ2 only)

Waveforms confirm correct one-hot grant rotation and 4-cycle time slice duration (≈ 40 ns per grant at 100 MHz).

---

## 👥 Group Members

| Name             | Roll No   |
|------------------|-----------|
| Syeda Ayesha Ali | EL-22008  |
| Faraz Malik Awan | EL-22049  |
| Zukhruf Khan     | EL-22059  |
| Tamseela Hussain | EL-22062  |

---

## 🏷️ Topics
`verilog` `fpga` `vlsi` `digital-design` `round-robin` `arbiter` `modelsim` `hdl` `neduet`
