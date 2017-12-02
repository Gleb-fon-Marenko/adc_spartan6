////////////////////////////////////////////////////
//���ܣ�1KHzƵ������������
//
//��ģ�飺��
//
//�汾��V0.00
//
//���ڣ�20131003
////////////////////////////////////////////////////
module beep_module(
	//Clock Input:48M
	input	 clk,
	input  en,
	output beep
);
	parameter DIV_KHZ = 32'd48_000;
	reg[31:0]cnt_khz;
	reg clk_1k;

	always@(posedge clk)
		if(cnt_khz == DIV_KHZ/2)
			begin 
				cnt_khz <= 32'b0; 
				clk_1k = !clk_1k;
			end
		else cnt_khz <= cnt_khz + 1'b1;	
	
	assign beep = en ? clk_1k : 1'bz;

endmodule
