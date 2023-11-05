
function love.load()
	math.randomseed(os.time())
	for i = 1, 10, 1 do math.random() end

	require("util")
	require("data")
	require("obj.asteroid")
	require("obj.bullet")
	require("obj.ship")

	Player = Ship:new()

	DelayBetweenAsteroids = 40
	AsteroidsCounter = 0
	Asteroids = { Asteroid:new() }

	love.graphics.setLineWidth( 4 )
end

function love.update( dt )
	Player:update()

	AsteroidsCounter = AsteroidsCounter + 1
	if AsteroidsCounter > DelayBetweenAsteroids then
		table.insert( Asteroids, Asteroid:new() )
		AsteroidsCounter = 0
	end
end

function love.draw()
	love.graphics.print( "points: "..POINTS, 2, 2 )
	love.graphics.print( "shots: "..BULLETS, 2, 14 )

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
