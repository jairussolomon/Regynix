if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}
puts "Hostname : [info hostname]"

#-----------------------------------------------
# Include runtime report generation procedures
#-----------------------------------------------
timestat START

#-----------------------------------------------
# Library Set up
#-----------------------------------------------
set_attribute library { ./LIB/slow.lib ./LIB/pll.lib  ./LIB/CDK_S128x16.lib  ./LIB/CDK_S256x16.lib  ./LIB/CDK_R512x16.lib} /

#--------------------------------------------
# Define top level.
#--------------------------------------------
set design testdesign

#--------------------------------------------
# Define synthesis effort levels
#--------------------------------------------
if ![info exists SYN_EFF] {set SYN_EFF medium}
if ![info exists MAP_EFF] {set MAP_EFF medium}
if ![info exists INC_EFF] {set INC_EFF medium}
if ![info exists PHYS_EFF] {set PHYS_EFF medium}

#-----------------------------------------------
# Define various report directories
#-----------------------------------------------
set DATE [clock format [clock seconds] -format "%b%d_%T"]
set LOG_PATH     logs/logs
set OUTPUTS_PATH outputs/outputs
set REPORTS_PATH reports/reports

# Ensure that directories exist
if {![file exists ${LOG_PATH}]} {
  file mkdir ${LOG_PATH}
  puts "Creating directory ${LOG_PATH}"
}
if {![file exists ${OUTPUTS_PATH}]} {
  file mkdir ${OUTPUTS_PATH}
  puts "Creating directory ${OUTPUTS_PATH}"
}
if {![file exists ${REPORTS_PATH}]} {
  file mkdir ${REPORTS_PATH}
  puts "Creating directory ${REPORTS_PATH}"
}

#-----------------------------------------------
# generates <signal>_reg[<bit_width>] format
#-----------------------------------------------
set_attribute hdl_array_naming_style %s\[%d\] /  


#-----------------------------------------------
# Turn on TNS, affects global and incr opto
#-----------------------------------------------
set_attribute tns_opto true /
set_attribute super_thread_debug_directory st_debug_logs /
set_attr retime_debug 1 /
set_attr retime_debug_path 1 /

#-----------------------------------------------
# Read and elaborate RTL design
#-----------------------------------------------
puts "\nReading design files ..."
read_hdl -v2001 testdesign.v
    
puts "\nElaborating design ..."
elaborate $design

#-----------------------------------------------
# Check design
#-----------------------------------------------
puts "\nChecking design ..."
check_design
check_design -undriven -unloaded -multidriven \
 -unresolved -constant > ${REPORTS_PATH}/${design}.check_design.report

#-----------------------------------------------
# Read SDC file
#-----------------------------------------------
puts "\nReading SDC file ..."
read_sdc Constraints/${design}.sdc
puts "The number of exceptions is [llength [find /designs/$design -exception *]]"

#--------------------------------------------
# Check timing
#--------------------------------------------
puts "\nReport potential timing setup problems ..."
report timing -lint -verbose > $REPORTS_PATH/${design}.timing_lint.report
report timing -endpoints -num_paths 10 > $REPORTS_PATH/CritPath_SDC.rpt

#--------------------------------------------
#turn on retiming
#--------------------------------------------
set_attr retime true /des*/*
set_attr retime_optimize_reset true /

#--------------------------------------------
# Synthesize 
#--------------------------------------------
# Synthesizing to generic 
puts "\nSynthesizing to generic ..."
syn_gen
generate_reports -outdir $REPORTS_PATH -tag gen 
summary_table -outdir $REPORTS_PATH
report timing -endpoints -num_paths 10 > $REPORTS_PATH/TimingPath_Gen.rpt
write_db -to_file ${design}_generic.db 

# Synthesizing to gates
puts "\nSynthesizing to gates ..."
syn_map
generate_reports -outdir $REPORTS_PATH -tag map
summary_table -outdir $REPORTS_PATH
report timing -endpoints -num_paths 10 > $REPORTS_PATH/TimingPath_Map.rpt
write_db -to_file ${design}_map.db 


# Incremental Synthesis
puts "\nIncremental Synthesis ..."
syn_opt
generate_reports -outdir $REPORTS_PATH -tag iopt 
summary_table -outdir $REPORTS_PATH
report timing -endpoints -num_paths 10 > $REPORTS_PATH/TimingPath_Opt.rpt
write_db -to_file ${design}_incr.db 

##puts "============================"
#puts "Synthesis Finished ........."
#puts "============================"


quit
