set SDC_MODE             SYNTHESIS 
set SDC_CORNER           WC
set CLK_200_PERIOD       5.00
set CLK_200_S_UNCERT     1.25
set CLK_200_H_UNCERT     0.00
set CLK_200_INPUT_DELAY  2.25
set CLK_200_OUTPUT_DELAY 2.25
set OCV_CELL_TIMING_DERATE_CLOCK_EARLY 1.00
set OCV_CELL_TIMING_DERATE_CLOCK_LATE  1.00
set OCV_CELL_TIMING_DERATE_DATA_EARLY  1.00
set OCV_CELL_TIMING_DERATE_DATA_LATE   1.00
set OCV_NET_TIMING_DERATE_CLOCK_EARLY  1.00
set OCV_NET_TIMING_DERATE_CLOCK_LATE   1.00
set OCV_NET_TIMING_DERATE_DATA_EARLY   1.00
set OCV_NET_TIMING_DERATE_DATA_LATE    1.00


echo "Loading block SDC file in $SDC_MODE mode ..."

#----------------------------------------------------------
# Define block level clock insertion delay
#----------------------------------------------------------
if {$SDC_MODE == "SYNTHESIS"} {
  set CLK_200_ID 0
} else {
  switch $SDC_CORNER {
    WC {
      set CLK_200_ID 1
    }
    BC {
      set CLK_200_ID 0.3
    }
    TYP {
      set CLK_200_ID 0.6
    }
    ML {
      set CLK_200_ID 0.3
    }
  }
}


#----------------------------------------------------------
# Create primary clocks
#----------------------------------------------------------
echo "Creating primary clocks ..."
create_clock -period $CLK_200_PERIOD [get_ports clk]
set_clock_uncertainty -setup $CLK_200_S_UNCERT clk
set_clock_uncertainty -hold  $CLK_200_H_UNCERT clk

#----------------------------------------------------------
# Create async reset list
#----------------------------------------------------------
echo "False path async resets ..."
set reset_list [ list \
  rst_l \
]
if {$SDC_MODE == "SYNTHESIS"} { set_ideal_network -no_propagate $reset_list }
set_false_path -from [get_ports $reset_list]

#----------------------------------------------------------
# Define Input constraints
#----------------------------------------------------------
echo "Defining input constraints ..."
set clk_inputs [list \
  xin_1 \
  xin_2 \
  xin_3 \
  xin_4 \
]
set_input_delay [expr $CLK_200_INPUT_DELAY + $CLK_200_ID] [get_ports $clk_inputs] -clock [get_clocks clk]


#----------------------------------------------------------
# Define asynchronous input constraints
#----------------------------------------------------------
echo "Defining async constraints ..."
set async_inputs [list \
  coef_0 \
  coef_1 \
  coef_2 \
  coef_3 \
  coef_4 \
  coef_5 \
  coef_6 \
  coef_7 \
  coef_8 \
  coef_9 \
  coef_10 \
  coef_11 \
  coef_12 \
  coef_13 \
  coef_14 \
  coef_15 \
]
set_false_path -from [get_ports $async_inputs]


#----------------------------------------------------------
# Define outputs constraints
#----------------------------------------------------------
echo "Defining output constraints ..."
set clk_outputs [list \
  xout_15_1 \
  xout_15_2 \
  xout_15_3 \
  xout_15_4 \
]
set_output_delay [expr $CLK_200_OUTPUT_DELAY - $CLK_200_ID] [get_ports $clk_outputs] -clock [get_clocks clk]

