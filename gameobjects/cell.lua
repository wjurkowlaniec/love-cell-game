Object = require "lib/classic"

Cell = Object:extend()

Colors = {
    PLAYER = love.math.colorFromBytes(192, 266, 42),
    ENEMY = {love.math.colorFromBytes(238, 51, 255), love.math.colorFromBytes(255, 132, 60),
             love.math.colorFromBytes(255, 222, 56)}
}

function Cell:new(enemy, health, ownerPlayer, position)
    self.id = love.math.random(10000000, 90000000)
    self.health = health
    -- if enemy == true then
    --     self.color = Colors.ENEMY[enemy]
    -- else
    --     self.color = Colors.PLAYER
    -- end
    if not enemy then
        enemy = ""
    end
    self.enemy_idx =enemy
    self.gfx = love.graphics.newImage('assets/cell_' .. tostring(enemy) .. '.png', {})
    self.position = position
    self.owner = ownerPlayer
end

function Cell:isEqual(cell)
    return self.id == cell.id
end

function Cell:connect(enemy_cell, is_origin)
    if self.enemy_idx == enemy_cell.enemy_idx then
        return false
    end
    if enemy_cell == self.owner then
        return false
    end
    self.connected_to = enemy_cell
    self.connected_origin = is_origin
    return true
end

function Cell:update(dt)
end

function Cell:playerTakeover(newPlayer)
    self.player = newPlayer
end

function Cell:draw()
    
    love.graphics.draw(self.gfx, self.position.x-(CELL_IMG_WIDTH/2), self.position.y-((CELL_IMG_HEIGHT/2)))
end

function Cell:draw_connections()
    love.graphics.setLineWidth(2)
    if self.connected_to and self.connected_origin then
        -- print("ELOO")
        -- print(self.connected_to)
        love.graphics.setColor(1,0,0)
        -- print(self.position.x, self.position.y, self.connected_to.position.x, self.connected_to.position.y)
        love.graphics.line(self.position.x, self.position.y, self.connected_to.position.x, self.connected_to.position.y)
        love.graphics.setColor(1,1,1)
    end
end