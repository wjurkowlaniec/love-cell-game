-- for checking if mouse it touching the cell 
function CheckCircularCollision(ax, ay, bx, by, r)
    return math.sqrt(((bx - ax) ^ 2 + (by - ay) ^ 2)) < r
end

MouseClickPosition = {
    x = nil,
    y = nil
}

MousePosition = {
    x = nil,
    y = nil
}

ClickedCell = nil

function love.mousepressed(x, y, button)
    MouseClickPosition.x = x
    MouseClickPosition.y = y

	local touchingCell = getClickedCell(x, y)
    if button == 1 and GPlayer:cellBelongsToPlayer(touchingCell) then
		ClickedCell = touchingCell
        print("Clicked you cell")
        print(ClickedCell)
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    MousePosition.x = x
    MousePosition.y = y
end

function love.mousereleased(x, y, button, istouch, presses)
    local releasedCell = getClickedCell(x, y)
	if ClickedCell  and releasedCell then
		print("Releasing on a cell")
		ClickedCell:connect(releasedCell, true)
	end

    MouseClickPosition.x = nil
    MouseClickPosition.y = nil
    ClickedCell = nil
end

function drawMouse()
    if love.mouse.isDown(1) then
        love.graphics.setColor(0.5, 0, 5, 1)
        love.graphics.line(MouseClickPosition.x, MouseClickPosition.y, MousePosition.x, MousePosition.y)
        love.graphics.setColor(1, 1, 1)
    end
end

function getClickedCell(x, y)
    for i, v in ipairs(GCells) do
        if CheckCircularCollision(x, y, v.position.x, v.position.y, CELL_RADIUS) then
            print(v.position.x, v.position.y, v.enemy_idx)
            print("FOUND CELL ID ", v.id)
            return v
        end
    end
    return nil
end

