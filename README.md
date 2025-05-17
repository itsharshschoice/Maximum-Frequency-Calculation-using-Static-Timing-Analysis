# **Maximum Frequency Calculation using Static Timing Analysis**


This project presents a Python-based implementation of Static Timing Analysis (STA) to determine the maximum possible clock frequency of a digital circuit. It includes a custom script to analyze FF-to-FF (Flip-Flop to Flip-Flop) paths.

## **Overview**

In digital circuit design, it's critical to ensure that timing constraints are met for reliable operation. **Static Timing Analysis (STA)** is a method used to evaluate timing without simulation, ensuring that data signals propagate through logic correctly within one clock cycle.

This project includes:

- A Python script that:
  - Parses a netlist file
  - Identifies FF-to-FF paths
  - Computes path delays
  - Performs setup and hold checks
  - Identifies the critical path
  - Calculates the maximum clock frequency (f_max)

  
## **Flowchart**

Here is the high-level flow of the algorithm:

![Flowchart](https://github.com/itsharshschoice/Maximum-Frequency-Calculation-using-Static-Timing-Analysis/blob/main/Images/flowchart.png?raw=true)

## **Methodology**

### 1. Netlist Parsing
Parses the netlist file containing components (flip-flops, gates) and connections. Builds a directed graph.

### 2. FF-to-FF Path Extraction
Uses BFS to extract all timing paths from one flip-flop to another.

### 3. Delay Calculation
Computes the total combinational delay for each path, including clock-to-Q delay.

### 4. Setup and Hold Analysis
Validates:
- **Setup time** `(tclk_to_Q + tcomb + setup ≤ clock period + skew)`
- **Hold time** `(skew + hold << tclk_to_Q + tcomb)`

### 5. Critical Path Reporting
Identifies and reports the path with the highest (arrival + setup) delay.

### 6. Frequency Calculation
Estimates maximum frequency using:

- `Tmin = tclk_to_Q + tcomb + setup - skew`
- `fmax = 1 / Tmin`


## **Files Included**

| File              | Description                                      |
|-------------------|--------------------------------------------------|
| `max_freq2.py` | Python script for STA and frequency estimation   |
| `netlist2.txt`    | Sample input netlist for the circuit             |

## Sample Circuit Diagram

The analysis is based on a digital circuit like the one shown below:

![Sample Circuit](https://github.com/itsharshschoice/Maximum-Frequency-Calculation-using-Static-Timing-Analysis/blob/main/Images/example_circuit.png?raw=true)

## Input Netlist Format

The netlist is a simple text-based format defining components and connections:

![Sample Circuit](https://github.com/itsharshschoice/Maximum-Frequency-Calculation-using-Static-Timing-Analysis/blob/main/Images/netlist.png?raw=true)

## **Sample Output**

![Sample Circuit](https://github.com/itsharshschoice/Maximum-Frequency-Calculation-using-Static-Timing-Analysis/blob/main/Images/output.png?raw=true)

## **Conclusion**

Through this project, we explored the fundamental principles of Static Timing Analysis (STA) by building our own timing analyzer from scratch using Python. The script effectively parses a digital circuit netlist, traces all flip-flop-to-flip-flop paths, performs setup and hold checks, and identifies the critical path that limits the circuit’s performance. From there, it estimates the maximum clock frequency the circuit can safely run at.



