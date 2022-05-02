require "config"
require "lib/utils"
local pprint = require("lib/pprint")
require "gameobjects.cell"
require "gameobjects.player"

function GetRandomPosition()
    ret = {
        x = love.math.random(BoundaryLeft, BoundaryRight),
        y = love.math.random(BoundaryTop, BoundaryBottom)
    }
    return ret
end

function love.load()
    local object_files = {}
    recursiveEnumerate('gameobjects', object_files)
    print(table.concat(object_files, ","))
    requireFiles(object_files)
end

GCells = {}
GEnemies = {}
GPlayer = Player(false)

function GenerateRandomConnections()
    local prev_v
    for i,v in ipairs(GCells) do
        if prev_v  then
            print("Connect from ")
            pprint.pprint(prev_v)
            print("Connect to ")

            v:connect(prev_v, true)
        end
        prev_v = v
    end
end

function GenerateGameObjects()
    local enemyCount = 2
    local cells_per_player = 3
    for enemy_idx = 1, enemyCount do
        local enemy = Player(true)
        table.insert(GEnemies, enemy)
        for cell_idx = 0, cells_per_player do
            local insert = Cell(enemy_idx, love.math.random(10, 100), enemy, GetRandomPosition())
            GCells[#GCells+1] = insert
            -- table.insert(GCells, insert )
            
        end
    end
    for cell_idx = #GCells, cells_per_player do
        GCells[#GCells+1] = Cell(false, love.math.random(10, 100), Player, GetRandomPosition())
        -- table.insert(GCells, cell_idx)
    end
    GenerateRandomConnections()
end

function love.graphics.getBackgroundColor()
    return 0.5, 1, 0.5, 1
end

image_position = {
    x = 0,
    y = 0
}

function love.update(dt)
    -- image_position.x = image_position.x + 1
    -- if image_position.x > WINDOW_WIDTH then
    --     image_position.x = 0
    -- end
    -- image_position.y = image_position.y + 1
    -- if image_position.y > WINDOW_HEIGHT then
    --     image_position.y = 0
    -- end
    -- -- print(1/dt)
    
end

function love.draw()
    -- pprint.pprint(GCells)
    -- for i = 0, #GCells do
    for i, v in ipairs(GCells) do
        -- pprint.pprint(GCells[i])
        -- print(type(GCells[i]))
        -- print(GCells[i]:is(Cell))
        -- GCells[i]:draw()
        v:draw_connections()
    end
    for i, v in ipairs(GCells) do
        -- pprint.pprint(GCells[i])
        -- print(type(GCells[i]))
        -- print(GCells[i]:is(Cell))
        -- GCells[i]:draw()
        v:draw()
    end
end

function love.run()
    GenerateGameObjects()

    if love.math then
        love.math.setRandomSeed(os.time())
    end
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    love.window.setVSync(true)

    if love.load then
        love.load(arg)
    end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then
        love.timer.step()
    end

    local timeDelta = 0
    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return a
                    end
                end
                love.handlers[name](a, b, c, d, e, f)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            timeDelta = love.timer.getDelta()
        end

        -- Call update and draw
        if love.update then
            love.update(timeDelta)
        end -- will pass 0 if love.timer is disabled

        if love.graphics and love.graphics.isActive() then
            love.graphics.clear(love.graphics.getBackgroundColor())
            love.graphics.origin()
            if love.draw then
                love.draw()
            end
            love.graphics.present()
        end

        if love.timer then

            love.timer.sleep(0.001)
            love.timer.sleep(FRAME_TIME - timeDelta)
        end
    end
end

