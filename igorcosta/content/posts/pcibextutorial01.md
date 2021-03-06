---
title: "Começando do zero no PCIbex - Parte 01"
date: 2021-05-02T18:33:34-03:00
tags: ["Ibex Farm", "PCIbex", "Tutorial PCIbex"]
author: Igor Costa e Ana Paula Jakubów
---
##### Por Igor Costa (LAPAL/PUC-Rio) e Ana Paula Jakubów (LAPAL/PUC-Rio; UERJ)

Este tutorial foi organizado por Igor Costa, com ajuda de Ana Paula Jakubów. Montamos o tutorial com base na nossa experiência com o [PCIbex](https://www.pcibex.net/) - _PennController for Internet Based Experiments_. Nesse sentido, criamos um passo-a-passo para aqueles que nunca viram nada de programação, ```javascript```, ```ccs```, ```html```, etc. Esperamos que ajude no seu experimento. Não somos experts no assunto, mas pretendemos ajudar, de alguma forma, os linguistas brasileiros que trabalham com metodologia experimental.

Dado esse cenário, vamos começar esse post do zero, explicando algumas coisas que talvez sejam óbvias demais, mas que, na nossa experiência, deixam algumas pessoas confusas.

## Linha de comando e Linha de comentário
Uma linha de comando é um código executável, ou seja, um código que realiza uma tarefa, digamos, gravar um tempo de reação, apresentar uma frase na tela, centralizar um elemento, etc.; e uma _linha de comentário_ é uma linha visível para o leitor do _script_ (você), mas não para o programa. Assim, uma linha de comentário não executa nenhuma tarefa. Ela é apenas um comentário explicando um trecho do código, dando uma dica, etc.

Nos _scripts_ do PCIbex, uma linha de comentário é sempre precedida de duas barras ```//``` (Esse é, na verdade, o modo de fazer comentários na linguagem ```javascript```). Assim sendo, no trecho abaixo, tudo que está depois das duas barras **não é lido** pelo programa, podendo ser apagado livremente sem alterar em nada o funcionamento do código:

{{< highlight js >}}
newTrial("meuexemplo", // controla a primeira "página" do experimento
    defaultText // aplica os comandos abaixo aos objetos do tipo neeText abaixo
        .center() // indica que o elemento vai aparecer no centro da tela
        .print() // mostra o elemento na tela
{{< / highlight >}}

Um outro modo de colocar trechos não lidos pelo programa é inserindo blocos inteiros de comentários, o que é feito com o seguinte código ```/* comentário aqui */```. Desse modo, tudo que estiver entre os símbolos da barra e do asterisco (no caso em questão, a frase "comentário aqui") não será lido pelo compilador.

Essa é uma boa ferramenta para testar trechos de códigos, para verificar se funcionam ou não, por exemplo. Em vez de apagar o trecho que funciona, você apenas o comenta e escreve o trecho novo. Se este não funcionar, você não perde o trecho antigo, precisando apenas "descomentá-lo" para o seu _script_ voltar ao normal.

Repare, portanto, que vamos usar os comentários (introduzidos pelas duas barras ```//```) para explicar o que as linhas de comando executam.

## Meu primeiro experimento com PCIbex: leitura automonitorada
Vamos começar por um experimento de leitura automonitorada (_self-paced reading_) muito simples, com apenas uma sentença.

### Página de instrução:
Primeiro, criaremos uma página de instrução igual àquela da imagem abaixo:

![Página de instrução](/imagem1.png)

Para isso, vamos usar o seguinte código (por favor, não se assuste com a quantidade de comentários. Vamos apagá-los logo logo e você então entenderá por que eles estão aqui no começo):

{{< highlight js >}}
// O mais básico dos experimentos de leitura automonitorada

PennController.ResetPrefix(null) // Não vamos explicar esse agora, apenas mantenha-o aqui.

// Primeiro, uma página de instruções muito básica
newTrial("meuexemplo", // é um comando, trial, que controla a primeira "página" do experimento; o nome essa "página" é "meuexemplo"
    defaultText // aplica os comandos abaixo aos objetos do tipo newText abaixo
        .center() // indica que o elemento vai aparecer no centro da tela
        .print() // mostra o elemento na tela

    , // Essa vírgula separa cada um dos elementos dentro dessa primeira "página"

    // <br> é uma tag html para "pular linha" (do inglês "break" ou "quebra de linha");
    // <br><br> pula duas linhas, etc.
    // cria um novo elemento de texto com os possíveis argumentos: ("nome do texto", "texto que quero que apareça na tela")
    // OBS: Por que dar nome aos objetos? O primeiro argumento é a possibilidade de dar um "nome" para seu objeto, caso você queira utilizá-lo ou referenciá-lo novamente em outro momento do experimento sem digitar todo os códigos de novo. Voltaremos a essa observação mais à frente.

    newText("Aperte a barra de espaço para ler as frases. <br><br> Seu tempo de leitura estará sendo medido.")

    ,

    newText("<br>Vamos começar?")
    ,

    newButton("meubotao", "Sim!") //cria um botão com os seguintes argumentos: ("nome do botão", "texto que deve aparecer no botão")
        .center()
        .print()
        .wait() // indica que o experimento será pausado até que o participante execute uma ação, neste caso, pressionar o botão.
)
{{< / highlight >}}

Olhe para esse código com carinho e leia os comentários que foram deixados ao lado de cada linha (daqui em diante, não colocaremos mais comentários sobre o que já explicamos). Observe que temos apenas um elemento principal ```newTrial``` dentro do qual existem três outros elementos, a saber: ```newText```, ```newText``` de novo e ```newButton```. O esqueleto desse _script_ é mais ou menos assim:

{{< highlight js >}}
newTrial(

  newText()
  ,
  newText()
  ,
  newButton()
  )
{{< / highlight >}}

- ```newText```: permite acrescentar textos à página;
- ```newButton```: permite acrescentar um botão clicável à página;

Aqui há uma questão que pode complicar alguns: se há apenas dois elementos de texto, como pode haver 3 linhas de texto na página? Observe o código abaixo (e lembre-se dos comentários feitos acima). No primeiro elemento de texto, inserimos duas ```tags html``` que permitem quebrar a linha (```<br>```). Logo, temos duas linhas no mesmo elemento. Mais à frente veremos como inserir textos maiores nesse espaço.

{{< highlight js >}}
newTrial(

  newText("Aperte a barra de espaço para ler as frases. <br><br> Seu tempo de leitura estará sendo medido.")
  ,
  newText("<br>Vamos começar?")
  ,
  newButton()
  )
{{< / highlight >}}

Agora observe os elementos que acrescentamos, colocados exatamente abaixo de ```newTrial```:

- ```.center```: centraliza o objeto;
- ```.print```: mostra o objeto na tela;
- ```defaultText```: controla as propriedades _default_ de todos os elementos de texto dentro desse Trial. Logo, todo elemento do tipo texto aparecerá na tela (```.print```) centralizado (```.center```);
- ```"meuexemplo"```: é o nome que demos para esse ```Trial```, ou seja, para essa página que está sendo mostrada para você na tela. Você poderia chamar de qualquer coisa aqui, mas sempre entre aspas duplas. O código funcionará normalmente sem esse nome, mas ele pode ser importante se quisermos retomá-lo mais tarde.

{{< highlight js >}}
newTrial("meuexemplo",
    defaultText
        .center()
        .print()
        ,
        newText("Aperte a barra de espaço para ler as frases. <br><br> Seu tempo de leitura estará sendo medido.")
        ,
        newText("<br>Vamos começar?")
        ,
        newButton()
        )
{{< / highlight >}}

Por fim, vamos investigar o botão:

#### Inserindo um botão clicável

Eis o código do nosso botão:

{{< highlight js >}}
newButton("meubotao", "Sim!")
    .center()
    .print()
    .wait()
{{< / highlight >}}

Como já falamos logo acima sobre o ```newTrial```, demos o nome de "meubotao" para esse objeto e dissemos que nele aparecerá escrita a palavra "Sim!". Ele aparecerá na tela (```.print```) centralizado (```.center```) e aguardará (```.wait```) até ser apertado.

Pronto! Terminamos essa parte! O código final, limpo dos comentários, está abaixo:

{{< highlight js >}}
PennController.ResetPrefix(null)

newTrial("meuexemplo",
    defaultText
        .center()
        .print()
    ,

    newText("Aperte a barra de espaço para ler as frases. <br><br> Seu tempo de leitura estará sendo medido.")
    ,

    newText("<br>Vamos começar?")
    ,

    newButton("meubotao", "Sim!")
        .center()
        .print()
        .wait()
)
{{< / highlight >}}

### Acrescentando um único item experimental

Agora que já fizemos a nossa página de instruções (Veja bem... mais à frente vamos incrementar esse código, colocando mais informações nele. Por enquanto estamos apenas firmando as fundações do nosso projeto), vamos inserir um item experimental, ou seja, uma frase que apareça na tela para ser lida pelo participante do experimento palavra por palavra, de modo que o próprio participante controle essa passagem apertando a barra de espaço do teclado.

Assim sendo, vamos acrescentar ao código acima o seguinte trecho:

{{< highlight js >}}
, // Essa vírgula separa cada uma das "páginas"

// Agora uma sentença experimental
newTrial("frase_1", // controla a segunda "página" do experimento
    newController("DashedSentence",
        {s: "Essa é a única frase experimental."}) // o tipo de experimento é leitura automonitorada, denominada "DashedSentence" no PCIbex, e há uma sentença ({s: "sentença que quero que o participante leia"}) a ser lida pelo participante item por item.
        .center()
        .print()
        .log() //armazena informação relativa ao tempo de resposta
        .wait()
        .remove() // remove o item da tela e passa para o próximo
      ) // Fim do script aqui!
{{< / highlight >}}

Novamente, leia o código e os comentários com carinho. Abaixo reescrevemos apenas o seu esqueleto para facilitar a compreensão:

{{< highlight js >}}
newTrial(
    newController()
        .center()
        .print()
        .log()
        .wait()
        .remove()
      )
{{< / highlight >}}

Como você já pôde notar, agora temos apenas dois elementos principais, ```newTrial``` e ```newController```. O primeiro você já sabe o que faz: controla toda a informação que está sendo mostrada na página nesse momento. Demos o nome para ele de ```frase_1```, mas você pode chamar como quiser. O segundo - ```newController``` - é mais complexo.

Se você já usava o [Ibex Farm](https://spellout.net/ibexfarm), a versão antiga do PCIbex, lembrará certamente que lá havia vários "controladores", ou seja, comandos pré-prontos para executar determinado tipo de experimento. Assim, se você queria fazer um "julgamento de aceitabilidade", havia um controlador chamado ```AcceptabilityJudgement```. Se queria apresentar uma frase cujas palavras passavam sozinhas após certo tempo, havia um controlador chamado ```FlashSentence```. Se queria fazer uma pergunta, havia um controlador chamado ```Question```, etc. [Clicando aqui você tem acesso a uma lista completa dos controladores do PCIbex](https://doc.pcibex.net/controller/). Fique à vontade para experimentar.

O nosso controlador será ```DashedSentence```, obviamente, após o qual introduziremos a sentença desejada, sempre entre chaves e iniciada pela letra ```s:```, assim: ```{s: "minha sentença aqui entre aspas duplas."}```. Nosso código agora estaria desse modo (a sentença ```{s: "..."}``` pode tanto aparecer na mesma linha, como abaixo; ou separada em outra linha, como estava na versão acima. Isso não é relevante para o compilador, nesse caso):

{{< highlight js >}}
newTrial("frase_1",
    newController("DashedSentence", {s: "Essa é a única frase experimental."})
        .center()
        .print()
        .log()
        .wait()
        .remove()
      )
{{< / highlight >}}

Como você já sabe, ```.center``` centralizará nosso elemento na tela; ```.print``` o mostrará na tela e ```.wait``` garantirá que ele ficará aguardando algo ocorrer (como passar o tempo para que ele desapareça). Os novos elementos são:

- ```.log```: esse elemento grava o tempo quando o controlador é iniciado;
- ```.remove```: esse elemento remove a frase da tela e passa para a próxima.

Se você tiver dúvidas sobre qualquer elemento do PCIbex, pode acessar [essa página](https://doc.pcibex.net/elements/), onde todos são explicados pelos autores do projeto.

Agora que temos a parte da frase experimental, podemos visualizar o código completo:

{{< highlight js >}}
PennController.ResetPrefix(null)

newTrial("meuexemplo",
    defaultText
        .center()
        .print()
    ,

    newText("Aperte a barra de espaço para ler as frases. <br><br> Seu tempo de leitura estará sendo medido.")
    ,

    newText("<br>Vamos começar?")
    ,

    newButton("meubotao", "Sim!")
        .center()
        .print()
        .wait()
        )
,

newTrial("frase_1",
    newController("DashedSentence", {s: "Essa é a única frase experimental."})
        .center()
        .print()
        .log()
        .wait()
        .remove()
      )
{{< / highlight >}}

Agora você pode simplesmente copiar e colar esse código no [PCIbex Farm](https://farm.pcibex.net/) e rodar seu experimento. O resultado será um conjunto de dados parecido com esse.

{{< highlight r >}}
# Last submission only; create an account for full results file
#
# Results on Sunday May 02 2021 01:29:12 UTC
# USER AGENT: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0
# Design number was non-random = 0
#
# Columns below this comment are as follows:
# 1. Results reception time.
# 2. MD5 hash of participant's IP address.
# 3. Controller name.
# 4. Order number of item.
# 5. Inner element number.
# 6. Label.
# 7. Latin Square Group.
# 8. PennElementType.
# 9. PennElementName.
# 10. Parameter.
# 11. Value.
# 12. EventTime.
# 13. Comments.
1619918952,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,Start,1619918945449,NULL
1619918952,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,End,1619918949148,NULL
1619918952,313362cc8a2fca017214b0da440b8033,PennController,1,0,frase_1,NULL,PennController,1,_Trial_,Start,1619918949161,NULL
# 13. Reading time.
# 14. Newline?.
# 15. Sentence (or sentence MD5).
# 16. Comments.
1619918952,313362cc8a2fca017214b0da440b8033,PennController,1,0,frase_1,NULL,Controller-DashedSentence,DashedSentence,1,Essa,1619918952641,390,false,Essa é a única frase experimental.,Any addtional parameters were appended as additional columns
1619918952,313362cc8a2fca017214b0da440b8033,PennController,1,0,frase_1,NULL,Controller-DashedSentence,DashedSentence,2,é,1619918952641,296,false,Essa é a única frase experimental.,Any addtional parameters were appended as additional columns
1619918952,313362cc8a2fca017214b0da440b8033,PennController,1,0,frase_1,NULL,Controller-DashedSentence,DashedSentence,3,a,1619918952641,319,false,Essa é a única frase experimental.,Any addtional parameters were appended as additional columns
1619918952,313362cc8a2fca017214b0da440b8033,PennController,1,0,frase_1,NULL,Controller-DashedSentence,DashedSentence,4,única,1619918952641,353,false,Essa é a única frase experimental.,Any addtional parameters were appended as additional columns
1619918952,313362cc8a2fca017214b0da440b8033,PennController,1,0,frase_1,NULL,Controller-DashedSentence,DashedSentence,5,frase,1619918952641,375,false,Essa é a única frase experimental.,Any addtional parameters were appended as additional columns
1619918952,313362cc8a2fca017214b0da440b8033,PennController,1,0,frase_1,NULL,Controller-DashedSentence,DashedSentence,6,experimental.,1619918952641,433,false,Essa é a única frase experimental.,Any addtional parameters were appended as additional columns
# 13. Comments.
1619918952,313362cc8a2fca017214b0da440b8033,PennController,1,0,frase_1,NULL,PennController,1,_Trial_,End,1619918952645,NULL
{{< / highlight >}}
Se quiser saber como acessar esses dados no R, veja [esse post](https://igordeo-costa.github.io/posts/dadosibex/).

Por enquanto, vamos ficar por aqui. No [próximo artigo](https://igordeo-costa.github.io/posts/pcibextutorial02/) aprofundaremos mais nossos estudos.
