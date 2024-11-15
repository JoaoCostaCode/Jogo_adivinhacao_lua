enter = function(scene, args)
    texto = gui:text(args .. ", você deseja saber as regras?", {y = 32, w = 400})
    button_sim = gui:button('Sim', {x = 20, y = 300, w = 128, h = gui.style.unit})
    button_nao = gui:button('Não', {x = 128, y = 300, w = 128, h = gui.style.unit})
end

update = function(scene)
    button_sim.click = function(this)
		set_scene("regras")
	end
    button_nao.click = function(this)
		set_scene("dificuldade")
	end
end

exit = function(scene)
    gui:rem(texto)
    gui:rem(button_sim)
    gui:rem(button_nao)
end