require('ProfileHelperLib')

local header_path = filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Impulse\\Header1.bmp'
local footer_path = filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Impulse\\Footer.bmp'
local subheader_path = filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Impulse\\Subheader.bmp'

local function get_header_path(i)
		return filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Impulse\\Header' .. i .. '.bmp'
end

if not io.exists(header_path) then
		util.toast('[SPH] Headers not found, attempting download.')
		lib:download_file('Themes/Impulse/Header1.bmp', {filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Impulse\\Header1.bmp'},
		                  function()
				local exists = true
				local i = 2
				while exists do
						util.yield(100)
						lib:download_file('Themes/Impulse/Header' .. i .. '.bmp',
						                  {filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Impulse\\Header1.bmp'}, function()
								util.toast('[SPH] Downloaded header ' .. i)
						end, nil, function()
								exists = false
						end)
						i = i + 1
				end
		end)
end

if not io.exists(footer_path) then
		util.toast('[SPH] Footer not found, attempting download.')
		lib:download_file('Themes/Impulse/Footer.bmp', {footer_path})
end

if not io.exists(subheader_path) then
		util.toast('[SPH] Subheader not found, attempting download.')
		lib:download_file('Themes/Impulse/Subheader.bmp', {subheader_path})
end

local header = directx.create_texture(header_path)
local footer = directx.create_texture(footer_path)
local subheader = directx.create_texture(subheader_path)

util.create_tick_handler(function()
		if not menu.is_open() then
				return false
		end

		for i = 1, 50 do
				util.yield(50)
				header = directx.create_texture(get_header_path(i))
				util.yield()
		end

		util.yield(1000)
end)

while true do
		if menu.is_open() then
				local x, y, w, h = menu.get_main_view_position_and_size()
				directx.draw_texture(header, 1, (w / 1080) + 0.05115, 0, 0, x, y - 146 / 1080, 0, 1, 1, 1, 1)
				directx.draw_texture(subheader, 1, (w / 1080) + 0.016, 0, 0, x, (y - 35 / 1080), 0, 1, 1, 1, 1)
				directx.draw_texture(footer, 1, (w / 1080) + 0.0169, 0, 0, x, (y + h - (1 / 1080)), 0, 1, 1, 1, 1)

		end
		util.yield()
end

util.keep_running()
