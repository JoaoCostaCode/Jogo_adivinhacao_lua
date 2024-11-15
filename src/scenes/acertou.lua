enter = function(scene, args)
    dados = args
    texto_acertou = gui:text("Voce ganhou!\nPassou para o proximo nivel com ".. dados.pontos .. " pontos, parabens!\n\nDeseja continuar?", {x = love.graphics.getWidth()/2-250.5, y = 240, w = 501})
    button_continuar_sim = gui:button('Continuar', {x = love.graphics.getWidth()/2-250.5, y = 414, w = 222, h = 40})
    button_continuar_nao = gui:button('Parar', {x = 494, y = 414, w = 222, h = 40})
end

update = function(scene, args)
    if button_continuar_sim then
        -- Avança para o próximo nível
        button_continuar_sim.click = function(this)
            dados.nivel = dados.nivel + 1
            dados.pontos = dados.pontos
            dados.numero_especial = nil
            set_scene("jogo", dados)
        end
    end
    if button_continuar_nao then
        -- Termina o jogo
        button_continuar_nao.click = function(this)
            gameoverVar = {}
            gameoverVar.nivel = dados.nivel
            gameoverVar.pontos = dados.pontos
            gameoverVar.perdeu = false
            set_scene("game_over", gameoverVar)
        end
    end
end

draw = function()
    round_rectangle(love.graphics.getWidth()/2-250.5, 236, 501, 126, 30, {205/255, 116/255, 225/255})
	round_rectangle(love.graphics.getWidth()/2-250.5, 414,222,40,20, {254/255, 234/255, 226/255})
    round_rectangle(494, 414,222,40,20, {254/255, 234/255, 226/255})
    gui:draw()
end

exit = function()
    if texto_acertou then gui:rem(texto_acertou) end
    if button_continuar_nao then gui:rem(button_continuar_nao) end
    if button_continuar_sim then gui:rem(button_continuar_sim) end
end