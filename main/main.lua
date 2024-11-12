-- Importando os módulos
local suit = require("suit")
local GameStateManager = require("gamestateManager")

-- Variaveis
local mostrar_regras = 0
local nome = {text = ""}
local iniciar = false

-- States
local jogo = {
    enter = function()
    end
}

local regras = {
    enter = function()
    end,
    update = function(dt)
        suit.layout:reset(100,100)
        suit.layout:padding(10,10)
        suit.Label("Regras do Numistério\n1- O jogador comeca com 100 pontos e deve encontrar o numero escondido.\n2- A cada erro, perde 10 pontos.\n3- Tentativas por modo: 10 no facil, 7 no medio e 5 no dificil.\n4- Acertando o numero, voce passa de nivel.\n5- Recompensa ao passar de nivel: facil (+30 pontos), medio (+20 pontos) e dificil (+10 pontos).\n6- Nos niveis:\n   - Facil: numeros de 0 a 100, somando +100 a cada nivel.\n   - Medio: numeros de 0 a 200, duplicando a cada nivel.\n   - Dificil: numeros de 0 a 300, triplicando a cada nivel.\n7- Dicas: MAIOR indica que o numero escondido e maior, MENOR indica que e menor.\n8- A dica QUENTE aparece se voce estiver a 10 numeros de distancia (para mais ou para menos).\n\n9- O jogo termina se voce desistir, ficar sem tentativas ou sem pontos.\n10- Ao passar de nivel, suas tentativas sao restauradas.\nBoa sorte, viajante!", 0, 0, 300, 30)
        if suit.Button("Começar a jogar", suit.layout:row(300, 30)).hit then
            GameStateManager:setState(jogo)
        end
    end,
    draw = function()
        suit.draw()
    end
}

local tela_inicial = {
    enter = function()
        
    end,
    update = function(dt)
        suit.Label("Bem-vindo ao Numistério\n\nPor favor, digite seu nome", 100, 10, 300, 30)
        suit.Input(nome,suit.layout:row(300,30))
        if suit.Button("Iniciar", suit.layout:row(300,30)).hit and nome.text ~= "" and nome.text ~= nil then
            if mostrar_regras == 0 then
                suit.Label(nome.text .. ", você deseja saber as regras?")
                if suit.Button("Sim", suit.layout:row(300,30)).hit then
                    mostrar_regras = 1
                end
                if suit.Button("Não", suit.layout:row(300,30)).hit then
                    mostrar_regras = 2
                end 
            elseif mostrar_regras == 1 then
                GameStateManager:setState(regras)
            elseif mostrar_regras == 2 then
                GameStateManager:setState(jogo)
            end
        end
    end,
    draw = function()
        suit.draw()
    end,
    textinput = function (t)
        suit.textinput(t)
    end,
    keypressed = function(key)
        suit.keypressed(key)
    end
}

--funcoes callback

function love.load(args)
    GameStateManager:setState(regras)
end

function love.update(dt)
    GameStateManager:update(dt)
end

function love.draw()
    suit.layout:reset(100,100)
    suit.layout:padding(10,10)
    suit.draw()
    GameStateManager:draw()
end