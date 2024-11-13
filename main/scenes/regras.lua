default = false

local regras = 'Regras do Numistério:\n1- O jogador comeca com 100 pontos e deve encontrar o numero escondido.\n2- A cada erro, perde 10 pontos.\n3- Tentativas por modo: 10 no facil, 7 no medio e 5 no dificil.\n4- Acertando o numero, voce passa de nivel.\n5- Recompensa ao passar de nivel: facil (+30 pontos), medio (+20 pontos) e dificil (+10 pontos).\n6- Nos niveis:\n   - Facil: numeros de 0 a 100, somando +100 a cada nivel.\n   - Medio: numeros de 0 a 200, duplicando a cada nivel.\n   - Dificil: numeros de 0 a 300, triplicando a cada nivel.\n7- Dicas: MAIOR indica que o numero escondido e maior, MENOR indica que e menor.\n8- A dica QUENTE aparece se voce estiver a 10 numeros de distancia (para mais ou para menos).\n9- O jogo termina se voce desistir, ficar sem tentativas ou sem pontos.\n10- Ao passar de nivel, suas tentativas sao restauradas.\n\nBoa sorte, viajante!\n'

enter = function(scene, args)
    nome = args
    texto = gui:text(regras, {y = 32, w = 1280})
    button = gui:button('Continuar', {x = 128, y = 300, w = 128, h = gui.style.unit})
end

update = function(scene)
    button.click = function(this, x, y)
        set_scene("dificuldade")
    end
end

draw = function(scene)
end

exit = function(scene)
    gui:rem(texto)
    gui:rem(button)
end
