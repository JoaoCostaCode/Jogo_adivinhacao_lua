numero_jogador = -1

enter = function(scene, args)
    dificuldade = args.dificuldade
    jogo = {
        pontos = 100,
        perda = dificuldade*10,
        nivel = args.nivel,
        numero_especial = love.math.random(0,100),
    }
    if dificuldade == 1 then 
        jogo.tentativas = 10
        jogo.tentativas_iniciais = 10
    elseif dificuldade == 2 then
        jogo.tentativas = 7
        jogo.tentativas_iniciais = 7
    else
        jogo.tentativas = 5
        jogo.tentativas_iniciais = 5
    end
    
    input_numero_jogador = gui:input('Número:', {128, love.graphics.getHeight() - 32, 256, gui.style.unit}) --campo para ler a entrada
    input_numero_jogador.keyrepeat = true
    button_numero_jogador = gui:button('Adivinhar!', {input_numero_jogador.pos.w + gui.style.unit, 0, 150, gui.style.unit}, input_numero_jogador) -- attach a button
    
    if args.nivel == 1 then 
        texto_comeca = gui:text("Agora o jogo comecou de verdade!\n\nVoce esta no nível " .. jogo.nivel .. ": os valores podem variar de 0 ate " .. jogo.nivel*dificuldade*100 .. ", e voce tem " .. jogo.tentativas .. " tentativas para tentar acertar.\n\nDigite um numero, viajante:", {y = 32, w = 512})
    else
        texto_comeca = gui:text("Continuando para o proximo nivel...\n\nVoce esta no nível " .. jogo.nivel .. ": os valores podem variar de 0 ate " .. jogo.nivel*dificuldade*100 .. ",e voce tem " .. jogo.tentativas .. " tentativas para tentar acertar.\n\nDigite um numero, viajante:", {y = 32, w = 512})
    end
    jogar(scene, args, jogo.nivel, dificuldade)
end

update = function(scene, args)
    input_numero_jogador.done = function(this)
        if this.value ~= nil then -- verifica se a entrada está vazia
            numero_jogador = tonumber(this.value)-- converte a entrada para número
            this.value = '' -- limpa a entrada
        else
            numero_jogador = -1 --valor padrao
        end 
    end
    button_numero_jogador.click = function(this)
        this.parent:done()
	end
end

exit = function (scene)
    limpa_tela()
end

limpa_tela = function()
    if texto_game_over ~= nil then gui:rem(texto_game_over) end
    if texto_comeca ~= nil then gui:rem(texto_comeca) end
    if texto_acertou ~= nil then gui:rem(texto_acertou) end
    if texto_game_over ~= nil then gui:rem(texto_game_over) end
    if texto_terminar ~= nil then gui:rem(texto_terminar) end
    if button_continuar_nao ~= nil then gui:rem(button_continuar_nao) end
    if button_continuar_sim ~= nil then gui:rem(button_continuar_sim) end
    if button_recomecar ~= nil then gui:rem(button_recomecar) end
    if button_numero_jogador ~= nil then gui:rem(button_numero_jogador) end
    if input_numero_jogador ~= nil then gui:rem(input_numero_jogador) end
    if texto_quente ~= nil then gui:rem(texto_quente) end
    if texto_errou ~= nil then gui:rem (texto_errou) end
end

jogar = function(scene, dados)
    jogo.numero_especial = love.math.random(0, dados.nivel*dificuldade*100)
    --print(jogo.numero_especial)
    update = function(dt)
        if button_continuar_sim ~= nil then
            button_continuar_sim.click = function(this)
                dados.nivel = jogo.nivel + 1  -- Avança para o próximo nível -- se ele não escolher 2 quer dizer que quer conrinuar então o nivel é atualizado, o numero especial e as tentativas são colocadas novamente
                limpa_tela()
                set_scene("jogo", dados)
            end    
        end
        if button_continuar_nao ~= nil then
            button_continuar_nao.click = function(this)
                limpa_tela()
                texto_finalizar = gui:text("Voce finalizou o jogo no nivel " .. jogo.nivel .. " e com " .. jogo.pontos .. " pontos. Parabens, viajante!\n\nJogo finalizado. Até a próxima!", {y = 20, w = 1024})
            end
        end
        input_numero_jogador.done = function(this)
            if this.value ~= nil and this.value ~= '' then -- verifica se a entrada está vazia
                numero_jogador = tonumber(this.value)-- converte a entrada para número
                this.value = '' -- limpa a entrada
            else
                numero_jogador = -1 --valor padrao
            end
            if texto_errou ~= nil then
                gui:rem(texto_errou)
            end
            if texto_quente ~= nil then 
                gui:rem(texto_quente)
            end
            adivinhar()
        end
        button_numero_jogador.click = function(this)
            this.parent:done()
        end
    end
    adivinhar = function()
        if numero_jogador ~= nil and numero_jogador == jogo.numero_especial and numero_jogador >= 0 then -- if para verificar se o jogador acertou o numero_especial
            jogo.pontos = jogo.pontos + (30 - ((dificuldade-1)*10))
            limpa_tela()
            texto_acertou = gui:text("Voce ganhou! Passou para o proximo nivel com ".. jogo.pontos .. " pontos, parabens!\n\nDeseja parar ou continuar?", {y = 20, w = 500})
            button_continuar_sim = gui:button('Continuar', {x = 20, y = 300, w = 128, h = gui.style.unit})
            button_continuar_nao = gui:button('Parar', {x = 150, y = 300, w = 128, h = gui.style.unit})
        else
            if numero_jogador ~= nil and math.abs(numero_jogador - jogo.numero_especial) <= 10 and numero_jogador >= 0 then -- caso o jogador não acerte ele tem direito a dica especial caso o numero escondido esteja em um intervalo de 10 numeros
                texto_quente = gui:text('Quente!', {y = love.graphics.getHeight() - 150, w = 500})
            end
            if numero_jogador ~= nil and numero_jogador < jogo.numero_especial and numero_jogador >= 0 then -- o jogador sempre terá direito a essa dica que dirá se o numero desejado é maior ou menor, no caso desse if seria para maior.
                jogo.tentativas = math.abs(jogo.tentativas -1)
                jogo.pontos = jogo.pontos - jogo.perda
                if jogo.pontos <= 0 or jogo.tentativas <= 0 then
                    set_scene("game_over", jogo.nivel)
                else
                    texto_errou = gui:text('O numero que voce quer é MAIOR.\nVocê tem mais '.. jogo.tentativas .. ' tentativas.\nVocê está com ' .. jogo.pontos .. ' pontos', {y = love.graphics.getHeight() - 100, w = 500})
                end
            elseif numero_jogador ~= nil and numero_jogador >= 0 then
                jogo.tentativas = math.abs(jogo.tentativas -1)
                jogo.pontos = jogo.pontos - jogo.perda
                if jogo.pontos <= 0 or jogo.tentativas <= 0 then
                    set_scene("game_over", jogo.nivel)
                else
                    texto_errou = gui:text('O numero que voce quer é MENOR.\nVocê tem mais '.. jogo.tentativas .. ' tentativas.\nVocê está com ' .. jogo.pontos .. ' pontos', {y = love.graphics.getHeight() - 100, w = 500})
                end
            end
        end
    end
end