default = true

nome = nil

enter = function()
    texto = gui:text("Bem-vindo ao Numistério\n\nPor favor, insira seu nome", {x = love.graphics.getWidth()/3, y = love.graphics.getHeight()/4, w = 256})
    input_nome = gui:input('Nome', {love.graphics.getWidth()/4, love.graphics.getHeight()/2, 400, gui.style.unit})
	input_nome.keyrepeat = true -- this is the default anyway
	button = gui:button('Enter', {input_nome.pos.w + gui.style.unit, 0, 64, gui.style.unit}, input_nome) -- attach a button
end

update = function(scene)
    input_nome.done = function(this) -- Gspot calls element:done() when you hit enter while element has focus. override this behaviour with element.done = false
        if this.value ~= "" then nome = this.value
        else nome = "Viajante" end
    end
    button.click = function(this)
        this.parent:done()
		set_scene("quer_regras", nome)
	end
end

draw = function(scene)
    --[[local x, y = 0, 0
	local width, height = 100, 100
	local border_width = 10
	local border_radius = 10

	-- draw the box
	--love.graphics.setColor({127,127,127})
	love.graphics.rectangle( "fill", x, y, width, height, border_radius, border_radius)

	-- draw the borders
	love.graphics.setLineWidth(border_width)
	--love.graphics.setColor({255, 0, 0})
	love.graphics.rectangle( "line", x, y, width, height, border_radius, border_radius)]]
end

exit = function(scene)
    gui:rem(texto)
    gui:rem(input_nome)
    gui:rem(button)
    gui:rem(button)
end

