local bump = require "bump"
local player = require "player"
local items = require "items"

local world = bump.newWorld()

local block = {ID = "block", x = 0, y = 400, w = 1000, h = 100}
local block2 = {ID = "block", x = 500, y = 300, w = 100, h = 100}

local function drawBox(box, r,g,b)
  love.graphics.setColor(r,g,b,70)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end

function love.load()
armor = items.Armor(400, 380, 10, 10, world)
mace = items.Mace(300, 380, 10, 10, world)
player.init(world)
world:add(block, block.x, block.y, block.w, block.h)
world:add(block2, block2.x, block2.y, block2.w, block2.h)
end

function love.draw()
player.draw()
armor.draw(armor)
mace.draw(mace)
drawBox(block, 0, 255, 0)
drawBox(block2, 0, 255, 0)
end

function love.update(dt)
player.update(world, dt)
end