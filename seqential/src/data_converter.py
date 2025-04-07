def decimal_to_binary(input_file, output_file):
    try:
        with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
            for line in infile:
                line = line.strip()
                if line:  # Ensure the line is not empty
                    try:
                        decimal_number = int(line)
                        binary_number = bin(decimal_number)[2:]  # Convert to binary and remove '0b'
                        outfile.write(binary_number + '\n')
                    except ValueError:
                        print(f"Skipping invalid entry: {line}")
    except FileNotFoundError:
        print(f"Error: {input_file} not found.")

# Usage
decimal_to_binary('input_bin.txt', 'initial_data.txt')