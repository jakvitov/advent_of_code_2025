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


local function print_parsed_input(parsed_input) 
    print("Ranges")
    for _, val in ipairs(parsed_input.ranges) do 
        print("Rng start: " .. val.rng_start .. ", Rng end: " .. val.rng_end)
    end
    print("Ingredient IDs")
    for _, val in ipairs(parsed_input.ingredient_ids) do
        print(val)
    end

end

local function parse_input()
    local input_lines = read_lines(arg[1])
    local ranges = {}
    local ingredient_ids = {}
    for i = 1, #input_lines do
        if input_lines[i] == "\n" then 
            goto continue
        end

        local range_delimeter_index = string.find(input_lines[i], "-")
        
        if range_delimeter_index then
           local range_start = tonumber(string.sub(input_lines[i], 1, range_delimeter_index - 1))
           local range_end = tonumber(string.sub(input_lines[i], range_delimeter_index + 1, #input_lines[i]))
           table.insert(ranges, {rng_start = range_start, rng_end = range_end})
        else
            table.insert(ingredient_ids, tonumber(input_lines[i]) )
        end

        ::continue::
    end 

    return {ranges = ranges, ingredient_ids = ingredient_ids}
end

local function is_fresh(ingredient_id, ranges)
    --print("Checking " .. ingredient_id)
    for _, range in ipairs(ranges) do
        if ingredient_id >= range.rng_start and ingredient_id <= range.rng_end then
            return true
        end
    end
    return false
end

local parsed_input = parse_input()
print_parsed_input(parsed_input)
local fresh = 0

for _, ingr_id in ipairs(parsed_input.ingredient_ids) do
    fresh = is_fresh(ingr_id, parsed_input.ranges) and fresh + 1 or fresh
end

print("Fresh " .. fresh)