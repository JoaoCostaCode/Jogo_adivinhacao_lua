enter = function(scene, args)
    nome = args
    texto = gui:text(nome .. ", você deseja saber as regras?", {x = love.graphics.getWidth()/2-250.5, y = 285, w = 501})
    button_sim = gui:button('Sim', {x = love.graphics.getWidth()/2-250.5, y = 414, w = 222, h = 40})
    button_nao = gui:button('Não', {x = 494, y = 414, w = 222, h = 40})
end

update = function(scene)
    button_sim.click = function(this)
		set_scene("regras")
	end
    button_nao.click = function(this)
		set_scene("dificuldade")
	end
end

draw = function()
    round_rectangle(love.graphics.getWidth()/2-250.5, 236, 501, 126, 30, {205/255, 116/255, 225/255})
	round_rectangle(love.graphics.getWidth()/2-250.5, 414,222,40,20, {254/255, 234/255, 226/255})
    round_rectangle(494, 414,222,40,20, {254/255, 234/255, 226/255})
    gui:draw()
end

exit = function(scene)
    if texto then gui:rem(texto) end
    if button_sim then gui:rem(button_sim) end
    if button_nao then gui:rem(button_nao) end
end