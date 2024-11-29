-- Original author: https://github.com/trubblegum
-- This is a modified version of https://github.com/trubblegum/Gspot/blob/cf0a49d7d2073686d7ddb32a4fa04e90593d36c4/main.lua
-- The original program did not include a copyright notice.
-- Modifications © Copyright 2015-2016, 2018, 2021 Pedro Gimeno Fortea.
--
-- This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.
-- Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
-- 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
-- 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.

if love._version_major == 0 and love._version_minor < 9 then
	--verifica a versão de LÖVE sendo usada.
	error("This library needs love2d 0.9.0 or above")
end

gui = require('Gspot') -- import the library

--fonte padrão para ser usada
font = love.graphics.newFont(192)

love.load = function()
	--importa o módulo YAS para gerenciar scenes
	yas = require "yas" "scenes"
	--inicializa a fonte
	love.graphics.setFont(font)
	--importa a imagem de background
	background = love.graphics.newImage("resources/bg.png")
end

love.update = function(dt)
	--manda updates da interface para o gerenciador de interface GSpöt
	gui:update(dt)
end

love.draw = function()
	--exibe a imagem de background
	love.graphics.draw(background) 
	-- exibe a interface
	gui:draw()
end

love.textinput = function(key)
	gui:textinput(key) -- only sending input to the gui if we're not using it for something else
end

-- deal with 0.10 mouse API changes
love.mousepressed = function(x, y, button)
	gui:mousepress(x, y, button) -- pretty sure you want to register mouse events
end
love.mousereleased = function(x, y, button)
	gui:mouserelease(x, y, button)
end
love.wheelmoved = function(x, y)
	gui:mousewheel(x, y)
end

--gera retângulos com as bordas redondas
function round_rectangle(x, y, width, height, radius, color)
	love.graphics.setColor(color)
	--RECTANGLES
	love.graphics.rectangle("fill", x + radius, y + radius, width - (radius * 2), height - radius * 2)
	love.graphics.rectangle("fill", x + radius, y, width - (radius * 2), radius)
	love.graphics.rectangle("fill", x + radius, y + height - radius, width - (radius * 2), radius)
	love.graphics.rectangle("fill", x, y + radius, radius, height - (radius * 2))
	love.graphics.rectangle("fill", x + (width - radius), y + radius, radius, height - (radius * 2))
	
	--ARCS
	love.graphics.arc("fill", x + radius, y + radius, radius, math.rad(-180), math.rad(-90))
	love.graphics.arc("fill", x + width - radius , y + radius, radius, math.rad(-90), math.rad(0))
	love.graphics.arc("fill", x + radius, y + height - radius, radius, math.rad(-180), math.rad(-270))
	love.graphics.arc("fill", x + width - radius , y + height - radius, radius, math.rad(0), math.rad(90))
	love.graphics.setColor(1,1,1)
end