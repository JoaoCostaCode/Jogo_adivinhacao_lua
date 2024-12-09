# Numistério
Um jogo de adivinhação onde um número é escolhido pelo programa, e o jogador precisa adivinhar qual número foi escolhido, recebendo dicas sobre o número a cada tentativa.

## Ferramentas utilizadas
* Lua 5.1
* [LÖVE 11.5.0](https://love2d.org/)
* [YAS](https://github.com/kithf/yas): biblioteca de gerenciamento de telas
* [GSpöt](https://notabug.org/pgimeno/Gspot): biblioteca de gerenciamento de interface

## Requisitos
Necessário para a versão 11.5.0 de LÖVE

* Sistema Operacional: Windows 7+ (x64)
* Processador: Intel Core i3 / AMD (ou equivalente)
* Gráficos: Placa com suporte a OpenGL 2.1+

## Como jogar
1. [Baixe o jogo](https://github.com/JoaoCostaCode/Jogo_adivinhacao_lua/releases/latest).
2. Execute o programa `Numisterio.exe`.
3. Siga as instruções na tela.

## Como criar o executável usando o código fonte
1. Instale [LÖVE](https://love2d.org/).
2. Baixe o código.
3. Na pasta `\src`, crie um arquivo zip com todo o conteúdo dessa pasta.
   * o arquivo zip não deve conter a pasta `src` dentro do zip, ele precisa conter os arquivos do jeito que estão, com o arquivo `main.lua` na pasta raiz do arquivo zip.
5. Renomeie o arquivo `src.zip` para `src.love`.
6. Mova o arquivo `src.love` para a pasta onde você instalou LÖVE (passo 1).
7. Abra o prompt de comando do windows (`CMD`).
   * Pode ser necessário executar como admin dependendo de onde você instalou LÖVE.
9. Use o comando `cd` para ir à pasta onde LÖVE foi instalado.
10. Use o comando `copy /b love.exe+src.love Numisterio.exe` para gerar o executável.
11. Execute o programa `Numisterio.exe`.

## Importante: Para o executável poder funcionar, ele precisa estar na mesma pasta que os seguintes arquivos:
* `license.txt`
* `love.dll`
* `lua51.dll`
* `mpg123.dll`
* `msvcp120.dll`
* `msvcr120.dll`
* `OpenAL32.dll`
* `SDL2.dll`

Esses arquivos podem ser encontrados e copiados da pasta onde você instalou LÖVE, ou na pasta `\build` desse repositório.
