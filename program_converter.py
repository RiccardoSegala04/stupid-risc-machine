def read_pgm_from_hex(file_path):
    try:
        with open(file_path, 'r') as file:
            content = file.read()

            instructions = int(len(content) / 4) - 1

            for i in range(0, len(content), 4):
                hex_chunk = content[i:i+4]
                hex_chunk = hex_chunk[::-1]
                
                try:
                    hex_value = int(hex_chunk, 16)
                    binary_value = bin(hex_value)[2:].zfill(16)  
                    print(f"memory({int(i/4)}) <= \"{binary_value}\";")
                except ValueError:
                    print(f"Invalid hex value: {hex_chunk}")
                
    except FileNotFoundError:
        print(f"The file at {file_path} was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

file_path = 'assembler/bootloader.hex'  
read_pgm_from_hex(file_path)
