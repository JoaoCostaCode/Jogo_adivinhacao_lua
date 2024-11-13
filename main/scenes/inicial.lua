default = true

nome = ""

enter = function()
    texto = gui:text("Bem-vindo ao Numistério\n\nPor favor, insira seu nome", {y = 32, w = 1280})
    input = gui:input('Nome', {64, love.graphics.getHeight() - 32, 256, gui.style.unit})
	input.keyrepeat = true -- this is the default anyway
	button = gui:button('Ver regras', {input.pos.w + gui.style.unit, 0, 64, gui.style.unit}, input) -- attach a button
	
end

update = function(scene)
    input.done = function(this) -- Gspot calls element:done() when you hit enter while element has focus. override this behaviour with element.done = false
        nome = this.value
	end
    button.click = function(this)
        this.parent:done()
		set_scene("quer_regras", nome)
	end
end

exit = function(scene)
    gui:rem(texto)
    gui:rem(input)
    gui:rem(button)
    gui:rem(button)
end