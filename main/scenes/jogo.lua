local jogo = {
    pontos = 100,
    perca = 10,
    nivel = 1,
    tentativa_facil = 10,
    tentativa_media = 7,
    tentativa_dificil = 5,
    numero_especial_facil = math.random(0, 100),
    numero_especial_medio = math.random(0,200),
    numero_especial_dificil = math.random(0,300)
}

local button_recomecar
local button_continuar_sim
local button_continuar_nao
local button_facil
local button_medio
local button_dificil
local input

enter = function(scene, args)
    dificuldade = args
    pontos = 100
    if dificuldade == 1 then
        texto_comeca = gui:text("Agora o jogo comecou de verdade. Voce esta no nível " .. jogo.nivel .. ": os valores podem variar de 0 ate " .. jogo.nivel*dificuldade*100 .. ", e voce tem 10 tentativas para tentar acertar.\nDigite um numero, viajante:", {y = 32, w = 256})
        for i = 1, jogo.tentativa_facil do
            if jogo.pontos == 0 then
                texto_game_over = gui:text("Poxa parece que seus pontos acabaram, o jogo terminou para você viajante\nMas nao fique triste, voce chegou ao nivel " .. jogo.nivel .. " parabens!", {y = 20, w = 256})
                button_recomecar = gui:button('Jogar Novamente', {x = 20, y = 300, w = 128, h = gui.style.unit})
            end
            
            local numero_jogador
            
            input = gui:input('Insira um número', {64, love.graphics.getHeight() - 32, 256, gui.style.unit}) --campo para ler a entrada
	        input.keyrepeat = true

            if numero_jogador == jogo.numero_especial_facil then -- if para verificar se o jogador acertou o numero_especial_facil
                jogo.pontos = jogo.pontos + 30
                texto_acertou = gui:text("Voce ganhou! Passou para o proximo nivel com, ".. jogo.pontos .. " pontos, parabens! Deseja parar ou continuar?", {y = 20, w = 256})
                button_continuar_sim = gui:button('Sim', {x = 20, y = 300, w = 128, h = gui.style.unit})
                button_continuar_nao = gui:button('Não', {x = 20, y = 300, w = 128, h = gui.style.unit})
                
            end
        end
    end
end

update = function(scene, args)
    button_recomecar.click = function(this)
        set_scene("dificuldade", dificuldade)
    end
    button_continuar_sim.click = function(this)
        jogo.nivel = jogo.nivel + 1  -- Avança para o próximo nível -- se ele não escolher 2 quer dizer que quer conrinuar então o nivel é atualizado, o numero especial e as tentativas são colocadas novamente
        jogo.numero_especial_facil = math.random(0, 100 * jogo.nivel)
        jogo.tentativa_facil = 10
        gui:rem(texto_acertou)
        gui:rem(button_continuar_nao)
        gui:rem(button_continuar_sim)
        update(scene, jogo.nivel)
    end
    button_continuar_nao.click = function(this)
        texto_terminar = gui:text("Voce finalizou o jogo no nivel " .. jogo.nivel .. " e com " .. jogo.pontos .. ". Parabens, viajante!\n\nJogo finalizado. Até a próxima!", {y = 20, w = 256})
    end
    input.done = function(this)
        numero_jogador = tonumber(this.value) -- converte a entrada para número
    end
end

exit = function (scene)
    gui:rem(texto_comeca)
    gui:rem(texto_acertou)
    gui:rem(texto_game_over)
    gui:rem(texto_terminar)
    gui:rem(button_continuar_nao)
    gui:rem(button_continuar_sim)
    gui:rem(button_facil)
    gui:rem(button_medio)
    gui:rem(button_dificil)
    gui:rem(button_recomecar)
end