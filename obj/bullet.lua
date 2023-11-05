
Bullet = {}

function Bullet:new( position, velocity )
	local obj = {}

	self.enable = true
	obj.velocity = velocity or Vec2( 0, 0 )
	obj.position = position or MIDDLE
	obj.radius = 2
	obj.speed = 4

	setmetatable( obj, self )
	self.__index = self
	return obj
end

function Bullet:draw()
	for k,v in ipairs(Asteroids) do
		if DistanceBetweenPoints( self.position, v.position ) < self.radius + v.radius then
			POINTS = POINTS + 1
			v.enable = false
			self.enable = false
		end
	end

	self.position.x = self.position.x + (self.velocity.x * self.speed)
	self.position.y = self.position.y + (self.velocity.y * self.speed)

	if
	self.position.x > WIDTH or
	self.position.x < 0 or
	self.position.y > HEIGHT or
	self.position.y < 0 then
		self.enable = false
		return
	end

	love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end
