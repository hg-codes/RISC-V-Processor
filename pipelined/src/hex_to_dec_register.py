# convert_reg_dump.py

def hex_to_dec(hex_value):
    """Convert 64-bit hexadecimal to signed decimal."""
    value = int(hex_value, 16)
    if value >= 2**63:  # Handle two's complement negative numbers
        value -= 2**64
    return value

def process_reg_dump(file_path):
    """Reads reg_dump.hex and converts values to decimal with register names."""
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
    
    with open("register_values.txt", "w") as output:
        for reg, value in registers.items():
            output.write(f"{reg}: {value}\n")
    
    print("Converted register values saved in register_values.txt")

# Run the script
process_reg_dump("reg_dump.hex")
