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
    --[[if nearby_rolls < 4 then
        print("Accessible " .. i .. ", " .. j)
    end]]--
    return nearby_rolls < 4
end

local function clear_accessible_rolls(grid)
    local changed = 0
    for i = 1, #grid do
        for j = 1, #grid[i] do
            if string.sub(grid[i], j,j) == "@" and is_roll_accesible(grid, i,j) then
                grid[i] = string.sub(grid[i],1,  j - 1) ..  "." .. string.sub(grid[i], j+1, #grid[i])    
                changed = changed + 1
            end
        end
    end
    if changed > 0 then 
        changed = changed + clear_accessible_rolls(grid)
    end
    return changed
end

local input_lines = read_lines(arg[1])

print("Removed rolls " .. clear_accessible_rolls(input_lines))