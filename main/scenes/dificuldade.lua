enter = function(scene)
    texto = gui:text("Viajante, escolha seu modo de jogo:", {y = 20, w = 256})
    button_facil = gui:button('Fácil', {x = 20, y = 300, w = 128, h = gui.style.unit})
    button_medio = gui:button('Médio', {x = 20, y = 400, w = 128, h = gui.style.unit})
    button_dificil = gui:button('Difícil', {x = 20, y = 500, w = 128, h = gui.style.unit})
end

update = function(scene)
    button_facil.click = function(this)
		set_scene("jogo", 1)
	end
    button_medio.click = function(this)
		set_scene("jogo", 2)
	end
    button_dificil.click = function(this)
		set_scene("jogo", 3)
	end
end

exit = function(scene)
    gui:rem(texto)
    gui:rem(button_facil)
    gui:rem(button_medio)
    gui:rem(button_dificil)
end