require('ProfileHelperLib')

local header_path = filesystem.resources_dir() .. "ProfileHelper\\Themes\\XCheats\\Header.bmp"
local subheader_path = filesystem.resources_dir() .. "ProfileHelper\\Themes\\XCheats\\Subheader.bmp"
local footer_path = filesystem.resources_dir() .. "ProfileHelper\\Themes\\XCheats\\Footer.bmp"

if not io.exists(header_path) then
    util.toast("[SPH] Header not found, attempting download.")
    lib:download_file("Themes/XCheats/Header.bmp", {header_path})
end

if not io.exists(footer_path) then
    util.toast("[SPH] Footer not found, attempting download.")
    lib:download_file("Themes/XCheats/Footer.bmp", {footer_path})
end

if not io.exists(subheader_path) then
    util.toast("[SPH] Footer not found, attempting download.")
    lib:download_file("Themes/XCheats/Subheader.bmp", {subheader_path})
end

local header = directx.create_texture(header_path)
local footer = directx.create_texture(footer_path)
local subheader = directx.create_texture(subheader_path)

while true do
    if menu.is_open() then
        local x, y, w, h = menu.get_main_view_position_and_size()
        directx.draw_texture(header, 1, w / 1080 + 0.039293, 0, 0, x - 0.0018, y - 115 / 1080, 0, 1, 1, 1, 1)
        directx.draw_texture(subheader, 1, w / 1080 + 0.01377, 0, 0, x - 0.00177, y - 30 / 1080, 0, 1, 1, 1, 1)
        directx.draw_texture(footer, 1, w / 1080 + 0.01372, 0, 0, x - 0.00109, y + h - 1 / 1080 + 0.0004, 0, 1, 1, 1, 1)

        directx.draw_rect(x - 3 / 1920, y, 3 / 1920, h + 0.027, 0, 0, 0, 1)
        directx.draw_rect(x + w, y, 3 / 1920, h, 0, 0, 0, 1)
    end
    util.yield()
end

util.keep_running()