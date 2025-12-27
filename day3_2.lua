local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

local function read_lines(file)
    if not file_exists(file) then
        print("File not found " .. file)
        return {}
    end
    local lines = {}
    for line in io.lines(file) do 
        lines[#lines + 1] = line
    end
    return lines
end

local function get_largest_number_index_between_indexes(input_line, start_index, end_index)
    local largest = tonumber(string.sub(input_line, start_index, start_index))
    local largest_index = start_index
    for i = start_index + 1, end_index do
        local num = tonumber(string.sub(input_line, i, i))
        if num > largest then
            largest = num
            largest_index = i
        end
        
        if largest == 9 then
            break
        end
    end
    return largest_index
end

print("Using input file " ..  arg[1])
local input = read_lines(arg[1])
local total_charge = 0

for i = 1, #input do
    local line = input[i]
    local line_charge = ""
    local last_charge_index = 0

    for j = 1, 12 do
        local battery_index = get_largest_number_index_between_indexes(line, last_charge_index + 1, #line - (11 - #line_charge))
        line_charge = line_charge .. string.sub(line, battery_index, battery_index)
        last_charge_index = battery_index
    end
    print("Battery " .. i .. " charge " .. line_charge)
    total_charge = total_charge + tonumber(line_charge)
end

print("Total charge " .. total_charge)
