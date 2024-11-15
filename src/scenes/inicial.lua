default = true

enter = function()
	texto = gui:text("Bem-vindo ao Numistério\n\nPor favor, digite seu nome", {x = love.graphics.getWidth()/2-250.5, y = love.graphics.getHeight()/2-105, w = 501})
    input_nome = gui:input('', {love.graphics.getWidth()/2-150, 398.5, 300, 45})
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
	round_rectangle(love.graphics.getWidth()/2-250.5, love.graphics.getHeight()/2-127, 501, 126, 30, {205/255, 116/255, 225/255})
	round_rectangle(love.graphics.getWidth()/2-161,396,322,50,25, {205/255, 116/255, 225/255})
	gui:draw()
end

love.keypressed = function(key, code, isrepeat)
	gui:keypress(key)
end  