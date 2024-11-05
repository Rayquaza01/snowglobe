--[[pod_format="raw",created="2024-03-15 13:58:36",modified="2024-11-04 01:27:25",revision=31]]
-- snowglobe v1.0
-- by Arnaught

include("pph.lua")

function _init()
	info("snowglobe start")

	window({
		width = 128, height = 128,
		title = "Snowglobe"
	})

	--- @type userdata[]
	snowflakes = {}

	min_spawn_rate = 0
	spawn_rate_delta = 0.01
	spawn_rate = 0

	--- @type userdata[]
	smoke = {}
	smoke_spawn_rate = 0.15

	prev_x = nil
	prev_y = nil
	on_event("move", function(msg)
		if not prev_x then
			prev_x = msg.x
			prev_y = msg.y
		end

		local delta = math.abs(msg.x - prev_x) + math.abs(msg.y - prev_y)
		spawn_rate += delta * spawn_rate_delta * 0.01
		if spawn_rate > 5 then
			spawn_rate = 1
		end

		prev_x = msg.x
		prev_y = msg.y
	end)
end

function _update()
	local mx, my, mb, mwx, mwy = mouse()
	spawn_rate += mwy * spawn_rate_delta

	if spawn_rate > min_spawn_rate then
		spawn_rate -= spawn_rate_delta * 1/30
	end

	-- info("Spawn rate: " ..spawn_rate)

	if rnd() <= spawn_rate then
		-- x, y, speed, sway speed
		add(snowflakes, vec(
			flr(rnd(128)), -- x
			0,             -- y
			rnd(1.5) + .5, -- speed
			rnd(.5) + 1    -- sway speed
		))
	end

	if rnd() < smoke_spawn_rate then
		add(smoke, vec(
			flr(rnd(3)) + 98, -- x
			39,               -- y
			rnd(.5) + .5,    -- speed
			rnd(.5) + 1       -- sway speed
		))
	end

	for s in all(snowflakes) do
		local x, y, speed, sway = s:get(0, 4)

		--- @cast s userdata
		s:set(0, x + math.cos(t() * sway / 5) / 2, y + speed)

		-- delete snowflakes that fall offscreen
		if y + speed > 128 then
			del(snowflakes, s)
		end
	end

	for s in all(smoke) do
		local x, y, speed, sway = s:get(0, 4)

		--@cast s userdata
		s:set(0, x + math.cos(t() * sway) / 5, y - speed)

		if y < 0 then
			del(smoke, s)
		end
	end
end

function _draw()
	cls()
	spr(1)

	for s in all(snowflakes) do
		--- @cast s userdata
		local x, y = s:get(0, 2)

		pset(x, y, 7)
	end

	for s in all(smoke) do
		--- @cast s userdata
		local x, y = s:get(0, 2)

		pset(x, y, rnd({7, 6, 5, 22, 21}))
	end
end
