enter = function(scene)
    texto_dificuldade = gui:text("Escolha seu modo de jogo, viajante:", {x = love.graphics.getWidth()/2-250.5, y = 140, w = 501})
    button_facil = gui:button('Fácil', {x = love.graphics.getWidth()/2-111, y = 300, w = 222, h = 60})
    button_medio = gui:button('Médio', {x = love.graphics.getWidth()/2-111, y = 400, w = 222, h = 60})
    button_dificil = gui:button('Difícil', {x = love.graphics.getWidth()/2-111, y = 500, w = 222, h = 60})
end

update = function(scene)
    diff = {}
    diff.nivel = 1
    diff.pontos = 100
    button_facil.click = function(this)
        diff.dificuldade = 1
        set_scene("jogo", diff)
	end
    button_medio.click = function(this)
        diff.dificuldade = 2
        set_scene("jogo", diff)
	end
    button_dificil.click = function(this)
        diff.dificuldade = 3
        set_scene("jogo", diff)
	end
end

draw = function()
    round_rectangle(love.graphics.getWidth()/2-250.5, 90, 501, 126, 30, {205/255, 116/255, 225/255})
    round_rectangle(love.graphics.getWidth()/2-111, 300,222,60,30, {254/255, 234/255, 226/255})
    round_rectangle(love.graphics.getWidth()/2-111, 400,222,60,30, {254/255, 234/255, 226/255})
    round_rectangle(love.graphics.getWidth()/2-111, 500,222,60,30, {254/255, 234/255, 226/255})
    gui:draw()
end

exit = function(scene)
    if texto_dificuldade then gui:rem(texto_dificuldade) end
    if button_facil then gui:rem(button_facil) end
    if button_medio then gui:rem(button_medio) end
    if button_dificil then gui:rem(button_dificil) end
end