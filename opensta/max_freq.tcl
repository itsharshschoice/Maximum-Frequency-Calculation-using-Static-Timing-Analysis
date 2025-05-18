# calc_freq.tcl
# Standalone script to calculate maximum frequency

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

