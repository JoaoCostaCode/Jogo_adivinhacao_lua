default = false

enter = function(scene)
    local regras = 'Regras do Numistério:\n1- O jogador comeca com 100 pontos e deve encontrar o numero escondido.\n2- A cada erro, perde 10 pontos.\n3- Tentativas por modo: 10 no facil, 7 no medio e 5 no dificil.\n4- Acertando o numero, voce passa de nivel.\n5- Recompensa ao passar de nivel: facil (+30 pontos), medio (+20 pontos) e dificil (+10 pontos).\n6- Nos niveis:\n   - Facil: numeros de 0 a 100, somando +100 a cada nivel.\n   - Medio: numeros de 0 a 200, somando +200 a cada nivel.\n   - Dificil: numeros de 0 a 300, somando +300 a cada nivel.\n7- Dicas: MAIOR indica que o numero escondido e maior, MENOR indica que e menor.\n8- A dica QUENTE aparece se voce estiver a 10 numeros de distancia (para mais ou para menos).\n9- O jogo termina se voce desistir, ficar sem tentativas ou sem pontos.\n10- Ao passar de nivel, suas tentativas sao restauradas.\n\nBoa sorte, viajante!\n'
    texto_regras = gui:textLeft(regras, {x = 32 , y = 32, w = love.graphics.getWidth() - 50})
    button_continuar = gui:button('Continuar', {x = love.graphics.getWidth()/2-111, y = love.graphics.getHeight()-100, w = 222, h = 40})
end

update = function(scene)
    button_continuar.click = function(this, x, y)
        set_scene("dificuldade")
    end
end

draw = function(scene)
    round_rectangle(love.graphics.getWidth()/2-111, love.graphics.getHeight()-100,222,40,20, {254/255, 234/255, 226/255})
    gui:draw()
end

exit = function(scene)
    if texto_regras then gui:rem(texto_regras) end
    if button_continuar then gui:rem(button_continuar) end
end
