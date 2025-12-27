import sys

def split_into_parts(id_str: str, window_size: int) -> list[str]:
    window_repeated:int = int(len(id_str) / window_size)
    res: list[str] = []
    for i in range(0, window_repeated):
        res.append(id_str[i*window_size:((i*window_size) + window_size)])
    return res

def are_all_parts_equal(id_parts: list[str]) -> bool:
    if len(id_parts) < 2 :
        return False;
    for i in range(1, len(id_parts)):
        if id_parts[0] != id_parts[i]:
            return False
    return True
        

    

def is_id_invalid(id: int) -> bool: 
    if (id < 10 and id > - 10):
        return False;
    id_str = str(id)

    #Naive way kinda
    for i in range(1, int(len(id_str)/2) + 1):
        if len(id_str) % i != 0 :
            continue;

        id_parts: list[str] = split_into_parts(id_str, i)
        if are_all_parts_equal(id_parts):
            return True
        
    return False        



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