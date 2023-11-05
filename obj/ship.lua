
Ship = {}

function Ship:new()
	local obj = {}
	setmetatable( obj, self )
	self.__index = self

	self.enable = true
	self.sprite = love.graphics.newImage( "sprites/ship.png" )
	self.position = MIDDLE
	self.velocity = Vec2( 0, 0 )
	self.angle = 0
	self.speed = 1
	self.rotateSpeed = 4
	self.radius = self.sprite:getWidth()
	self.Bullets = {}
	self.stopPressSpace = true

	return obj
end

function Ship:update()
	for k,v in ipairs(Asteroids) do
		if DistanceBetweenPoints( self.position, v.position ) < self.radius + v.radius then
			self.enable = false
		end
	end

	if love.keyboard.isDown('space') then
		if self.stopPressSpace == true and BULLETS > 0 then
			BULLETS = BULLETS - 1

			local front = self.angle - 90
			local direction = Vec2(
				math.cos( ToRadians( front ) ),
				math.sin( ToRadians( front ) ) )

			local bullet = Bullet:new( Vec2( self.position.x, self.position.y ), direction )
			table.insert( self.Bullets, bullet )
		end

		self.stopPressSpace = false
	else
		self.stopPressSpace = true
	end

	self.velocity.x = 0
	self.velocity.y = 0

	if love.keyboard.isDown('w') then
		local front = self.angle - 90
		self.velocity.x = math.cos( ToRadians( front ) )
		self.velocity.y = math.sin( ToRadians( front ) )
	end

	if love.keyboard.isDown('a') then self.angle = self.angle - self.rotateSpeed end
	if love.keyboard.isDown('d') then self.angle = self.angle + self.rotateSpeed end

	self.position.x = self.position.x + (self.velocity.x * self.speed)
	self.position.y = self.position.y + (self.velocity.y * self.speed)
end

function Ship:draw()
	for k,v in ipairs(self.Bullets) do
		if v.enable == true then
			v:draw()
		else
			table.remove( self.Bullets, k )
		end
	end

	love.graphics.draw( self.sprite,
		self.position.x, self.position.y,
		ToRadians(self.angle),
		1, 1,
		self.sprite:getWidth()/2, self.sprite:getHeight()/2 )
end
