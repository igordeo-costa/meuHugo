---
title: "Começando do zero no PCIbex - Parte 06"
date: 2021-07-25T10:15:42-03:00
tags: ["Ibex Farm", "PCIbex", "Tutorial PCIbex"]
author: Igor Costa e Ana Paula Jakubów
---
##### Por Igor Costa (LAPAL/PUC-Rio) e Ana Paula Jakubów (LAPAL/PUC-Rio; UERJ)

Desde a [Parte 1](https://igordeo-costa.github.io/posts/pcibextutorial01/) do nosso tutorial, vimos montando um experimento de leitura automonitorada. Esse tipo de experimento geralmente conta com uma pergunta de compreensão leitora ao final de cada item experimental, visto que ela ajuda a manter a atenção do participante no experimento. Nesta parte, portanto, iremos aprender como fazer essa inserção.

Podemos inserir perguntas usando o elemento ```newText```. Vejamos:

{{< highlight js >}}
PennController.ResetPrefix(null)

newTrial(
        newController("DashedSentence", {s: "A menina comeu o bolo."}) // Essa parte do código você já conhece!
            .center()
            .print()
            .log()
            .wait()
            .remove()
        ,
        newText("A menina comeu maçã?") // Parte nova do código: a pergunta aparecerá após a apresentação do item experimental. Faça o teste!
            .center()
            .print()
            .wait() // Colocamos esse comando aqui só para você visualizar a pergunta, vamos continuar escrevendo o código
        )
{{< / highlight >}}

Já temos uma pergunta, mas não temos opções de respostas. Podemos acrescentar opções de respostas a partir de vários elementos:

- ```DropDown``` - cria uma tela com opções por meio de rolagem
- ```TextInput``` - possibilita ao participante digitar um texto
- ```Scale``` - fornece uma escala de respostas com itens que podem ser selecionados
- ```Selector```- torna um objeto, como uma figura, por exemplo, clicável

Estas são apenas algumas opções de respostas. Há várias! Confira a documentação do PCIbex sobre ```elements``` [aqui](https://doc.pcibex.net/selector/).

No nosso experimento, vamos optar por ```Scale```. Para isso, vamos criar um novo elemento do tipo escala com ```newScale```:

{{< highlight js >}}
PennController.ResetPrefix(null)

newTrial(
        newController("DashedSentence", {s: "A menina comeu o bolo."})
            .center()
            .print()
            .log()
            .wait()
            .remove()
        ,
        newText("A menina comeu maçã?")
            .center()
            .print()
        ,
        newScale("resposta","sim", "não") // Adicionamos opções de respostas "sim" e "não" que aparecerão na tela do participante. Como você já sabe, "resposta" é simplesmente o nome do objeto.
            .center()
            .labelsPosition( "right" ) // Indica onde as opções de respostas devem aparecer; opções: "left", "top", "bottom"
            .vertical() // Indica a disposição da opções de respostas na tela
            .print()
            .wait() // Espera a ação do participante de clicar em alguma resposta
        )
{{< / highlight >}}

Você também pode permitir acesso à próxima etapa apenas se o participante marcar uma das opções fornecidas. Para isso, você deve acrescentar algumas informações dentro do comando ```.wait()```. Vamos colocar essa parte do ```.wait()``` aqui, omitindo o resto do código:

{{< highlight js "linenos=table, hl_lines=7" >}}
,
newScale("resposta","sim", "não") // Adicionamos opções de respostas "sim" e "não" que aparecerão na tela do participante. Como você já sabe, "resposta" é simplesmente o nome do objeto.
    .center()
    .labelsPosition( "right" ) // Indica onde as opções de respostas devem aparecer; opções: "left", "top", "bottom"
    .vertical() // Indica a disposição da opções de respostas na tela
    .print()
    .wait(getScale("respostas").test.selected()) // Espera a ação do participante de clicar em alguma resposta
)
{{< / highlight >}}

Observe que, dentro de ```.wait()```, o código recupera a escala por meio do comando ```getScale```e o comando ```.test.selected()```checa se alguma opção da escala foi de fato escolhida. Podemos, ainda, gravar a resposta selecionada pelo participante, acrescentando o comando ```.log()```. Após a possibilidade de escolha em uma escala, podemos, inclusive, adicionar um botão permitindo que o participante passe para a próxima frase. Vamos ver como fica o código completo (sem comentários dessa vez):

{{< highlight js "linenos=table, hl_lines=19 21" >}}
PennController.ResetPrefix(null)

newTrial(
        newController("DashedSentence", {s: "A menina comeu o bolo."})
            .center()
            .print()
            .log()
            .wait()
            .remove()
        ,
        newText("A menina comeu maçã?")
            .center()
            .print()
        ,
        newScale("resposta","sim", "não")
            .center()
            .labelsPosition( "right" )
            .vertical()
            .log() // Computa qual foi a opção selecionada pelo participante
            .print()
            .wait(getScale("respostas").test.selected())
        ,
        newButton("Próxima Frase")
            .center()
            .print()
            .wait()
        )
{{< / highlight >}}

O código acima é uma maneira de incluir perguntas e opções de respostas. Podemos, também, assim como fizemos com os itens experimentais e distratores em partes anteriores do tutorial, organizar uma tabela ```.csv``` com perguntas e respostas e usar uma variável para identificar as colunas das tabelas. Vamos ver como fazer dessa maneira.

## Extraindo perguntas e respostas de uma tabela ```.csv```
Você lembra da nossa tabela utilizada na [Parte 05](https://igordeo-costa.github.io/posts/pcibextutorial05/)? Vamos reproduzir as primeiras linhas aqui, mas repare que acrescentamos algumas colunas e mais algumas linhas para diversificar os estímulos:

{{< highlight r >}}
group,item,verbo,numero,frase,pergunta,respC,respE
A,1,transitivo,sg,A menina comeu o bolo.,A menina pulou corda?,não,sim
B,1,transitivo,pl,As menina comeu o bolo.,A menina pulou corda?,não,sim
C,1,intransitivo,sg,A menina dormiu cedo.,A menina pulou corda?,não,sim
D,1,intransitivo,pl,As menina dormiu cedo.,A menina pulou corda?,não,sim
A,2,transitivo,sg,A menina bebeu o suco.,A menina pulou corda?,não,sim
B,2,transitivo,pl,As menina bebeu o suco.,A menina pulou corda?,não,sim
C,2,intransitivo,sg,A menina pulou corda.,A menina pulou corda?,sim,não
D,2,intransitivo,pl,As menina pulou corda.,A menina pulou corda?,sim,não
{{< / highlight >}}

As novas colunas são: _pergunta_, _respC_ (resposta certa) e _respE_ (resposta errada) - vamos explicar, em breve, que ter uma coluna com resposta certa e outra com resposta errada é útil se você quiser dar algum tipo de feedback para o participante. Mas voltemos à extração de informações da tabela ```.csv```.

### Acrescentando perguntas de compreensão
Já temos nossa tabela organizada com a coluna _pergunta_ e o código exposto acima. Lembrem-se de que, ao utilizarmos uma tabela, precisamos ativar um ```Template``` e criar uma variável. Vejamos:

{{< highlight js "linenos=table,hl_lines=3-4 12 16" >}}
PennController.ResetPrefix(null)

Template("minhatabela.csv",
  exp => newTrial("experimentais",
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove() // Até aqui, você conhece o código, se não, veja as partes anteriores
        ,
        newText("pergunta", exp.pergunta) // Veja: aqui usamos a variável exp e selecionamos a coluna chamada "pergunta" em nossa tabela
            .center()
            .print()
        ,
        newScale("respostas",exp.respC, exp.respE) // Aqui utilizamos a variável exp para selecionar as colunas "respC"" e "respE da nossa tabela)
            .center()
            .labelsPosition( "right" )
            .vertical()
            .log()
            .print()
            .wait(getScale("respostas").test.selected())
            .remove()
        ,
        newButton("Próxima Frase")
            .center()
            .print()
            .wait()
        )
    )

{{< / highlight >}}

Se você quiser, também pode incluir mensagens para os participantes como retorno positivo ou negativo para as respostas selecionadas. Vamos ver como fazer isso.

### Incluindo mensagem de *feedback* de acordo com a opção selecionada
Para incluir mensagens de *feedback* para o participante, é preciso adicionar um pedaço de código que inclui os comandos ```.success()``` e ```.failure()```. Esses comandos indicam quais ações devem ser executadas diante de um sucesso ou uma falha.

Agora explicamos o motivo de termos uma coluna para respostas certas _respC_ e uma coluna para respostas erradas _respE_. Vamos precisar dessas colunas para indicar, no código, o que é sucesso e qual ação deve ser realizada diante de um sucesso, além de indicar o que é uma falha e qual ação deve ser executada diante de uma falha. No caso do nosso experimento, vamos trabalhar apenas com base nas respostas certas, a coluna _respC_ da tabela. Veja o código abaixo com comentários nas linhas novas:

{{< highlight js "linenos=table,hl_lines=14-34" >}}

// Não vamos repetir o início do código aqui. Ele está logo acima!

        newScale("respostas",exp.respC, exp.respE)
            .center()
            .labelsPosition( "right" )
            .vertical()
            .log()
            .print()
            .wait(getScale("respostas").test.selected())
            .remove()
        ,
        clear() // Este comando limpa a tela
        ,
        getScale("respostas") // Acessa a escala criada em newScale acima chamada "respostas"
            .test.selected(exp.respC) // Verifica se, na escala "respostas", a opção selecionada combina com a resposta presente na coluna respC em minhatabela.csv
            .success(
                newText("Muito bem!") // Se a resposta escolhida pelo participante for compatível com a resposta esperada na coluna respC da tabela, surge uma mensagem com feedback positivo
                    .cssContainer({"font-size": "160%", "color": "green"}) // Você pode alterar a fonte e a cor da mensagem, caso queira - colocamos aqui para exemplificar
                    .print()
                    .center()
            )
            .failure(
                newText("Não foi dessa vez. Preste atenção e acertará na próxima!") // Se a resposta escolhida for qualquer outra, diferente da que está especificada em success, aparecerá uma mensagem de feedback negativo
                    .cssContainer({"font-size": "160%", "color": "red"})
                    .print()
                    .center()
            )
        ,
        newButton("Próxima Frase")
            .center()
            .print()
            .wait()
    )
)
{{< / highlight >}}

