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

local function is_roll_accesible(grid, i, j) 
    local nearby_rolls = 0
    for x = i - 1, i + 1 do
        for y = j - 1, j + 1 do
            if (x == i and y == j) or y < 1 or x < 1 or x > #grid or y > #grid[1] then
                goto continue
            end
            if string.sub(grid[x],y,y) == "@" then
                nearby_rolls = nearby_rolls + 1
            end
            ::continue::
        end
    end
    if nearby_rolls < 4 then
        print("Accessible " .. i .. ", " .. j)
    end
    return nearby_rolls < 4
end

local input_lines = read_lines(arg[1])
local accessible_rolls = 0

for i = 1, #input_lines do
    for j = 1, #input_lines[i] do
        if string.sub(input_lines[i], j,j) == "@" then
                accessible_rolls = is_roll_accesible(input_lines, i,j) and accessible_rolls + 1 or accessible_rolls
        end
    end
end

print("Accessible rolls " .. accessible_rolls)