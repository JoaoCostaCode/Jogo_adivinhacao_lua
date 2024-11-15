default = true

enter = function()
	texto = gui:text("Bem-vindo ao Numistério\n\nPor favor, insira seu nome", {x = love.graphics.getWidth()/2-235, y = love.graphics.getHeight()/2-165, w = 470})
    input_nome = gui:input('', {love.graphics.getWidth()/2-90, love.graphics.getHeight()/2+40, 185, gui.style.unit})
	input_nome:focus()
end

update = function(scene)
    input_nome.done = function(this) -- Gspot calls element:done() when you hit enter while element has focus. override this behaviour with element.done = false
        if this.value and this.value ~= "" then
			set_scene("quer_regras", this.value)
        else
			set_scene("quer_regras", "Viajante")
		end
    end
end

exit = function(scene)
    if texto then gui:rem(texto) end
    if input_nome then gui:rem(input_nome) end
end

draw = function(scene)
	round_rectangle(love.graphics.getWidth()/2-235, love.graphics.getHeight()/2-200, 470, 150, 30, {0.805, 0.416, 0.825})
	round_rectangle(love.graphics.getWidth()/2-125, love.graphics.getHeight()/2,250,100,50, {0.805, 0.416, 0.825})
	gui:draw()
end

love.keypressed = function(key, code, isrepeat)
	gui:keypress(key)
end  

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