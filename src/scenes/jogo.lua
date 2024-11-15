enter = function(scene, args)
    -- verifica se o jogo já começou
    if args.numero_jogador and args.numero_especial and args.tentativas and args.pontos then
        local partida_comecou = true
        dadosDraw = {}
        dadosDraw.numero_jogador = args.numero_jogador
        dadosDraw.numero_especial = args.numero_especial
        texto_comeca = gui:text("Continuando para o proximo nivel...\n\nVocê está no nível " .. args.nivel .. ": os valores podem variar de 0 até " .. args.nivel*args.dificuldade*100 .. "\n\nDigite um numero, viajante:", {x = love.graphics.getWidth()/2-350.5, y = 90, w = 700, h = 150})
    else
        -- inicializa se o jogo não começou
        args.pontos = 100
        if args.dificuldade == 1 then
            args.tentativas = 10
        elseif args.dificuldade == 2 then
            args.tentativas = 7
        elseif args.dificuldade == 3 then
            args.tentativas = 5
        end
        texto_comeca = gui:text("Agora o jogo comecou de verdade!\n\nVocê está no nível " .. args.nivel .. ": os valores podem variar de 0 até " .. args.nivel*args.dificuldade*100 .. "\n\nDigite um numero, viajante:", {x = love.graphics.getWidth()/2-350.5, y = 90, w = 700, h = 150})
    end
    
    -- quantidade de pontos perdidos por erro
    args.perda = args.dificuldade*10
    
    -- exibe a quantidade de pontos
    texto_pontos = gui:text(args.pontos .. " Pontos", {x = love.graphics.getWidth()-350, y = 415, w = 300, h = 50})
    -- tentativas restántes
    texto_tentativas = gui:text(args.tentativas .. ' tentativas restántes', {x = 50, y = 415, w = 300, h = 50})
    
    --verifica se o jogo já começou
    if partida_comecou then
        -- caso o jogador não acerte ele tem direito a dica especial caso o numero escondido esteja em um intervalo de 10 numeros
        if math.abs(args.numero_jogador - args.numero_especial) <= 10 and args.numero_jogador >= 0 then 
            texto_quente = gui:text('Quente!', {x = love.graphics.getWidth()/2-75, y = 415, w = 150, h = 60})
        end
        
        -- verifica se o número foi menor ou maior
        if args.numero_jogador < args.numero_especial and args.numero_jogador >= 0 then
            texto_dica = gui:text('MAIOR', {x = love.graphics.getWidth()/2-150, y = 515, w = 300, h = 60})
        elseif args.numero_jogador > args.numero_especial and args.numero_jogador >= 0 then
            texto_dica = gui:text('MENOR', {x = love.graphics.getWidth()/2-150, y = 515, w = 300, h = 60})
        end
    else
        --valor padrão caso não exista um numero_jogador
        args.numero_jogador = -1
    end

    --campo para ler a entrada
    input_numero_jogador = gui:input('', {love.graphics.getWidth()/2-140, 305, 280, 50})
    input_numero_jogador:focus()
    
    --inicia o jogo
    jogar(scene, args) 
end

draw = function(scene)
    round_rectangle(love.graphics.getWidth()/2-350, 90, 700, 150, 30, {205/255, 116/255, 225/255}) --texto
    round_rectangle(love.graphics.getWidth()/2-150, 300, 300, 60, 30, {205/255, 116/255, 225/255}) --input
    round_rectangle(50, 400, 300, 60, 30, {136/255, 200/255, 116/255}) --tentativas
    round_rectangle(love.graphics.getWidth()-350, 400, 300, 60, 30, {136/255, 200/255, 116/255}) --pontuação
    if partida_comecou then 
        round_rectangle(love.graphics.getWidth()/2-150, 500, 300, 60, 30, {136/255, 200/255, 116/255}) --maior ou menor
    end
    if partida_comecou and math.abs(dadosDraw.numero_jogador - dadosDraw.numero_especial) <= 10 then 
        round_rectangle(love.graphics.getWidth()/2-75, 400, 150, 60, 30, {136/255, 200/255, 116/255}) --quente
    end
    gui:draw()
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
    if texto_tentativas then gui:rem(texto_tentativas) end
    if button_recomecar then gui:rem(button_recomecar) end
    if texto_quente then gui:rem(texto_quente) end
    if texto_dica then gui:rem (texto_dica) end
    if texto_pontos then gui:rem(texto_pontos) end
    if input_numero_jogador then gui:rem(input_numero_jogador) end
end

jogar = function(scene, dados)
    --verifica se já existe um número alvo, se não, gera um novo número alvo
    if not dados.numero_especial then dados.numero_especial = love.math.random(0, dados.nivel*dados.dificuldade*100) end
    --print(dados.numero_especial) --para testes
    update = function(dt)
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
            set_scene("acertou", dados)
        else
            dados.pontos = dados.pontos - dados.perda
            if dados.pontos <= 0 or dados.tentativas <= 0 then
                if dados.pontos < 0 then dados.pontos = 0 end
                gameoverVar = {}
                gameoverVar.nivel = dados.nivel
                gameoverVar.pontos = dados.pontos
                gameoverVar.perdeu = true
                set_scene("game_over", gameoverVar)
            else
                dados.tentativas = math.abs(dados.tentativas -1)
                set_scene("jogo", dados)
            end
        end
    end
end