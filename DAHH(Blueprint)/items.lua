items = {}
class = require "middleclass"

GeneralActions ={
	draw=function(self)
		love.graphics.setColor(0, 0, 255)
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		love.graphics.setColor(0, 255, 0)
	end
}

items.Armor = class("Armor")
function items.Armor:initialize(x, y, w, h, world)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.bonus = 5
	self.ID="armor"
	world:add(self, x, y, w, h)
end 
items.Armor:include(GeneralActions)

items.Sword = class("Sword")
function items.Sword:initialize(x, y, w, h, world)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.damage = 1
	self.ID = "sword"
	self.distance = 10
	world:add(self, x, y, w, h)
end
items.Sword:include(GeneralActions)

items.Mace = class("Mace")
function items.Mace:initialize(x, y, w, h, world)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.damage = 2
	self.ID = "mace"
	self.distance = 40
	world:add(self, x, y, w, h)
end
items.Mace:include(GeneralActions)



return items