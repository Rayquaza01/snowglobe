--[[pod_format="raw",created="2024-03-15 13:58:36",modified="2024-11-04 01:27:25",revision=31]]
-- name of cart v1.0
-- by Arnaught

function _init()
	window({
		width = 64, height = 64
	})

	--- @type userdata[]
	snowflakes = {}
end

function _update()
	if rnd() <= 0.2 then
		add(snowflakes, vec(flr(rnd(64)), 0))
	end

	for s in all(snowflakes) do
		local x, y = s:get(0, 2)

		--- @cast s userdata
		s:set(1, y + 1)
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
