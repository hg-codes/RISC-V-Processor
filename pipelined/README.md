# Pipelined Implementation

Although you may be seeing a directory for sequential veriosn, it will work but it's working is not automated.

Use the pipelined version and the instruction are for it.

Use this folder to house the implementation of the pipelined RISC V processor

- put all module files into a folder called `src` and have the main wrapper file as `main.v`


---

# **RISC-V Pipelined Processor**

## **RISC-V 5-Stage Pipeline Explanation**

### **1. Instruction Fetch (IF)**

* Fetches the instruction from memory using the program counter (PC).
* Updates the PC to point to the next instruction.

### **2. Instruction Decode (ID)**

* Decodes the fetched instruction.
* Reads values from the register file if required.
* Determines the type of operation.

### **3. Execute & Address Generation (EX)**

* Performs arithmetic and logical operations using the ALU.
* Calculates memory addresses for load/store instructions.
* Determines branch targets if applicable.

### **4. Memory Access (MEM)**

* Reads from or writes to memory for load/store instructions.
* Passes execution results for other instruction types.

### **5. Write Back (WB)**

* Writes the computed result back to the destination register.
* Updates the register file for subsequent instruction execution.

---

## **Installation**

### **1. Install Icarus Verilog & GTKWave**

#### **Ubuntu/Debian:**

```bash
sudo apt update
sudo apt install iverilog gtkwave
```

#### **Arch Linux:**

```bash
sudo pacman -S iverilog gtkwave
```

#### **macOS (Homebrew):**

```bash
brew install icarus-verilog gtkwave
```

#### **Windows:**

1. Download **Icarus Verilog** from [here](https://bleyer.org/icarus/).
2. Download **GTKWave** from [here](https://sourceforge.net/projects/gtkwave/).
3. Install both and add them to the system path.

---

### **2. Clone the Repository



**

Run the following command to clone the RISC-V processor repository:

```
git clone https://github.com/ManikyaPant/RISC-V-Processor.git
cd RISC-V-Processor/Pipelined_Processor/src

```


---

## **Usage**

### **1. Prepare the Assembly Program**

* Use an assembly load supporting `add`, `sub`, `and`, `or`, `ld`, `sd`, `beq`, `blt` commands.
* Write a code in assembly using risc instruction set and save it as `program.txt, comments can be added by starting with `
* Run the following command to convert it into corresponding machine code

```bash
node assemble.js program.txt instructions.txt
```

### **2. Initialize Data and Registers**

- Run the following command which creates `input_registers.txt` ,`input_data_memory.txt`.Edit the values for your register and data memory:
  ```bash
  python3 intialise.py
  ```

### **3. Compile the Verilog Files:**

```bash
iverilog -o risc_pipeline.out main.v
```

### **4. Run the Simulation:**

```bash
vvp risc_pipeline.out
```

### **5. To View Waveform in GTKWave:**

```bash
gtkwave main.vcd
```

### **6. Check the Output Files**

- `reg_dump.hex` → Stores the final register contents.
- `memory_dump.hex` → Stores the final memory contents.
- Convert `memory_dump.hex , reg_dump.hex` to decimal format using:

  ```bash
  python3 hex_to_dec.py
  ```
- You can see the memory output in decimal format in `memory.txt`.
- You can see the register output in decimal format in `register.txt`.

  ### **7. All Commands**


  ```bash
  node assemble.js program.txt instructions.txt
  python3 intialise.py 
  iverilog -o risc_pipeline.out main.v && vvp risc_pipeline.out
  python3 hex_to_dec.py

  ```
- You can see the memory output in decimal format in `memory.txt`.
- You can see the register output in decimal format in `register.txt`

---

## **Example Assembly Code(Sorting an Array)**

```assembly
#x2 contains the base address of memory
   #x1 conains the number of elements
   #initiall store 1 in x6
   
   
                    add x26,x0, x0   
                    sub x31 ,x1,x6  
    Loop1:   
                   beq x26, x31, Exit
                   add x27, x0, x0 
                   sub x30 ,x1 ,x26  
                   sub x30, x30, x6 
   Loop2:
                  beq x27, x30, Temp
                   add x20, x2, x27  
                   add x22, x27, x6  
                  add x21 ,x2, x22   
                   ld  x18, 0(x20)   
                   ld x19 ,0(x21)  
                   blt x19 ,x18, Swap  
intermediate: 
                   add x27, x27, x6   
                   beq x0, x0, Loop2  
    Temp:
              add x26 ,x26, x6   
              beq x0 ,x0 ,Loop1
    Swap:
              sd x18, 0(x21)
              sd x19 ,0(x20)
              beq x0, x0, intermediate
    Exit:

```

### **Corresponding Machine Code**

```plaintext
//instructions.txt

00000000000000000000110100110011
01000000011000001000111110110011
00000101111111010000010001100011
00000000000000000000110110110011
01000001101000001000111100110011
01000000011011110000111100110011
00000011111011011000001001100011
00000001101100010000101000110011
00000000011011011000101100110011
00000001011000010000101010110011
00000000000010100011100100000011
00000000000010101011100110000011
00000001001010011100101001100011
00000000011011011000110110110011
11111110000000000000000011100011
00000000011011010000110100110011
11111100000000000000010011100011
00000001001010101011000000100011
00000001001110100011000000100011
11111110000000000000010011100011 
```

---

### Current regfile.v with Initial begin aligned to sorting

```verilog
module register_file (
    input wire clk,
    input wire write_enable,
    input wire [4:0] rs1, rs2, rd,
    input wire [63:0] write_data,
    output wire [63:0] read_data1, read_data2
);

    reg [63:0] registers [31:0]; // 32 registers of 64-bit each

    // Asynchronous Read
    assign read_data1 = (rs1 != 0) ? registers[rs1] : 32'b0;
    assign read_data2 = (rs2 != 0) ? registers[rs2] : 32'b0;

    // Synchronous Write
    always @(*) begin
        if (write_enable && rd != 0)
            registers[rd] <= write_data;
    end

 initial begin  
    registers[1]=64'd5;
    registers[2]=64'd0;
    registers[6]=64'd1;
    registers[7]=64'd2;

 end

initial begin
    #1000;  
     $display("Writing memory to file");
    $writememh("reg_dump.hex", registers);
        $display("Memory write completed.");  
end

endmodule

```

### intial_data.txt used for Sorting

```
0000000000000000000000000000000000000000000000000000000000000101
0000000000000000000000000000000000000000000000000000000000000100
0000000000000000000000000000000000000000000000000000000000000011
0000000000000000000000000000000000000000000000000000000000000010
0000000000000000000000000000000000000000000000000000000000000001

```

### **Final Output visible for this in memory_dump.hex**

```
// 0x00000000
0000000000000001
0000000000000002
0000000000000003
0000000000000004
0000000000000005
xxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxx
```

### **Run the Processor**

Execute the following commands in the terminal within the project folder:

```bash
iverilog -o risc.out main.v
vvp risc.out
gtkwave main.vcd
```

### Credits

The encoder module is adapted from [LUPLabs&#39; rvcodec.js](https://github.com/lupyuen/rvcodec.js), and I built a custom assembler on top of it to convert RISC-V assembly files into machine code for my Verilog-based processor.
