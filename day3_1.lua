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
    end
    return largest_index
end

print("Using input file " ..  arg[1])
local input = read_lines(arg[1])
local total_charge = 0

for i = 1, #input do
    local best_of_the_best_num = get_largest_number_index_between_indexes(input[i], 1, #input[i] - 1)
    local sidekick = get_largest_number_index_between_indexes(input[i], best_of_the_best_num + 1, #input[i])
    local charge = tonumber(string.sub(input[i], best_of_the_best_num, best_of_the_best_num) .. string.sub(input[i], sidekick, sidekick))
    total_charge = total_charge + charge
end

print("Total charge " .. total_charge)
