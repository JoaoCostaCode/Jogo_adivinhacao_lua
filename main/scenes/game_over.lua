enter = function(scene, args)
    nivel = args
    texto_game_over = gui:text("Poxa parece que seus pontos acabaram, o jogo terminou para você viajante\n\nMas nao fique triste, voce chegou ao nivel " .. nivel .. " parabens!", {y = 20, w = 512})
    button_recomecar = gui:button('Jogar Novamente', {x = 20, y = 200, w = 128, h = gui.style.unit})
end

update = function(scene)
    button_recomecar.click = function(this)
        set_scene("dificuldade", dificuldade)
    end
end

exit = function(scene)
    if texto_game_over ~= nil then gui:rem(texto_game_over) end
    if button_recomecar ~= nil then gui:rem(button_recomecar) end
end