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
end

function _update()
	if rnd() <= 0.15 then
		-- x, y, speed, sway speed
		add(snowflakes, vec(
			flr(rnd(128)), -- x
			0,             -- y
			rnd(1.5) + .5, -- speed
			rnd()          -- sway speed
		))
	end

	for s in all(snowflakes) do
		local x, y, speed, sway = s:get(0, 4)

		--- @cast s userdata
		s:set(0, x + sway * math.cos(t() * sway / 2), y + speed)

		-- delete snowflakes that fall offscreen
		if y + speed > 128 then
			del(snowflakes, s)
		end
	end
end

function _draw()
	cls()

	for s in all(snowflakes) do
		--- @cast s userdata
		local x, y = s:get(0, 2)

		pset(x, y, 7)
	end
end
