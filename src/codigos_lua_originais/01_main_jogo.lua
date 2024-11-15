-- Importando os módulos
io = require("io")
local jogo_regras = require('jogo_regras')
local jogo_logica = require('jogo_logica')

-- Função principal do jogot
function main()
    jogo_logica.seleciona_nivel()
end

-- Fluxo inicial
print("Bem-vindo ao Numesterio\nPor favor, digite seu nome:")
local Nome_jogador = io.read()
print(Nome_jogador .. ", voce deseja saber as regras? sim - 1 / nao - 2")
local Resposta_regra = io.read()

if Resposta_regra == "1" then
    jogo_regras.printRegras()
end

-- Pergunta para iniciar o jogo
print('Vamos comecar o jogo, digite 1 para o jogo iniciar')
local Jogo_continua = io.read()


if Jogo_continua == '1' then
    jogo_regras.limparTela()
    main()  -- Chama a função principal do jogo
else
    print("Ops, parece que voce digitou algo incorreto. Vamos tentar novamente.")
    print('Digite 1 para continuar e escolher o modo')
    Jogo_continua = io.read()

    if Jogo_continua == '1' then
        main()  -- Chama a função principal do jogo
    else
        print('Imagino que voce neo compreendeu. ERROR FATAL') 
        os.exit()  -- Encerra o programa de forma segura
    end
end
