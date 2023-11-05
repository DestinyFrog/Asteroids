
function Vec2( x, y )
	return { x = x, y = y or x }
end

function SquareDiagonal( a, b )
	if a > b then
		return a * math.sqrt( 2 )
	else
		return b * math.sqrt( 2 )
	end
end

function ToRadians( a )
	return a * ( math.pi/180 )
end

function DistanceFromMiddle( position )
	return math.sqrt( math.pow( position.x - MIDDLE.x, 2 ) + math.pow( position.y - MIDDLE.y, 2 ) )
end

function DistanceBetweenPoints( pos1, pos2 )
	return math.sqrt( math.pow( pos1.x - pos2.x, 2 ) + math.pow( pos1.y - pos2.y, 2 ) )
end