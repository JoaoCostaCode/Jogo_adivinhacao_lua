local jogo_regras = require "jogo_regras"


local jogo = { -- hash table para o modulo jogo_logica 
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

function jogo.seleciona_nivel() -- função para que o usuario indique qual nivel ira querer
    print("Escolha seu modo de jogo viajante: 1- facil / 2-medio / 3- dificil")
    local nivel_numero = tonumber(io.read()) 
    return jogo.logica(nivel_numero) -- passa como parametro o numero do nivel escolhido e retorna para a função jogo.logica
end

function jogo.logica(numero_nivel) -- é nessa função onde toda al ogica do jogo acontece, a contagem de pontos, a passagem de nivéis e as dicas.

    if numero_nivel == 1 then -- aqui é a lógica para o nível fácil do jogo 
        print(jogo.numero_especial_facil)
        print('Agora o jogo comecou de verdade. Voce esta no nivel ' .. jogo.nivel .. ' os valores podem variar de 0 ate ' .. jogo.nivel*100 .. ', voce tem 10 tentativas para tentar acertar, digite um numero viajante:')

        for i = 1, jogo.tentativa_facil do  -- Loop para tentativas
        
            if jogo.pontos == 0 then
                jogo_regras.limparTela()
                print("Poxa parece que seus pontos acabaram, o jogo terminou para você viajante")
                print('Mas nao fique triste, voce chegou ao nivel ' .. jogo.nivel .. ' parabens!')
                os.exit()
            end
        
            local numero_jogador = tonumber(io.read())  -- Lê e converte a entrada para número

            if numero_jogador == jogo.numero_especial_facil then -- if para verificar se o jogador acertou o numero_especial_facil
                jogo.pontos = jogo.pontos + 30
                print("Voce ganhou! Passou para o proximo nivel com, ".. jogo.pontos .. " pontos, parabens! Deseja parar ou continuar? 1 - continuar / 2 - parar")
                local escolha = tonumber(io.read())

                if escolha == 2 then -- se o jogador escolher 2 o jogo é finalizado pórem antes é printado o nível em que parou e os seus pontos
                    print('Voce finalizou o jogo no nivel ' .. jogo.nivel .. ' e com ' .. jogo.pontos .. '. Parabens, viajante!')
                    print("Jogo finalizado. Ate a proxima!")
                    os.exit()  -- Interrompe o jogo se o jogador escolher parar
                else
                    jogo.nivel = jogo.nivel + 1  -- Avança para o próximo nível -- se ele não escolher 2 quer dizer que quer conrinuar então o nivel é atualizado, o numero especial e as tentativas são colocadas novamente
                    jogo.numero_especial_facil = math.random(0, 100 * jogo.nivel)
                    jogo.tentativa_facil = 10
                    print("Continuando para o proximo nivel...")
                    jogo.logica(numero_nivel)
                end

            elseif math.abs(numero_jogador - jogo.numero_especial_facil) <= 10 then -- caso o jogador não acerte ele tem direito a dica especial caso o numero escondido esteja em um intervalo de 10 numeros
                print("QUENTE!.")
            end

            if numero_jogador < jogo.numero_especial_facil then -- o jogador sempre terá direito a essa dica que dirá se o numero desejado é maior ou menor, no caso desse if seria para maior.
                jogo.tentativa_facil = math.abs(jogo.tentativa_facil -1)
                print('o numero que voce quer e MAIOR e voce tem mais '.. jogo.tentativa_facil .. ' tentativas')
                jogo.pontos = jogo.pontos - jogo.perca
                print('Voce esta com ' .. jogo.pontos .. ' pontos')

            else
                jogo.tentativa_facil = math.abs(jogo.tentativa_facil -1)
                print('o numero que voce quer e MENOR e voce tem mais '.. jogo.tentativa_facil .. ' tentativas' )
                jogo.pontos = jogo.pontos - jogo.perca
                print('Voce esta com ' .. jogo.pontos .. ' pontos')
            end   

        end
        jogo_regras.limparTela()
        print('Ops, parece que suas tentativas acabaram viajante')
        print('Mas nao fique triste, voce chegou ao nivel ' .. jogo.nivel .. ' com ' .. jogo.pontos .. ' pontos, parabens!')
        os.exit()

    end

    if numero_nivel == 2 then -- aqui será para o nivel médio e as mesmas funções se repetem apenas com novos parametros, sera usado tudo que tiver a derivação medio da hash table jogo.
--[[os parametros que irão mudar vão ser o numero especial que tera um intervalo duplicado agora, ja que começa de 0 a 200
    as tentativas serão apenas 7 ao inves de 10
     ]]
        print(jogo.numero_especial_medio)
        print('Agora o jogo comecou de verdade. Voce esta no nivel ' .. jogo.nivel .. ' os valores podem variar de 0 ate ' .. jogo.nivel*200 .. ', voce tem 7 tentativas para tentar acertar digite um numero viajante:')

        for i = 1, jogo.tentativa_media do  -- Loop para tentativas
        
            if jogo.pontos == 0 then
                jogo_regras.limparTela()
                print("Poxa parece que seus pontos acabaram, o jogo terminou para você viajante")
                print('Mas nao fique triste, voce chegou ao nivel ' .. jogo.nivel .. ' parabens!')
                os.exit()
            end

            local numero_jogador = tonumber(io.read())  -- Lê e converte a entrada para número
            if numero_jogador == jogo.numero_especial_medio then
                jogo.pontos = jogo.pontos + 20
                print("Voce ganhou! Passou para o proximo nivel com, ".. jogo.pontos .. " pontos, parabens! Deseja parar ou continuar? 1 - continuar / 2 - parar")
                local escolha = tonumber(io.read())
                if escolha == 2 then
                    print('Voce finalizou o jogo no nivel ' .. jogo.nivel .. ' e com ' .. jogo.pontos .. '. Parabens, viajante!')
                    print("Jogo finalizado. Ate a proxima!")
                    os.exit()  -- Interrompe o jogo se o jogador escolher parar
                else
                    jogo.nivel = jogo.nivel + 1  -- Avança para o próximo nível
                    jogo.numero_especial_medio = math.random(0, 200 * jogo.nivel)
                    jogo.tentativa_media = 7
                    print("Continuando para o proximo nivel...")
                    jogo.logica(numero_nivel)
                end
            elseif math.abs(numero_jogador - jogo.numero_especial_medio) <= 10 then
                print("QUENTE!.")
            end
            if numero_jogador < jogo.numero_especial_medio then
                jogo.tentativa_media = math.abs(jogo.tentativa_media -1)
                print('o numero que voce quer e MAIOR e voce tem mais '.. jogo.tentativa_media .. ' tentativas' )
                jogo.pontos = jogo.pontos - jogo.perca
                print('Voce esta com ' .. jogo.pontos .. ' pontos')
            else
                jogo.tentativa_media = math.abs(jogo.tentativa_media -1)
                print('o numero que voce quer e MENOR e voce tem mais '.. jogo.tentativa_media .. ' tentativas')
                jogo.pontos = jogo.pontos - jogo.perca
                print('Voce esta com ' .. jogo.pontos .. ' pontos')
            end
    
        end
        jogo_regras.limparTela()
        print('Ops, parece que suas tentativas acabaram viajante')
        print('Mas nao fique triste, voce chegou ao nivel ' .. jogo.nivel .. ' com ' .. jogo.pontos .. ' pontos, parabens!')
        os.exit()
    end

    if numero_nivel == 3 then -- aqui novamente só ira mudar os mesmos parametros do anterior
        print(jogo.numero_especial_dificil)
        print('Agora o jogo comecou de verdade. Voce esta no nivel ' .. jogo.nivel .. ' os valores podem variar de 0 ate ' .. jogo.nivel*300 .. ', voce tem 5 tentativas para tentar acertar, digite um numero viajante:')

        for i = 1, jogo.tentativa_dificil do  -- Loop para tentativas
        
            if jogo.pontos == 0 then
                jogo_regras.limparTela()
                print("Poxa parece que seus pontos acabaram, o jogo terminou para voce viajante")
                print('Mas nao fique triste, voce chegou ao nivel ' .. jogo.nivel .. ' parabens!')
                os.exit()
            end

            local numero_jogador = tonumber(io.read())  -- Lê e converte a entrada para número
            if numero_jogador == jogo.numero_especial_dificil then
                jogo.pontos = jogo.pontos + 10
                print("Voce ganhou! Passou para o proximo nivel com, ".. jogo.pontos .. " pontos, parabens! Deseja parar ou continuar? 1 - continuar / 2 - parar")
                local escolha = tonumber(io.read())
                if escolha == 2 then
                    print('Voce finalizou o jogo no nivel ' .. jogo.nivel .. ' e com ' .. jogo.pontos .. '. Parabens, viajante!')
                    print("Jogo finalizado. Ate a proxima!")
                    os.exit()  -- Interrompe o jogo se o jogador escolher parar
                else
                    jogo.nivel = jogo.nivel + 1  -- Avança para o próximo nível
                    jogo.numero_especial_dificil = math.random(0, 300 * jogo.nivel)
                    jogo.tentativa_dificil = 5
                    print("Continuando para o proximo nivel...")
                    jogo.logica(numero_nivel)
                end
            elseif math.abs(numero_jogador - jogo.numero_especial_dificil) <= 10 then
                print("QUENTE!.")
            end
            if numero_jogador < jogo.numero_especial_dificil then
                jogo.tentativa_dificil = math.abs(jogo.tentativa_dificil -1)
                print('o numero que voce quer e MAIOR e voce tem mais '.. jogo.tentativa_dificil .. ' tentativas' )
                jogo.pontos = jogo.pontos - jogo.perca
                print('Voce esta com ' .. jogo.pontos .. ' pontos')
            else
                jogo.tentativa_dificil = math.abs(jogo.tentativa_dificil -1)
                print('o numero que voce quer e MENOR e voce tem mais '.. jogo.tentativa_dificil .. ' tentativas')
                jogo.pontos = jogo.pontos - jogo.perca
                print('Voce esta com ' .. jogo.pontos .. ' pontos')
            end
        end
        jogo_regras.limparTela()
        print('Ops, parece que suas tentativas acabaram viajante')
        print('Mas nao fique triste, voce chegou ao nivel ' .. jogo.nivel .. ' com ' .. jogo.pontos .. ' pontos, parabens!')
        os.exit()
    end


end

return jogo
