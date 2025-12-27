import sys

def is_id_invalid(id: int) -> bool: 
    if (id < 10 and id > - 10):
        return False;
    id_str = str(id)

    if len(id_str) % 2 == 1:
        return False;
    
    id_first_half:str = id_str[:int(len(id_str)/2)]
    id_second_half:str = id_str[int(len(id_str)/2):]
    return id_first_half == id_second_half;

if len(sys.argv) != 2: 
    print("Need 1 argument!")

with open(sys.argv[1], 'r') as file:
    input_file = file.read()

id_ranges = input_file.split(',')
invalid_ids = []

for id_range in id_ranges:
    range_split = id_range.split('-')
    range_start = int(range_split[0])
    range_end = int(range_split[1])
    
    for id_to_check in range(range_start, range_end + 1):
        if is_id_invalid(id_to_check) == True:
            invalid_ids.append(id_to_check)
            print(f"invalid: {id_to_check}")

print(f"Summed invalid IDs: {sum(invalid_ids)}")