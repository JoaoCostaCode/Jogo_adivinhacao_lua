
local regras = {} -- hash table que guarda as funções e etc do modulo jogo_regras

function regras.printRegras() -- função que faz o print das regras
    print('Regras do Numesterio:\n')
        print('1- O jogador comeca com 100 pontos e deve encontrar o numero escondido.')
        print('2- A cada erro, perde 10 pontos.')
        print('3- Tentativas por modo: 10 no facil, 7 no medio e 5 no dificil.')
        print('4- Acertando o numero, voce passa de nivel.')
        print('5- Recompensa ao passar de nivel: facil (+30 pontos), medio (+20 pontos) e dificil (+10 pontos).')
        print('6- Nos niveis:')
        print('   - Facil: numeros de 0 a 100, somando +100 a cada nivel.')
        print('   - Medio: numeros de 0 a 200, duplicando a cada nivel.')
        print('   - Dificil: numeros de 0 a 300, triplicando a cada nivel.')
        print('7- Dicas: MAIOR indica que o numero escondido e maior, MENOR indica que e menor.')
        print('8- A dica QUENTE aparece se voce estiver a 10 numeros de distancia (para mais ou para menos).')
        print('9- O jogo termina se voce desistir, ficar sem tentativas ou sem pontos.')
        print('10- Ao passar de nivel, suas tentativas sao restauradas.\n')
        print('Boa sorte, viajante!')
        
end

function regras.limparTela()
    if package.config:sub(1,1) == "\\" then
        os.execute("cls")  -- comando para limpar tela
    end
end

return regras