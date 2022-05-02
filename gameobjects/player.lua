Object = require "lib/classic"

Player = Object:extend()


function Player:new(isEnemy)
    self.isEnemy = isEnemy
    self.cells= {}
end

function Player:attachCell(cell)
    self.cells.insert(cell)
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