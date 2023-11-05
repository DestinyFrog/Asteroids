
function love.load()
	math.randomseed(os.time())

	require("util")
	require("data")
	require("obj.asteroid")
	require("obj.bullet")
	require("obj.ship")

	love.graphics.setDefaultFilter("nearest", "nearest")
	local font2 = love.graphics.newFont( "sprites/rainyhearts.ttf", 200 )
	love.graphics.setFont( font2 )

	Player = Ship:new()

	DelayBetweenAsteroids = 40
	AsteroidsCounter = 0
	Asteroids = { Asteroid:new() }

	love.graphics.setLineWidth( 2 )
end

function love.update( dt )
	Player:update()

	AsteroidsCounter = AsteroidsCounter + 1
	if AsteroidsCounter > DelayBetweenAsteroids then
		table.insert( Asteroids, Asteroid:new() )
		AsteroidsCounter = 0
	end

	if love.keyboard.isDown("escape") then
		Player.enable = true
		Player.position.x = MIDDLE.x
		Player.position.y = MIDDLE.y
		Player.Bullets = {}
		POINTS = 0
		Asteroids = {}
	end
end

function love.draw()

	love.graphics.setColor( 1,1,1,0.3 )
	love.graphics.print( ""..POINTS, MIDDLE.x-(200/4), MIDDLE.y-(200/2), 0 )
	love.graphics.setColor( 1,1,1 )

	if Player.enable == true then
		Player:draw()
	end

	for k,v in pairs(Asteroids) do
		if v.enable == true then
			v:draw()
		else
			table.remove( Asteroids, k )
		end
	end
end
