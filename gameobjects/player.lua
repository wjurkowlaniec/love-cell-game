Object = require "lib/classic"

Player = Object:extend()


function Player:new(isEnemy)
    local isEnemy = isEnemy
    local cells= {}
end

function Player:attachCell(cell)
    cells.insert(cell)
end

function Player:isDead()
    if #cells == 0 then
        return true
    end
    return false
end

function Player:removeCell(cell)
    
end