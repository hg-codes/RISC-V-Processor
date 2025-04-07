# convert_memory_dump.py

def hex_to_dec(hex_value):
    """Convert 64-bit hexadecimal to signed decimal."""
    value = int(hex_value, 16)
    if value >= 2**63:  # Handle two's complement negative numbers
        value -= 2**64
    return value

def process_memory_dump(file_path):
    """Reads memory_dump.hex and converts values to decimal with memory indices."""
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
    
    with open("memory.txt", "w") as output:
        for mem, value in memory.items():
            output.write(f"{mem}: {value}\n")
    
    print("Converted memory values saved in memory.txt")

# Run the script
process_memory_dump("memory_dump.hex")
