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



## **Additional Work: Static Timing Analysis Using OpenSTA**

As an extension to our primary project, we explored **Static Timing Analysis (STA)** using **OpenSTA**, an open-source industry-standard tool. This work was conducted on a **different digital circuit**, not related to the Python-based analysis. The goal was to understand the practical flow of STA using standard EDA inputs and tools used in real-world digital design.

OpenSTA helps analyze the timing of synthesized circuits by evaluating delays, constraints, and setup/hold violations based on gate-level netlists and timing libraries.


### Toolchain & Inputs

- **Tool Used**: OpenSTA (v2.6.2)
- **Input Files**:
  - `top.v` — Verilog netlist of the target circuit
  - `toy.lib` — Liberty file containing standard cell timing data
  - `top.sdc` — Timing constraint file with clock and I/O delays

### Flowchart

![Sample Circuit](https://github.com/itsharshschoice/Maximum-Frequency-Calculation-using-Static-Timing-Analysis/blob/main/opensta/Images/flowchart.png?raw=true)

### Flow Summary

1. Load the Liberty file and synthesized Verilog netlist.
2. Apply timing constraints using an SDC file.
3. Link the design.
4. Run setup and hold checks using OpenSTA's built-in reporting commands.
5. Extract worst-case slack to determine the timing performance.


### TCL Commands Executed

```tcl
read_liberty toy.lib
read_verilog top.v
link_design top
read_sdc top.sdc
report_checks -path_delay max -format full
report_checks -path_delay min -format full
```

### Frequency Calculation (TCL Script)

To compute the maximum frequency from the reported slack and defined clock period, we used a custom TCL script (`max_freq.tcl`):

```tcl
puts "Enter Clock Period (Tclk) in ns:"
gets stdin Tclk

puts "Enter Worst Slack in ns:"
gets stdin Slack

# Convert to floating-point
set Tclk [expr {double($Tclk)}]
set Slack [expr {double($Slack)}]

# Calculate required period
set Trequired [expr {$Tclk - $Slack}]

if { $Trequired <= 0 } {
    puts "Error: Required clock period is non-positive. Check your inputs."
    exit
}

# Calculate Fmax in MHz
set Fmax [expr {1000.0 / $Trequired}]

puts "\n----------- Maximum Frequency Report -----------"
puts " Given Clock Period   = $Tclk ns"
puts " Worst Setup Slack    = $Slack ns"
puts " Required Period      = $Trequired ns"
puts " Maximum Frequency    = $Fmax MHz"
puts "------------------------------------------------"
```

## **Output Screenshots**

- Worst Slack Report (from report_checks)

![Sample Circuit](https://github.com/itsharshschoice/Maximum-Frequency-Calculation-using-Static-Timing-Analysis/blob/main/opensta/Images/opensta_op1.png?raw=true)
![Sample Circuit](https://github.com/itsharshschoice/Maximum-Frequency-Calculation-using-Static-Timing-Analysis/blob/main/opensta/Images/opensta_op2.png?raw=true)

- Maximum Frequency Calculation (calc_freq.tcl)

![Sample Circuit](https://github.com/itsharshschoice/Maximum-Frequency-Calculation-using-Static-Timing-Analysis/blob/main/opensta/Images/max_freq.png?raw=true)


## **Conclusion**

This project explored two independent yet complementary approaches to performing **Static Timing Analysis (STA)** on digital circuits.

In the first part, we developed a custom Python script that parses a simplified netlist, extracts all flip-flop-to-flip-flop paths, performs setup and hold checks, and identifies the critical path that limits the circuit's performance. The script calculates the maximum achievable clock frequency based on delays and constraints, providing a clear and educational view of how STA works at a fundamental level.

In the second part, we applied **OpenSTA**, a professional, open-source STA tool, to a different synthesized digital circuit. By working with real-world design inputs such as Verilog netlists, Liberty libraries, and constraint files, we learned how STA is executed in practical industry workflows. We used `report_checks` to identify worst-case slack and computed the maximum frequency using a TCL script.

Together, these two efforts provided us with a solid understanding of both the theoretical and practical aspects of static timing analysis. While the Python-based method deepened our conceptual knowledge, the OpenSTA flow familiarized us with tool-based timing closure practices used in modern VLSI and digital design.
