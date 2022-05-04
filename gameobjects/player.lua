Object = require "lib/classic"

Player = Object:extend()

function Player:new(isEnemy)
    self.id = love.math.random(100, 900)
    self.isEnemy = isEnemy
    self.cells = {}
end

function Player:attachCell(cell)
    self.cells[#self.cells+1] = cell
    print(#self.cells)
end

function Player:cellBelongsToPlayer(cell)
    if not cell then
        return false
    end
    print("Player", self.id, " Cell COUNT ", #self.cells)
    for i, v in ipairs(self.cells) do
        print(v.id, cell.id)
        if v:isEqual(cell) then
            return true
        end
    end
    return false
end

function Player:isDead()
    if #self.cells == 0 then
        return true
    end
    return false
end

function Player:removeCell(cell)
    -- TODO
end
