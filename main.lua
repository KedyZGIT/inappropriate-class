function love.load()
xp = 0
yp = 0
	tileSize = 16 -- for image 16x16 pixels
	a = {image = love.graphics.newImage("air.png")} -- image 32x32 pixels
	g = {image = love.graphics.newImage("ground.png")} -- image 32x32 pixels
	gg = {image = love.graphics.newImage("groundgrass.png")} -- image 32x32 pixels
                        player = love.graphics.newImage("player.png")
	local seedX = love.math.random(1024)
	local seedY = love.math.random(1024)

	local w, h = 200, 200
	map = {}
	for y = 1, h do
		map[y] = {}
		for x = 1, w do
			local value = love.math.noise( 0.04*x+seedX, 0.14*y+seedY)
			if value > 0.8 then -- 80% air and 20% ground
				if map[y-1] and map[y-1][x] and map[y-1][x] == a then
					-- one tile above was an air
					map[y][x] = gg -- ground grass
				else
					map[y][x] = g -- ground
				end
			else
				map[y][x] = a -- air
			end
		end
	end
end

function love.update()
if love.keyboard.isDown("a") then
xp = xp + 16

elseif love.keyboard.isDown("d") then
xp = xp - 16

elseif love.keyboard.isDown("w") then
yp = yp + 16

elseif love.keyboard.isDown("s") then
yp = yp - 16


         end
end

function love.draw()
	local scale = 1
	for y, xs in ipairs (map) do
		for x, tile in ipairs (xs) do
			love.graphics.draw(tile.image, (x-1)*tileSize*scale + xp, (y-1)*tileSize*scale + yp, 0, scale, scale) -- terrain generator
		end
	end
love.graphics.draw(player ,0 ,0) -- put sprites here or your CPU will die
end
