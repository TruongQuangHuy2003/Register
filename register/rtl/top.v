module register (
	input wire clk,
	input wire rst_n,
	input wire wr_en,
	input wire rd_en,
	input wire [9:0] addr,
	input wire [31:0] wdata,
	output reg [31:0] rdata
);

// Define the internal register addresses 
parameter ADDR_DATA0 = 10'h0;
parameter ADDR_SR0 = 10'h4;
parameter ADDR_DATA1 = 10'h8;
parameter ADDR_SR1 = 10'hc;

// Define the internal registers
reg [31:0] data0;	 // the data0 register.
reg [31:0] sr_data0;	 // the Status data0 register.
reg [31:0] data1;	 // The data1 register.
reg [31:0] sr_data1;	// The status data1 register

initial begin
	data0 = 32'h00000000;
	sr_data0 = 32'h00000000;
	data1 = 32'hffffffff;
	sr_data1 = 32'hffffffff;
end

// writing data and update register.
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data0 <= 32'h00000000;
		sr_data0 <= 32'h00000000;
		data1 <= 32'hffffffff;
		sr_data1 <= 32'hffffffff;
		rdata <= 32'h00000000;
	end else begin
		if (wr_en && (addr == ADDR_DATA0)) begin
			data0 <= wdata; 		// write data in the data0 register.
		end else if (wr_en && (addr == ADDR_DATA1)) begin
			data1 <= wdata; 		// write data in the data1 register.
		end else if (wr_en && (addr == ADDR_SR0)) begin
			sr_data0 <= data0;
		end else if (wr_en && (addr == ADDR_SR1)) begin
			sr_data1 <= data1;
		end 

		if (rd_en) begin
			case (addr)
				ADDR_DATA0: rdata <= data0;
				ADDR_SR0: rdata <= sr_data0;
				ADDR_DATA1: rdata <= data1;
				ADDR_SR1: rdata <= sr_data1;
				default: rdata <= 32'h00000000;
			endcase
		end else begin
			rdata <= 32'h00000000;
		end
	end
end

endmodule
