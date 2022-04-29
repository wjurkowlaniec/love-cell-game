require "config"
require "lib/utils"
require "gameobjects.cell"


function love.load()
    local object_files = {}
    recursiveEnumerate('gameobjects', object_files)
    print(table.concat(object_files, ","))
    requireFiles(object_files)
end

function initalize_game()
    enemies=1
    cells_per_player=3
    cells = 
end


function love.graphics.getBackgroundColor()
    return 0.5, 1, 0.5, 1
end

image_position = {x=0, y= 0}

function love.update(dt)
    image_position.x=image_position.x+1
    if image_position.x > WINDOW_WIDTH  then 
        image_position.x=0
    end 
    image_position.y=image_position.y+1
    if image_position.y > WINDOW_HEIGHT  then 
        image_position.y=0
    end
    -- print(1/dt)

end

function love.draw()
end


function love.run()
    
    if love.math then
        love.math.setRandomSeed(os.time())
    end
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    love.window.setVSync( true)

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
            love.timer.sleep(FRAME_TIME-timeDelta)
        end
    end
end