Veja que em ```.wait()``` o comando ```.test.selected()``` só verifica se alguma opção foi marcada. Quando utilizamos ```.success(getScale("respostas").test.selected(exp.respC)```, estamos indicando que a opção marcada pelo participante só é bem sucedida se combinar com as respostas fornecidas na coluna _respC_ de _minhatabela.csv_, caso contrário é uma falha. Repare que não especificamos nenhuma resposta dentro do comando ```.failure()```, portanto, qualquer outra resposta fornecida diferente da que foi especificada em ```.success()``` é uma falha. Teste o código.

Do jeito que o código está, o botão "Próxima Frase" aparece junto da mensagem de erro/ acerto. Se você não quiser que o botão apareça junto com a mensagem de erro/acerto, tente implementar um temporizador após a mensagem de erro/acerto, antes do botão "próxima frase", conforme abaixo:

{{< highlight js >}}
newTimer("aguardar", 1000) // A mensagem de erro/acerto ficará exibida na tela por 1000 ms.
            .start()
            .wait()
{{< / highlight >}}

Com isso, podemos então verificar o código completo:

{{< highlight js >}}
PennController.ResetPrefix(null)

Template("minhatabela.csv",
  exp => newTrial("experimentais",
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
        ,
        newText("pergunta", exp.pergunta)
            .center()
            .print()
        ,
        newScale("respostas",exp.respC, exp.respE)
            .center()
            .labelsPosition( "right" )
            .vertical()
            .log()
            .print()
            .wait(getScale("respostas").test.selected())
            .remove()
        ,
        clear()
        ,
        getScale("respostas")
            .test.selected(exp.respC)
            .success(
                newText("Muito bem!")
                    .cssContainer({"font-size": "160%", "color": "green"})
                    .print()
                    .center()
            )
            .failure(
                newText("Não foi dessa vez. Preste atenção e acertará na próxima!")
                    .cssContainer({"font-size": "160%", "color": "red"})
                    .print()
                    .center()
            )
        ,
        newTimer("wait", 1000)
            .start()
            .wait()
        ,
        clear()
        ,
        newButton("Próxima Frase")
            .center()
            .print()
            .wait()
    )
)
{{< / highlight >}}

Pronto! Até aqui, você já tem uma base sólida sobre os principais comandos e elementos para a elaboração de um experimento de leitura automonitorada. Agora você pode (e deve!) explorar a documentação e os fóruns do PCIbex. Programar exige muito tempo de dedicação e muita paciência com as quantidades de erros que vão surgir. Haverá necessidade de revisar partes de códigos inúmeras vezes. Não se frustre e não desista. Isso é absolutamente normal até entre os programadores experientes. Por isso, recomendamos participar de fóruns de dúvidas. Além disso, a equipe do PCIbex costuma ser bastante rápida nas respostas dos fóruns e explicam muito bem as dúvidas.

Mas não fique com saudades! Ainda não acabou. Na [próxima etapa do nosso tutorial]() vamos aprender como coletar as informações dos sujeitos, como idade, escolaridade, se é ou não falante nativo, etc.Ah! E ainda precisamos entender como os resultados dos experimentos são gerados. Até lá.
