`timescale 1ns/1ps
module test_bench;
	reg clk;
	reg rst_n;
	reg wr_en;
	reg rd_en;
	reg [9:0] addr;
	reg [31:0] wdata;
	wire [31:0] rdata;

	register dut(
		.clk(clk),
		.rst_n(rst_n),
		.wr_en(wr_en),
		.rd_en(rd_en),
		.addr(addr),
		.wdata(wdata),
		.rdata(rdata)
	);

	initial begin
		clk = 0;
		forever #5 clk =~clk;
	end

	task verify;
		input [31:0] exp_rdata;
		begin
			$display("At time: %t, wr_en: 1'b%b, rd_en: 1'b%b, addr: 10'h%h, wdata: 32'h%h", $time, wr_en, rd_en, addr, wdata);
			if (rdata == exp_rdata) begin
				$display("------------------------------------------------------------------------------------------------------------");
				$display("PASSED: expected rdata: 32'h%h, Got rdata: 32'h%h", exp_rdata, rdata);
				$display("------------------------------------------------------------------------------------------------------------");
			end else begin
				$display("------------------------------------------------------------------------------------------------------------");
				$display("FAILDED: expected rdata: 32'h%h, Got rdata: 32'h%h", exp_rdata, rdata);
				$display("------------------------------------------------------------------------------------------------------------");
			end
		end
	endtask

	initial begin
		$dumpfile("test_bench.vcd");
		$dumpvars(0, test_bench);

		$display("---------------------------------------------------------------------------------------------------------------------------");
		$display("----------------------------------------------TESTBENCH FOR REGISTER ------------------------------------------------------");
		$display("---------------------------------------------------------------------------------------------------------------------------");

		rst_n = 0;
		wr_en = 1;
		rd_en = 0;
		addr = 10'h0;
		wdata = 32'h4;
		@(posedge clk);
		verify(32'h00000000);

		rst_n = 1;
		wr_en = 1;
		rd_en = 0;
		addr =10'h0;
		wdata = 32'hf0f0f0f0;
		@(posedge clk);
		verify(32'h00000000);

		wr_en = 0;
		rd_en = 1;
		addr = 10'h0;
		wdata = 32'hffffffff;
		@(posedge clk);
		verify(32'hf0f0f0f0);

		wr_en = 1;
		rd_en = 1;
		addr = 10'h0;
		wdata = 32'h55555555;
		@(posedge clk);
		verify(32'hf0f0f0f0);

		wr_en = 0;
		rd_en = 1;
		addr = 10'h0;
		wdata = 32'haaaaaaaa;
		@(posedge clk);
		verify(32'h55555555);

		wr_en = 1;
		rd_en = 0;
		addr = 10'h8;
		wdata = 32'h15975312;
		@(posedge clk);
		verify(32'h00000000);

		wr_en = 0;
		rd_en = 1;
		addr = 10'h8;
		wdata = 32'hffffffff;
		@(posedge clk);
		verify(32'h15975312);

		wr_en = 1;
		rd_en = 0;
		addr = 10'h4;
		wdata = 32'h11111111;
		@(posedge clk);
		verify(32'h00000000);
		
		wr_en = 0;
		rd_en = 1;
		addr = 10'h4;
		wdata = 32'h33333333;
		@(posedge clk);
		verify(32'h55555555);

		wr_en = 1;
		rd_en = 0;
		addr = 10'hc;
		wdata = 32'h7777777;
		@(posedge clk);
		verify(32'h00000000);

		wr_en = 0;
		rd_en = 1;
		addr = 32'hc;
		wdata = 32'h88888888;
		@(posedge clk);
		verify(32'h15975312);

		addr = 32'hf;
		@(posedge clk);
		verify(32'h00000000);

		$display("------------------------------------- TESTBENCH COMPLETED -------------------------------------------------");
		#100;
		$finish;
	end
endmodule

