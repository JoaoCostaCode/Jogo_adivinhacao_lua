enter = function(scene, args)
    --verifica se o jogo já começou
    if not args.pontos then args.pontos = 100 end
    if not args.tentativas then
        if args.dificuldade == 1 then
            args.tentativas = 10
        elseif args.dificuldade == 2 then
            args.tentativas = 7
        elseif args.dificuldade == 3 then
            args.tentativas = 5
        end
    end
    args.perda = args.dificuldade*10
    
    --exibe a quantidade de pontos
    texto_pontos = gui:text("Você está com " .. args.pontos .. " pontos", {x = love.graphics.getWidth() - 300, y = 32, w = 512})
    
    --verifica se o jogo já começou
    if args.numero_jogador and args.numero_especial then
        -- caso o jogador não acerte ele tem direito a dica especial caso o numero escondido esteja em um intervalo de 10 numeros
        if math.abs(args.numero_jogador - args.numero_especial) <= 10 and args.numero_jogador >= 0 then 
            texto_quente = gui:text('Quente!', {y = love.graphics.getHeight() - 150, w = 500})
        end
        
        -- verifica se o número foi menor ou maior
        if args.numero_jogador < args.numero_especial and args.numero_jogador >= 0 then
            texto_errou = gui:text('O numero que voce quer é MAIOR.\nVocê tem mais '.. args.tentativas .. ' tentativas.', {y = love.graphics.getHeight() - 100, w = 500})
        elseif args.numero_jogador > args.numero_especial and args.numero_jogador >= 0 then
            texto_errou = gui:text('O numero que voce quer é MENOR.\nVocê tem mais '.. args.tentativas .. ' tentativas.', {y = love.graphics.getHeight() - 100, w = 500})
        end
    else
        --valor padrão caso não exista um numero_jogador
        args.numero_jogador = -1
    end

    --campo para ler a entrada
    input_numero_jogador = gui:input('Número:', {love.graphics.getWidth()/2, love.graphics.getHeight()/3, 256, gui.style.unit})
    input_numero_jogador:focus()
    
    if args.nivel == 1 then
        texto_comeca = gui:text("Agora o jogo comecou de verdade!\n\nVoce esta no nível " .. args.nivel .. ": os valores podem variar de 0 ate " .. args.nivel*args.dificuldade*100 .. ", e voce tem " .. args.tentativas .. " tentativas para tentar acertar.\n\nDigite um numero, viajante:", {y = 32, w = 512})
    else
        texto_comeca = gui:text("Continuando para o proximo nivel...\n\nVoce esta no nível " .. args.nivel .. ": os valores podem variar de 0 ate " .. args.nivel*args.dificuldade*100 .. ",e voce tem " .. args.tentativas .. " tentativas para tentar acertar.\n\nDigite um numero, viajante:", {y = 32, w = 512})
    end

    --inicia o jogo
    jogar(scene, args) 
end

exit = function (scene)
    limpa_tela()
end

limpa_tela = function() --remove todos os objetos da tela
    if texto_game_over then gui:rem(texto_game_over) end
    if texto_comeca then gui:rem(texto_comeca) end
    if texto_acertou then gui:rem(texto_acertou) end
    if texto_game_over then gui:rem(texto_game_over) end
    if texto_terminar then gui:rem(texto_terminar) end
    if button_continuar_nao then gui:rem(button_continuar_nao) end
    if button_continuar_sim then gui:rem(button_continuar_sim) end
    if button_recomecar then gui:rem(button_recomecar) end
    if texto_quente then gui:rem(texto_quente) end
    if texto_errou then gui:rem (texto_errou) end
    if texto_pontos then gui:rem(texto_pontos) end
    if input_numero_jogador then gui:rem(input_numero_jogador) end
end

jogar = function(scene, dados)
    --verifica se já existe um número alvo, se não, gera um novo número alvo
    if not dados.numero_especial then dados.numero_especial = love.math.random(0, dados.nivel*dados.dificuldade*100) end
    --print(dados.numero_especial) --para testes
    update = function(dt)
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
                limpa_tela()
                texto_finalizar = gui:text("Voce finalizou o jogo no nivel " .. dados.nivel .. " e com " .. dados.pontos .. " pontos. Parabens, viajante!\n\nJogo finalizado. Até a próxima!", {y = 20, w = 1024})
            end
        end
        if input_numero_jogador then
            input_numero_jogador.done = function(this)
                if this.value and this.value ~= '' then -- verifica se a entrada está vazia
                    dados.numero_jogador = tonumber(this.value)-- converte a entrada para número
                    this.value = '' -- limpa a entrada
                else
                    dados.numero_jogador = -1 --valor padrao
                end
                adivinhar()
            end
        else
            -- Se o campo para entrada não existe, cria um
            input_numero_jogador = gui:input('Número:', {love.graphics.getWidth()/2, love.graphics.getHeight()/3, 100, gui.style.unit}) --campo para ler a entrada
        end
    end
    adivinhar = function()
        --Verifica se o jogador acertou
        if dados.numero_jogador and dados.numero_jogador == dados.numero_especial and dados.numero_jogador >= 0 then -- if para verificar se o jogador acertou o numero_especial
            dados.pontos = dados.pontos + (30 - ((dados.dificuldade-1)*10))
            limpa_tela()
            texto_acertou = gui:text("Voce ganhou! Passou para o proximo nivel com ".. dados.pontos .. " pontos, parabens!\n\nDeseja parar ou continuar?", {y = 20, w = 500})
            button_continuar_sim = gui:button('Continuar', {x = 20, y = 300, w = 128, h = gui.style.unit})
            button_continuar_nao = gui:button('Parar', {x = 150, y = 300, w = 128, h = gui.style.unit})
        else
            --verifica se o jogador errou pra mais ou pra menos
            if dados.numero_jogador and dados.numero_jogador < dados.numero_especial and dados.numero_jogador >= 0 then -- o jogador sempre terá direito a essa dica que dirá se o numero desejado é maior ou menor, no caso desse if seria para maior.
                dados.tentativas = math.abs(dados.tentativas -1)
                dados.pontos = dados.pontos - dados.perda
                if dados.pontos <= 0 or dados.tentativas <= 0 then
                    set_scene("game_over", dados.nivel)
                else
                    set_scene("jogo", dados)
                end
            elseif dados.numero_jogador and dados.numero_jogador >= 0 then
                dados.tentativas = math.abs(dados.tentativas -1)
                dados.pontos = dados.pontos - dados.perda
                if dados.pontos <= 0 or dados.tentativas <= 0 then
                    set_scene("game_over", dados.nivel)
                else
                    set_scene("jogo", dados)
                end
            end
        end
    end
end