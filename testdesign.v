module testdesign( 
 clk, 
 rst_l, 
 xin_1, 
 xin_2,
 xin_3,
 xin_4,
 coef_0,
 coef_1,
 coef_2,
 coef_3,
 coef_4,
 coef_5,
 coef_6,
 coef_7,
 coef_8,
 coef_9,
 coef_10,
 coef_11,
 coef_12,
 coef_13,
 coef_14,
 coef_15,
 xout_15_1,
 xout_15_2,
 xout_15_3,
 xout_15_4
);

parameter ROUND = 1'b1;

input              clk;
input              rst_l;
input [4:0]        xin_1;
input [4:0]        xin_2;
input [4:0]        xin_3;
input [4:0]        xin_4;   
input signed [7:0] coef_0;  
input signed [7:0] coef_1;  
input signed [7:0] coef_2;  
input signed [7:0] coef_3;  
input signed [7:0] coef_4;  
input signed [7:0] coef_5;  
input signed [7:0] coef_6;  
input signed [7:0] coef_7;  
input signed [7:0] coef_8;  
input signed [7:0] coef_9;  
input signed [7:0] coef_10; 
input signed [7:0] coef_11; 
input signed [7:0] coef_12; 
input signed [7:0] coef_13; 
input signed [7:0] coef_14; 
input signed [7:0] coef_15; 

output [9:0] xout_15_1;    
output [9:0] xout_15_2;    
output [9:0] xout_15_3;     
output [9:0] xout_15_4;     


reg signed [4:0] xin_1_reg,xin_2_reg,xin_3_reg,xin_4_reg;
always @(posedge clk) begin
  xin_1_reg <= xin_1;
  xin_2_reg <= xin_2;
  xin_3_reg <= xin_3;
  xin_4_reg <= xin_4;
end


reg [9:0] xout_0, xout_1, xout_2, xout_3;
reg [9:0] xout_4, xout_5, xout_6, xout_7;
reg [9:0] xout_8, xout_9, xout_10,xout_11;
reg [9:0] xout_12,xout_13,xout_14;
reg signed [9:0] xout_15_1_pre;
reg signed [9:0] xout_15_2_pre;
reg signed [9:0] xout_15_3_pre;
reg signed [9:0] xout_15_4_pre;

