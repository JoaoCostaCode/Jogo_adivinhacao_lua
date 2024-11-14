default = true

nome = nil

enter = function()
    texto = gui:text("Bem-vindo ao Numistério\n\nPor favor, insira seu nome", {y = 32, w = 256})
    input_nome = gui:input('Nome', {64, love.graphics.getHeight() - 400, 512, gui.style.unit})
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

exit = function(scene)
    gui:rem(texto)
    gui:rem(input_nome)
    gui:rem(button)
    gui:rem(button)
end

