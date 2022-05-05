require "lib/utils"
Object = require "lib/classic"

Cell = Object:extend()


function Cell:new(enemy, health, ownerPlayer, position)
    self.id = love.math.random(10000000, 90000000)
    self.health = health
    self.maxHealth = 100
    self.connectionSlotCount = 2 -- TODO
    if not enemy then
        enemy = ""
    end
    self.enemyIdx = enemy
    self.gfx = love.graphics.newImage('assets/cell_' .. tostring(enemy) .. '.png', {})
    self.position = position
    self.owner = ownerPlayer
end

function Cell:isEqual(cell)
    return self.id == cell.id
end

function Cell:connect(enemy_cell, is_origin)
    if self.enemyIdx == enemy_cell.enemyIdx then
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
    if self.health <= self.maxHealth then
        self.health = self.health + 1
    end
end

function Cell:playerTakeover(newPlayer)
    self.player = newPlayer
end

function Cell:getHealthPosition()
    -- TODO correct positions, it's good enough for now
    local x = self.position.x - love.graphics.getFont():getWidth(self.health)/2
    local y = self.position.y  - love.graphics.getFont():getHeight()/2
    return x, y
end

function Cell:draw()
    -- love.graphics.setColor(unpack(TextInsideCellColor))
    love.graphics.draw(self.gfx, self.position.x - (CELL_IMG_WIDTH / 2), self.position.y - ((CELL_IMG_HEIGHT / 2)))
    love.graphics.setColor(unpack(TextInsideCellColor))
    text_x, text_y = self:getHealthPosition()
    love.graphics.print(self.health, text_x, text_y, 0, 1.5)
    love.graphics.setColor(unpack(DefaultColor))

end

function Cell:getConnectionLine()
    if self.connected_to and self.connected_origin then
        return self.position.x, self.position.y, self.connected_to.position.x, self.connected_to.position.y
    end
end

function Cell:draw_connections()
    love.graphics.setLineWidth(2)
    if self.connected_to and self.connected_origin then
        -- print("ELOO")
        -- print(self.connected_to)
        love.graphics.setColor(unpack(PlayerLineColor))
        local startX, startY, endX, endY = self:getConnectionLine()
        love.graphics.line(startX, startY, endX, endY)
        love.graphics.setColor(unpack(DefaultColor))
    end
end