wire signed [18:0] x00_1 = xout_15_4_pre * coef_0  + $signed({xin_1_reg,ROUND,10'd0});
wire signed [18:0] x01_1 = xout_15_4_pre * coef_1  + $signed({xout_0   ,ROUND,5'd0});
wire signed [18:0] x02_1 = xout_15_4_pre * coef_2  + $signed({xout_1   ,ROUND,5'd0});
wire signed [18:0] x03_1 = xout_15_4_pre * coef_3  + $signed({xout_2   ,ROUND,5'd0});
wire signed [18:0] x04_1 = xout_15_4_pre * coef_4  + $signed({xout_3   ,ROUND,5'd0});
wire signed [18:0] x05_1 = xout_15_4_pre * coef_5  + $signed({xout_4   ,ROUND,5'd0});
wire signed [18:0] x06_1 = xout_15_4_pre * coef_6  + $signed({xout_5   ,ROUND,5'd0});
wire signed [18:0] x07_1 = xout_15_4_pre * coef_7  + $signed({xout_6   ,ROUND,5'd0});
wire signed [18:0] x08_1 = xout_15_4_pre * coef_8  + $signed({xout_7   ,ROUND,5'd0});
wire signed [18:0] x09_1 = xout_15_4_pre * coef_9  + $signed({xout_8   ,ROUND,5'd0});
wire signed [18:0] x10_1 = xout_15_4_pre * coef_10 + $signed({xout_9   ,ROUND,5'd0});
wire signed [18:0] x11_1 = xout_15_4_pre * coef_11 + $signed({xout_10  ,ROUND,5'd0});
wire signed [18:0] x12_1 = xout_15_4_pre * coef_12 + $signed({xout_11  ,ROUND,5'd0});
wire signed [18:0] x13_1 = xout_15_4_pre * coef_13 + $signed({xout_12  ,ROUND,5'd0});
wire signed [18:0] x14_1 = xout_15_4_pre * coef_14 + $signed({xout_13  ,ROUND,5'd0});
wire signed [18:0] x15_1 = xout_15_4_pre * coef_15 + $signed({xout_14  ,ROUND,5'd0});

wire signed [19:0] x00_2 = $signed(x15_1[15:6]) * coef_0  + $signed({xin_2_reg,11'd0});
wire signed [19:0] x01_2 = $signed(x15_1[15:6]) * coef_1  + x00_1;
wire signed [19:0] x02_2 = $signed(x15_1[15:6]) * coef_2  + x01_1;
wire signed [19:0] x03_2 = $signed(x15_1[15:6]) * coef_3  + x02_1;
wire signed [19:0] x04_2 = $signed(x15_1[15:6]) * coef_4  + x03_1;
wire signed [19:0] x05_2 = $signed(x15_1[15:6]) * coef_5  + x04_1;
wire signed [19:0] x06_2 = $signed(x15_1[15:6]) * coef_6  + x05_1;
wire signed [19:0] x07_2 = $signed(x15_1[15:6]) * coef_7  + x06_1;
wire signed [19:0] x08_2 = $signed(x15_1[15:6]) * coef_8  + x07_1;
wire signed [19:0] x09_2 = $signed(x15_1[15:6]) * coef_9  + x08_1;
wire signed [19:0] x10_2 = $signed(x15_1[15:6]) * coef_10 + x09_1;
wire signed [19:0] x11_2 = $signed(x15_1[15:6]) * coef_11 + x10_1;
wire signed [19:0] x12_2 = $signed(x15_1[15:6]) * coef_12 + x11_1;
wire signed [19:0] x13_2 = $signed(x15_1[15:6]) * coef_13 + x12_1;
wire signed [19:0] x14_2 = $signed(x15_1[15:6]) * coef_14 + x13_1;
wire signed [19:0] x15_2 = $signed(x15_1[15:6]) * coef_15 + x14_1;

wire signed [20:0] x00_3 = $signed(x15_2[15:6]) * coef_0  + $signed({xin_3_reg,11'd0});
wire signed [20:0] x01_3 = $signed(x15_2[15:6]) * coef_1  + x00_2;
wire signed [20:0] x02_3 = $signed(x15_2[15:6]) * coef_2  + x01_2;
wire signed [20:0] x03_3 = $signed(x15_2[15:6]) * coef_3  + x02_2;
wire signed [20:0] x04_3 = $signed(x15_2[15:6]) * coef_4  + x03_2;
wire signed [20:0] x05_3 = $signed(x15_2[15:6]) * coef_5  + x04_2;
wire signed [20:0] x06_3 = $signed(x15_2[15:6]) * coef_6  + x05_2;
wire signed [20:0] x07_3 = $signed(x15_2[15:6]) * coef_7  + x06_2;
wire signed [20:0] x08_3 = $signed(x15_2[15:6]) * coef_8  + x07_2;
wire signed [20:0] x09_3 = $signed(x15_2[15:6]) * coef_9  + x08_2;
wire signed [20:0] x10_3 = $signed(x15_2[15:6]) * coef_10 + x09_2;
wire signed [20:0] x11_3 = $signed(x15_2[15:6]) * coef_11 + x10_2;
wire signed [20:0] x12_3 = $signed(x15_2[15:6]) * coef_12 + x11_2;
wire signed [20:0] x13_3 = $signed(x15_2[15:6]) * coef_13 + x12_2;
wire signed [20:0] x14_3 = $signed(x15_2[15:6]) * coef_14 + x13_2;
wire signed [20:0] x15_3 = $signed(x15_2[15:6]) * coef_15 + x14_2;

wire signed [21:0] x00_4 = $signed(x15_3[15:6]) * coef_0  + $signed({xin_4_reg,11'd0});
wire signed [21:0] x01_4 = $signed(x15_3[15:6]) * coef_1  + x00_3;
wire signed [21:0] x02_4 = $signed(x15_3[15:6]) * coef_2  + x01_3;
wire signed [21:0] x03_4 = $signed(x15_3[15:6]) * coef_3  + x02_3;
wire signed [21:0] x04_4 = $signed(x15_3[15:6]) * coef_4  + x03_3;
wire signed [21:0] x05_4 = $signed(x15_3[15:6]) * coef_5  + x04_3;
wire signed [21:0] x06_4 = $signed(x15_3[15:6]) * coef_6  + x05_3;
wire signed [21:0] x07_4 = $signed(x15_3[15:6]) * coef_7  + x06_3;
wire signed [21:0] x08_4 = $signed(x15_3[15:6]) * coef_8  + x07_3;
wire signed [21:0] x09_4 = $signed(x15_3[15:6]) * coef_9  + x08_3;
wire signed [21:0] x10_4 = $signed(x15_3[15:6]) * coef_10 + x09_3;
wire signed [21:0] x11_4 = $signed(x15_3[15:6]) * coef_11 + x10_3;
wire signed [21:0] x12_4 = $signed(x15_3[15:6]) * coef_12 + x11_3;
wire signed [21:0] x13_4 = $signed(x15_3[15:6]) * coef_13 + x12_3;
wire signed [21:0] x14_4 = $signed(x15_3[15:6]) * coef_14 + x13_3;
wire signed [21:0] x15_4 = $signed(x15_3[15:6]) * coef_15 + x14_3;

always @(posedge clk or negedge rst_l) begin
  if(!rst_l) {xout_0,xout_1,xout_2,xout_3,xout_4,xout_5,xout_6,xout_7,xout_8,xout_9,xout_10,xout_11,xout_12,xout_13,xout_14,
              xout_15_1_pre,xout_15_2_pre,xout_15_3_pre,xout_15_4_pre}<= 0;
  else begin
    xout_0  <= x00_4[15:6];
    xout_1  <= x01_4[15:6];
    xout_2  <= x02_4[15:6];
    xout_3  <= x03_4[15:6];
    xout_4  <= x04_4[15:6];
    xout_5  <= x05_4[15:6];
    xout_6  <= x06_4[15:6];
    xout_7  <= x07_4[15:6];
    xout_8  <= x08_4[15:6];
    xout_9  <= x09_4[15:6];
    xout_10 <= x10_4[15:6];
    xout_11 <= x11_4[15:6];
    xout_12 <= x12_4[15:6];
    xout_13 <= x13_4[15:6];
    xout_14 <= x14_4[15:6];
    xout_15_1_pre <= x15_1[15:6];
    xout_15_2_pre <= x15_2[15:6];
    xout_15_3_pre <= x15_3[15:6];
    xout_15_4_pre <= x15_4[15:6];
  end
end

reg [9:0] xout_15_1,xout_15_2,xout_15_3,xout_15_4; 
always @(posedge clk) begin
  xout_15_1 <= xout_15_1_pre;
  xout_15_2 <= xout_15_2_pre;
  xout_15_3 <= xout_15_3_pre;
  xout_15_4 <= xout_15_4_pre;
end

endmodule
