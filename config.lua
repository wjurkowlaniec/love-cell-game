require "lib/utils"
-- Backwards compatibility
table.pack = function(...) return { n = select("#", ...), ... } end
table.unpack = unpack


FRAME_TIME = 1 / 60
WINDOW_WIDTH = 900
WINDOW_HEIGHT = 700

CELL_IMG_WIDTH, CELL_IMG_HEIGHT = 150, 150

CELL_RADIUS = CELL_IMG_WIDTH / 2

CELL_SPAWN_BORDER_X = WINDOW_WIDTH / 10
CELL_SPAWN_BORDER_Y = WINDOW_HEIGHT / 10

-- cell generation boundaries
BoundaryLeft = CELL_SPAWN_BORDER_X + CELL_IMG_WIDTH / 2
BoundaryRight = WINDOW_WIDTH - CELL_SPAWN_BORDER_X - CELL_IMG_WIDTH / 2
BoundaryTop = CELL_SPAWN_BORDER_Y + CELL_IMG_HEIGHT / 2
BoundaryBottom = WINDOW_HEIGHT - CELL_SPAWN_BORDER_Y - CELL_IMG_HEIGHT / 2

BgColor = {}
BgColor.R, BgColor.G, BgColor.B = getColorFromHex("#3e4453")

TextInsideCellColor = table.pack(getColorFromHex("#000000"))

DefaultColor = table.pack(getColorFromHex("#FFFFFF"))

Enemy1LineColor = table.pack(getColorFromHex("#ff0004"))
PlayerLineColor = table.pack(getColorFromHex("#00fb00"))
