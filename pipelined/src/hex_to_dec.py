def hex_to_dec(hex_value):
    """Convert 64-bit hexadecimal to signed decimal."""
    value = int(hex_value, 16)
    if value >= 2**63:  # Handle two's complement negative numbers
        value -= 2**64
    return value

def process_memory_dump(file_path, output_file):
    """Reads memory dump file and converts values to decimal with memory indices."""
    memory = {}
    with open(file_path, "r") as file:
        lines = file.readlines()
    
    mem_index = 0
    for line in lines:
        line = line.strip()
        if line.startswith("//") or line == "":  # Ignore comments and empty lines
            continue
        
        if "x" in line.lower():  # If value is 'xxxxxxxxxxxxxxxx', store as is
            memory[f"memory[{mem_index}]"] = line
        else:
            memory[f"memory[{mem_index}]"] = hex_to_dec(line)

        mem_index += 1
        if mem_index > 255:  # Stop after memory[255]
            break
    
    with open(output_file, "w") as output:
        for mem, value in memory.items():
            output.write(f"{mem}: {value}\n")
    
    print(f"Converted memory values saved in {output_file}")

def process_reg_dump(file_path, output_file):
    """Reads register dump file and converts values to decimal with register names."""
    registers = {}
    with open(file_path, "r") as file:
        lines = file.readlines()
    
    reg_index = 0
    for line in lines:
        line = line.strip()
        if line.startswith("//") or line == "":  # Ignore comments and empty lines
            continue
        
        if "x" in line.lower():  # If value is 'xxxxxxxxxxxxxxxx', store as is
            registers[f"x{reg_index}"] = line
        else:
            registers[f"x{reg_index}"] = hex_to_dec(line)

        reg_index += 1
        if reg_index > 31:  # Stop after x31
            break
    
    with open(output_file, "w") as output:
        for reg, value in registers.items():
            output.write(f"{reg}: {value}\n")
    
    print(f"Converted register values saved in {output_file}")

# Run the script
process_memory_dump("memory_dump.hex", "memory.txt")
process_reg_dump("reg_dump.hex", "register_values.txt")
