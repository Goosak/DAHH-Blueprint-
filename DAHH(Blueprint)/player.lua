player={}
local bump = require "bump"
local items = require "items"

player.init = function(world)
player.x = 30
player.y = 30
player.width = 30
player.height = 30
player.speed = 300
player.speedY = 0
player.ID = "player"
player.lives = 4
player.jump = true
player.goRight = true
player.isAttack = false
player.baseWeapon = items.Sword(player.x+5, player.y+5, 10, 10, world)
player.weapon = player.baseWeapon
world:add(player, player.x, player.y, player.width, player.height)
end

player.draw = function()
	love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
	if player.isAttack then
		player.weapon.draw(player.weapon)
	end
end

local collisionFilter = function(item, other)
	if other.ID == "block" then
		return "slide"
	elseif other.ID == "armor" or other.ID == "mace" then
		return "cross"
	elseif other.ID == "bullet" then
		return "touch"
	elseif other.ID == "enemy" then
		return "bounce"
	end
end

player.update = function(world, dt)
	local dx, dy = 0, 0

	if love.keyboard.isDown('right') then
		dx = player.speed * dt
		player.goRight = true
	elseif love.keyboard.isDown('left') then
		dx = -player.speed * dt
		player.goRight = false
	end
	if love.keyboard.isDown('up') then
		if not player.jump then
			player.jump = true
			player.speedY = 400
		end
	end
	if player.jump then
		dy = -player.speedY * dt
		player.speedY = player.speedY-600*dt
	end
	
	if dx ~= 0 or dy ~= 0 then
		player.x, player.y, cols, cols_len = world:move(player, player.x + dx, player.y + dy, collisionFilter)
		
		if cols_len~=0 then
		player.jump = true
			for _,v in pairs(cols) do
				if v.other.ID == "block" then
					player.jump = false
					player.speedY = 0
				elseif v.other.ID == "armor" then
					print ("lives: "..player.lives)
					player.lives=player.lives+v.other.bonus
					print ("lives: "..player.lives)
					world:remove(v.other)
					v.other.x = -v.other.w-15
					v.other.y = -v.other.h-15
				elseif v.other.ID == "mace" then
					if player.weapon.ID ~= v.other.ID  then
						player.weapon = v.other
					end
				end
			end
		end
	end
  
	if love.keyboard.isDown('rctrl') then
		player.isAttack = true
		if player.goRight then
			player.weapon.x, player.weapon.y, player.weapon.w, player.weapon.h= player.x+player.width, player.y+10, player.weapon.distance, 10
			world:update(player.weapon, player.weapon.x, player.weapon.y, player.weapon.w, player.weapon.h)
		else
			player.weapon.x, player.weapon.y, player.weapon.w, player.weapon.h = player.x-player.weapon.distance, player.y+10, player.weapon.distance, 10
			world:update(player.weapon, player.weapon.x, player.weapon.y, player.weapon.w, player.weapon.h)
		end
	else
		player.weapon.x, player.weapon.y, player.weapon.w, player.weapon.h = player.x+5, player.y+5, 10, 10
		world:update(player.weapon, player.weapon.x, player.weapon.y, player.weapon.w, player.weapon.h)
	end
end

return player