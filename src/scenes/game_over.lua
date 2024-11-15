enter = function(scene, args)
    if args.perdeu then
        texto_finalizar = gui:text("Poxa, parece que o jogo terminou para você, viajante\n\nVocê chegou ao nivel " .. args.nivel, {x = love.graphics.getWidth()/2-250.5, y = 245, w = 501, h = 135})
    else
        texto_finalizar = gui:text("Voce finalizou o jogo no nivel " .. args.nivel .. " com " .. args.pontos .. " pontos. Parabéns, viajante!\n\nJogo finalizado. Até a próxima!", {x = love.graphics.getWidth()/2-250.5, y = 235, w = 501, h = 135})
    end
    button_recomecar = gui:button('Jogar Novamente', {x = love.graphics.getWidth()/2-111, y = 400, w = 222, h = 40})
end

update = function(scene)
    button_recomecar.click = function(this)
        set_scene("inicial")
    end
end

draw = function()
    round_rectangle(love.graphics.getWidth()/2-250.5, 236, 501, 126, 30, {205/255, 116/255, 225/255})
	round_rectangle(love.graphics.getWidth()/2-111, 400, 222, 40,20, {254/255, 234/255, 226/255})
    gui:draw()
end

exit = function(scene)
    if texto_finalizar then gui:rem(texto_finalizar) end
    if button_recomecar then gui:rem(button_recomecar) end
end