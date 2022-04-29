Object = require "lib/classic"

Cell = Object:extend()

Colors = {
    PLAYER = love.math.colorFromBytes(192, 266, 42),
    ENEMY = {love.math.colorFromBytes(238, 51, 255), love.math.colorFromBytes(255, 132, 60),
             love.math.colorFromBytes(255, 222, 56)}
}

function Cell:new(enemy, health, player, position)
    local health = type.health
    if enemy then
        local color = Colors.ENEMY[enemy]
    else
        local color = Colors.PLAYER
    end

    image = love.graphics.newImage('assets/cell.png')

    local position = {x=position.x, y=position.y}
    local player = player
end

function Cell:update(dt)
end

function Cell:playerTakeover(newPlayer)
    player=newPlayer
end

function Cell:draw()
    
end
