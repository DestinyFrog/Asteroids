
Asteroid = {}

function Asteroid:new()
	local obj = {}

	obj.enable = true
	obj.sprite = love.graphics.newImage( "sprites/asteroid_"..math.random( ASTEROIDS_SPRITES_RANGE )..".png" )
	obj.speed = math.random( 1.0, 7.0 )/10
	obj.radius = math.random( 5, 10 )
	obj.size = ( 1 / (obj.sprite:getWidth()/2) ) * obj.radius
	obj.targetAngle = math.random( 360 )

	local angle = math.random( 360 )
	local distance = ScreenDiagonal
	obj.position = Vec2(
		MIDDLE.x + ( math.cos( ToRadians( angle ) ) * distance ),
		MIDDLE.y + ( math.sin( ToRadians( angle ) ) * distance ) )

	obj.velocity = Vec2(
		-1 * math.cos( ToRadians( angle ) ),
		-1 * math.sin( ToRadians( angle ) ) )

	setmetatable( obj, self )
	self.__index = self
	return obj
end

function Asteroid:draw()
	self.position.x = self.position.x + (self.velocity.x * self.speed)
	self.position.y = self.position.y + (self.velocity.y * self.speed)

	if DistanceFromMiddle( self.position ) > ScreenDiagonal then
		self.enable = false
	end

	-- love.graphics.setColor( 1, 0, 0 )
	-- love.graphics.circle("line",self.position.x, self.position.y, self.radius)
	-- love.graphics.setColor( 1, 1, 1 )

	love.graphics.draw( self.sprite,
		self.position.x-self.radius, self.position.y-self.radius,
		0,
		self.size, self.size )
end