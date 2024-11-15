enter = function(scene, args)
    texto_perdeu = gui:text("Poxa parece que seus pontos acabaram, o jogo terminou para você viajante\n\nMas nao fique triste, voce chegou ao nivel " .. args .. " parabens!", {y = 20, w = 512})
    button_recomecar = gui:button('Jogar Novamente', {x = 20, y = 200, w = 256, h = gui.style.unit})
end

update = function(scene)
    button_recomecar.click = function(this)
        set_scene("dificuldade")
    end
end

exit = function(scene)
    if texto_perdeu then gui:rem(texto_perdeu) end
    if button_recomecar then gui:rem(button_recomecar) end
end