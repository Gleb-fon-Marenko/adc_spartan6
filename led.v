////////////////////////////////////////////////////
//���ܣ���λ��ʽ����
//
//��ģ�飺��
//
//�汾��V0.00
//
//���ڣ�20131003
////////////////////////////////////////////////////
module led_module(
	//Clock Input:48M
	input	 clk,
	input  en,
	//LED
	inout [3:0]led
);
	//����һ������Ϊ�������������׼��
	parameter SEC_TIME = 32'd48_000_000;

	//���������������ʼ��Ϊ0
	//�˴���ʼ�����Է�����Ч���ۺ������Զ����ӣ���ͬ
	reg	[31:0]cnt1;
	initial cnt1 = 32'b0;
	//����hz��ʱ��
	reg clk_hz;
	initial clk_hz = 1'b0;

	//��׼������һֻ
	always@(posedge clk)
		if(cnt1 == SEC_TIME/2)
			begin 
				cnt1 <= 32'b0; 
				clk_hz = !clk_hz;
			end
		else cnt1 <= cnt1 + 1'b1;
	
	//��λ�Ĵ��� ˫�Ʊ���
	reg [3:0]led_reg;
	always@(posedge clk_hz)
		begin
			if(led_reg == 4'b0000)
				led_reg = 4'b1100;
			else if(led_reg == 4'b1111)
				led_reg = 4'b1100;
			else if(led_reg == 4'b1100)
				led_reg = 4'b1001;
			else if(led_reg == 4'b1001)
				led_reg = 4'b0011;
			else if(led_reg == 4'b0011)
				led_reg = 4'b0110;
			else if(led_reg == 4'b0110)
				led_reg = 4'b1100;
			else
				led_reg = 4'b1100;
		end
		assign led = en ? led_reg : 4'bzzzz;  
endmodule
