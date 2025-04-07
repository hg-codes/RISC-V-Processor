def hex_to_decimal(input_file, output_file):
    try:
        with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
            for line in infile:
                line = line.strip()
                if line.startswith("//") or "x" in line:  # Keep comments and lines with 'x' as they are
                    outfile.write(line + '\n')
                else:
                    try:
                        decimal_number = int(line, 16)  # Convert hex to decimal
                        outfile.write(str(decimal_number) + '\n')
                    except ValueError:
                        print(f"Skipping invalid entry: {line}")
    except FileNotFoundError:
        print(f"Error: {input_file} not found.")

# Usage
hex_to_decimal('memory_dump.hex', 'result.txt')