player={}
local bump = require "bump"

player.init = function()
player.x = 30
player.y = 30
player.width = 30
player.height = 30
player.speed = 300
player.speedY = 0
player.ID = "player"
player.jump = true
end

player.draw = function()
love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

player.update = function(world, dt)
	local dx, dy = 0, 0

	if love.keyboard.isDown('right') then
		dx = player.speed * dt
	elseif love.keyboard.isDown('left') then
		dx = -player.speed * dt
	end
	--if love.keyboard.isDown('down') then
		--dy = player.speed * dt
	--elseif love.keyboard.isDown('up') then
		--dy = -player.speed * dt
	--end
	
	if love.keyboard.isDown('up') then
		if not player.jump then
			player.jump = true
			player.speedY = 300
		end
	end

	if player.jump then
		dy = -player.speedY * dt
		player.speedY = player.speedY-600*dt
	end
	
	if dx ~= 0 or dy ~= 0 then
		player.x, player.y, cols, cols_len = world:move(player, player.x + dx, player.y + dy)
		if cols_len~=0 then
			for _,v in pairs(cols) do
				if v.other.ID == "block" then
					player.jump = false
					player.speedY = 0
				end
			end
		else
			player.jump = true
		end
	end
  
	
end

return player