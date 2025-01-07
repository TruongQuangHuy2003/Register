# Register Module

## Introduction

The `register` module is designed to emulate a register block with basic features such as read, write, and state management. It supports multiple registers with fixed addresses and operates synchronously with the clock signal (`clk`) while providing asynchronous reset functionality (`rst_n`). This module is an essential component in digital systems, used for data storage and management in hardware applications.

## Key Features

- **Management of multiple registers**:  
  - **`data0`**: Read/Write register for storing data (address 0x0).  
  - **`sr_data0`**: Read-only status register reflecting the value of `data0` (address 0x4).  
  - **`data1`**: Second Read/Write register (address 0x8).  
  - **`sr_data1`**: Read-only status register reflecting the value of `data1` (address 0xC).  

- **Supports read and write operations**:  
  - **Write operation**: Writes the value from `wdata` to the selected register when `wr_en` is high and the address is valid.  
  - **Read operation**: Outputs the value from the selected register to `rdata` when `rd_en` is high.

- **Asynchronous reset**:  
  - When `rst_n` is low, all registers are initialized to their default values.  

- **Scalable structure**:  
  - Uses constants to define register addresses, making it easy to modify and expand as needed.

## Operation

1. **Writing data to registers**:  
   When `wr_en` is active, data from `wdata` is written to either `data0` or `data1` based on the input address `addr`.

2. **Reading data from registers**:  
   When `rd_en` is active, data from the selected register is output on `rdata`. If the address is invalid, `rdata` outputs a default value (`32'h00000000`).

3. **Updating status registers**:  
   The status registers `sr_data0` and `sr_data1` automatically update with the current values of `data0` and `data1`.

4. **System reset**:  
   When the `rst_n` signal is low, all registers are reset to their default values:  
   - `data0` and `sr_data0`: `32'h00000000`  
   - `data1` and `sr_data1`: `32'hFFFFFFFF`  

## Applications

This module is suitable for various hardware applications, such as:  
- Temporary data storage during processing.  
- Managing system or signal states.  
- Integration into more complex designs like processors or control systems.
