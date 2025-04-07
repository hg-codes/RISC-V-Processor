import os

# File names
INITIAL_REG_FILE = "input_registers.txt"
FORMATTED_REG_FILE = "initial_registers.txt"
INITIAL_MEM_FILE = "input_data_memory.txt"
FORMATTED_MEM_FILE = "initial_data.txt"

def create_initial_file(filename, count, prefix):
    """Creates an initial file (register/memory) with x values."""
    if not os.path.exists(filename):
        with open(filename, 'w') as f:
            for i in range(count):
                f.write(f"{prefix}{i}: x\n")
        print(f"{filename} created. Edit it with your values.")

def decimal_to_64bit_binary(value):
    """Convert a decimal number to a 64-bit two’s complement binary string."""
    value = int(value)  # Ensure it's an integer
    if value < 0:
        return format((1 << 64) + value, '064b')  # Two’s complement for negative numbers
    return format(value, '064b')  # Regular binary for non-negative numbers

def process_file(input_file, output_file):
    """Reads input file, processes values, and saves output file."""
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            item, val = line.strip().split(':')
            val = val.strip()

            if val == 'x':
                binary_value = '0' * 64  # 64-bit zero
            else:
                binary_value = decimal_to_64bit_binary(val)

            outfile.write(f"{binary_value}\n")

    print(f"Conversion completed! Check {output_file}.")

# Step 1: Create initial files if they don't exist
create_initial_file(INITIAL_REG_FILE, 32, "x")
create_initial_file(INITIAL_MEM_FILE, 256, "memory")

# Step 2: Wait for user to edit the files
input(f"Edit {INITIAL_REG_FILE} and {INITIAL_MEM_FILE}, then press Enter when ready...")

# Step 3: Process user inputs and generate formatted files
process_file(INITIAL_REG_FILE, FORMATTED_REG_FILE)
process_file(INITIAL_MEM_FILE, FORMATTED_MEM_FILE)
