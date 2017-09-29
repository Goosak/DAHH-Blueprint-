local bump = require "bump"
local world = bump.newWorld()
local player = require "player"
local block = {ID = "block", x = 0, y = 400, w = 100, h = 100}
local function drawBox(box, r,g,b)
  love.graphics.setColor(r,g,b,70)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end

function love.load()
player.init()
world:add(player, player.x, player.y, player.width, player.height)
world:add(block, block.x, block.y, block.w, block.h)
end

function love.draw()
player.draw()
drawBox(block, 0, 255, 0)
end

function love.update(dt)
player.update(world, dt)
end