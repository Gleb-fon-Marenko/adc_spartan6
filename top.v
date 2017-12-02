////////////////////////////////////////////////////
//功能：数码管驱动，静态7段码
//
//子模块：1、闪灯 2、蜂鸣器
//
//版本：V0.00
//
//日期：20131003
////////////////////////////////////////////////////
module top(
	//Clock Input:48M
	input	 	CLK,
	//Bell

	//Digital tube
	output 	DS_A,DS_B,DS_E,DS_F,DS_C,DS_D,DS_G,DS_DP,
	output	DS_EN1,DS_EN2,DS_EN3,DS_EN4,
	//ADC
	output ADCSN,ADCLK,	
	input ADDAT,
	
	output de_ADCSN,
	reg DP,
	output de_ADCLK,de_ADDAT
	
	
);


	

//BEEP MODULE	

parameter [6:0]NUM_0=7'b0111111;
parameter [6:0]NUM_1=7'b0000110;
parameter [6:0]NUM_2=7'b1011011;
parameter [6:0]NUM_3=7'b1001111;
parameter [6:0]NUM_4=7'b1100110;
parameter [6:0]NUM_5=7'b1101101;
parameter [6:0]NUM_6=7'b1111101;
parameter [6:0]NUM_7=7'b0000111;
parameter [6:0]NUM_8=7'b1111111;
parameter [6:0]NUM_9=7'b1101111;
parameter [6:0]NUM_A=7'b1110111;
parameter [6:0]NUM_B=7'b1111100;
parameter [6:0]NUM_C=7'b1011000;
parameter [6:0]NUM_D=7'b1011110;
parameter [6:0]NUM_E=7'b1111001;
parameter [6:0]NUM_F=7'b1110001;
parameter [6:0]NUM_BLK=7'b0000000;

parameter [3:0]EN_1=4'b1110;
parameter [3:0]EN_2=4'b1101;
parameter [3:0]EN_3=4'b1011;
parameter [3:0]EN_4=4'b0111;
reg  [3:0]en,num;
wire [3:0]dat1,dat2,dat3;

assign dat3=((129*dat)/10000);

assign dat2=(((129*dat)/1000)-(dat3*10));

//assign dat1=(((129*dat)/100)-(dat3*100)-(dat2*10));

reg [6:0]  to_leds;
reg [7:0]	dat=8'hF5;
assign {DS_G,DS_F,DS_E,DS_D,DS_C,DS_B,DS_A} = to_leds ;
assign {DS_EN1,DS_EN2,DS_EN3,DS_EN4} = en;

reg [3:0]cnt;

always@(posedge ADCLK)
	if(ADCSN==1) cnt<=0;
	else
	if(cnt<8)cnt<=cnt+1;

always@(posedge ADCLK)
	
	if(cnt<8&&ADCSN==0)dat<={dat,ADDAT};

assign ADCSN=div[20];
assign ADCLK=div[13];

assign de_ADCLK= 1;
assign de_ADDAT= 1;

assign de_ADCSN=1;

reg [28:0]div;
always@(posedge CLK) div<=div+1;

always@(*)
	   if(div[12]==0)
		begin 
		num=dat2;
		en=EN_1;
		DP=0;
		end
		else 
       if(div[12]==1)
			begin
			num=dat3;
			en=EN_2;
			DP=1;
			end
			
	



		
always@(*)
	case(num)
0:to_leds=NUM_0;
1:to_leds=NUM_1;
2:to_leds=NUM_2;
3:to_leds=NUM_3;
4:to_leds=NUM_4;
5:to_leds=NUM_5;
6:to_leds=NUM_6;
7:to_leds=NUM_7;
8:to_leds=NUM_8;
9:to_leds=NUM_9;
10:to_leds=NUM_A;
11:to_leds=NUM_B;
12:to_leds=NUM_C;
13:to_leds=NUM_D;
14:to_leds=NUM_E;
15:to_leds=NUM_F;
endcase




endmodule

