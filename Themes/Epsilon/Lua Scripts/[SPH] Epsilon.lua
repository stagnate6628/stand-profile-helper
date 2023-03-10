require('ProfileHelperLib')

local header_path = filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Epsilon\\Header.bmp'
local footer_path = filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Epsilon\\Footer.bmp'
local subheader_path = filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Epsilon\\Subheader.bmp'

local interaction_header_path = function(i)
		return filesystem.resources_dir() .. 'ProfileHelper\\Themes\\Epsilon\\Interaction Header\\Header' .. i .. '.bmp'
end

if not io.exists(header_path) then
		util.toast('[SPH] Header not found, attempting download.')
		lib:download_file('Themes/Epsilon/Header.bmp', {header_path})
end

for i = 1, 18 do
		if not io.exists(interaction_header_path(i)) then
				util.toast('[SPH] Downloaded globe header ' .. i .. '/18')
				lib:download_file('Themes/Epsilon/Interaction Header/Header' .. i .. '.bmp', {interaction_header_path(i)})
		end
end

if not io.exists(footer_path) then
		util.toast('[SPH] Footer not found, attempting download.')
		download_file('Themes/Epsilon/Footer.bmp', {footer_path})
end

if not io.exists(subheader_path) then
		util.toast('[SPH] Subheader not found, attempting download.')
		lib:download_file('Themes/Epsilon/Subheader.bmp', {subheader_path})
end

local header = directx.create_texture(header_path)
local footer = directx.create_texture(footer_path)
local subheader = directx.create_texture(subheader_path)
local globe = directx.create_texture(interaction_header_path(1))

util.create_tick_handler(function()
		if not menu.is_open() then
				return false
		end

		for i = 1, 18 do
				util.yield(50)
				globe = directx.create_texture(interaction_header_path(i))
		end

		util.yield(8 * 1000)
end)

while true do
		if menu.is_open() then
				local x, y, w, h = menu.get_main_view_position_and_size()
				directx.draw_texture(globe, 1, w / 1080 + 0.04984, 0, 0, x, y - 130 / 1080, 0, 1, 1, 1, 1)
				directx.draw_texture(header, 1, w / 1080 + 0.04984, 0, 0, x, y - 130 / 1080, 0, 1, 1, 1, 1)
				directx.draw_texture(subheader, 1, w / 1080 + 0.01274, 0, 0, x, y - 28 / 1080, 0, 1, 1, 1, 1)
				directx.draw_texture(footer, 1, w / 1080 + 0.01368, 0, 0, x, y + h - (1 / 1080) + 0.0013, 0, 1, 1, 1, 1)
		end
		util.yield()
end

util.keep_running()
