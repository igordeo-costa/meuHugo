---
title: "Começando do zero no PCIbex - Parte 04"
date: 2021-05-05T19:30:39-03:00
tags: ["Ibex Farm", "PCIbex", "Tutorial PCIbex"]
author: Igor Costa e Ana Paula Jakubów
---
##### Por Igor Costa (LAPAL/PUC-Rio) e Ana Paula Jakubów (LAPAL/PUC-Rio; UERJ)

Antes de avançarmos um pouco mais, gostaríamos de fazer uma pequena pausa para compreendermos melhor a análise dos nossos resultados. Para isso, vamos retomar o código que usamos na [Parte 2](https://igordeo-costa.github.io/posts/pcibextutorial02/) do nosso tutorial.

Lembre-se de que, naquele ponto, tínhamos essa tabela de dados:

{{< highlight r >}}
group,item,verbo,numero,frase
A,1,transitivo,sg,A menina comeu o bolo.
B,1,transitivo,pl,As menina comeu o bolo.
A,2,intransitivo,sg,O lobo morreu de fome.
B,2,intransitivo,pl,Os lobo morreu de fome.
{{< / highlight >}}

E esse era o código completo que usamos:

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

Template("minhatabela.csv",
  exp => newTrial("minhasfrases",
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
        )
{{< / highlight >}}

Rode esse código e observe com atenção os dados de resultado que obtivemos (se não quiser fazer isso, volte à [Parte](https://igordeo-costa.github.io/posts/pcibextutorial02/), já que eles estão publicados por lá). Vamos reproduzir apenas um trechinho dele aqui para vocês:

{{< highlight js "linenos=table,hl_lines=3 13 18" >}}
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
1619973769,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,Start,1619973764745,NULL
1619973769,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,End,1619973765691,NULL
1619973769,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,PennController,1,_Trial_,Start,1619973765705,NULL
# 13. Reading time.
# 14. Newline?.
# 15. Sentence (or sentence MD5).
# 16. Comments.
1619973769,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,1,A,1619973767629,319,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1619973769,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,2,menina,1619973767629,256,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1619973769,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,3,comeu,1619973767629,256,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1619973769,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,4,o,1619973767629,255,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1619973769,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,5,bolo.,1619973767629,257,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
{{< / highlight >}}

Observe que a coluna ```6. Label``` está preenchida com a expressão "minhasfrases" (veja as linhas 13 e 18, por exemplo, que deixamos destacadas para facilitar a busca). Isso é muito ruim, pois não nos permite identificar diretamente qual é a condição experimental que está sendo medida em cada caso (é claro que podemos fazer isso olhando frase por frase na coluna ```15. Sentence```, mas isso seria muito trabalhoso). Mas, se você prestou bem atenção, entenderá porque isso acontece e pensará num modo de resolver. Tire um tempinho e tente fazer isso sozinho: o que é preciso mudar no código para que em ```Label``` apareça o ```group``` daquela sentença?

Como você deve ter imaginado, o problema ocorre porque no trecho do código reproduzido abaixo, o elemento que está entrando como Label é a expressão "minhasfrases":

{{< highlight js "linenos=table,hl_lines=2" >}}
Template("minhatabela.csv",
  exp => newTrial("minhasfrases", // Aqui está o nosso problema
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
        )
{{< / highlight >}}

Para solucinar, portanto, basta que o compilador acesse a tabela ```.csv``` (que foi armazenada no objeto ```exp```) e inclua a coluna ```group```, exatamente como fizemos com as sentenças dentro do ```newController```. Esse trecho do código então ficará assim:

{{< highlight js "linenos=table,hl_lines=2" >}}
Template("minhatabela.csv",
  exp => newTrial(exp.group,
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
        )
{{< / highlight  >}}

Com isso, seu resultado agora incluirá o grupo ao qual a sentença pertence na coluna Label. Vai ficar mais ou menos assim (observe que agora a sexta coluna incluiu a letra A no lugar de "minhasfrases"; veja imediatamente antes da coluna onde está escrito ```NULL```):

{{< highlight r >}}
1619978534,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,1,A,1619978532343,279,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1619978534,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,2,menina,1619978532343,255,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1619978534,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,3,comeu,1619978532343,264,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1619978534,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,4,o,1619978532343,249,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1619978534,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,5,bolo.,1619978532343,247,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
{{< / highlight >}}

Essa pode parecer uma solução, mas, na verdade, ela vai gerar outro problema mais grave. Como vimos na [Parte 03](https://igordeo-costa.github.io/posts/pcibextutorial03/) do nosso tutorial, nós precisamos que esse ```newTrial``` receba o nome "minhasfrases" ou "experimentais" (como chamamos naquele tutorial) porque precisamos acessá-lo com o elemento ```Sequence``` a fim de definirmos aleatorização e coisas assim. Se não damos um nome para ele em forma de ```String```, não conseguiremos acessá-lo.

O pessoal do PCIbex então pensou em uma solução bem simples para esse problema, que é usar outros elemento do tipo ```log```. Vamos ver como usá-lo.

## Primeiras informações sobre ```log```

Lembre-se de que a nossa tabela de estímulo tinha uma coluna para o fator "verbo" e "numero".
{{< highlight r >}}
group,item,verbo,numero,frase
A,1,transitivo,sg,A menina comeu o bolo.
B,1,transitivo,pl,As menina comeu o bolo.
A,2,intransitivo,sg,O lobo morreu de fome.
B,2,intransitivo,pl,Os lobo morreu de fome.
{{< / highlight >}}

Até agora, rodamos os estímulos experimentais com esse código, no qual inserimos o elemento ```log``` e a única coisa que dizemos sobre ele, ainda na [Parte 01](https://igordeo-costa.github.io/posts/pcibextutorial01/), foi que ele registrava os dados dos estímulos:

{{< highlight js "linenos=table,hl_lines=6" >}}
Template("minhatabela.csv",
  exp => newTrial(exp.group,
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
        )
{{< / highlight  >}}

Essa era a nossa tabela de resultados com esse código, com 5 conjuntos de dados, dois quais deixamos 2 destacados:

{{< highlight r "linenos=table,hl_lines=22-26 34-38" >}}
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
1620228872,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,Start,1620228867383,NULL
1620228872,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,End,1620228868476,NULL
1620228872,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,PennController,1,_Trial_,Start,1620228868490,NULL
# 13. Reading time.
# 14. Newline?.
# 15. Sentence (or sentence MD5).
# 16. Comments.
1620228872,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,1,A,1620228870616,134,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1620228872,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,2,menina,1620228870616,174,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1620228872,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,3,comeu,1620228870616,162,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1620228872,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,4,o,1620228870616,160,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1620228872,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,5,bolo.,1620228870616,192,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
# 13. Comments.
1620228872,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,PennController,1,_Trial_,End,1620228870621,NULL
1620228872,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,PennController,2,_Trial_,Start,1620228870623,NULL
# 13. Reading time.
# 14. Newline?.
# 15. Sentence (or sentence MD5).
# 16. Comments.
1620228872,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,1,O,1620228871999,152,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
1620228872,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,2,lobo,1620228871999,167,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
1620228872,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,3,morreu,1620228871999,161,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
1620228872,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,4,de,1620228871999,152,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
1620228872,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,Controller-DashedSentence,DashedSentence,5,fome.,1620228871999,168,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
# 13. Comments.
1620228872,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,PennController,2,_Trial_,End,1620228872003,NULL
{{< / highlight >}}

Agora vamos comentar essa linha, rodar o experimento e olhar para o resultado, assim:

{{< highlight js "linenos=table,hl_lines=6" >}}
Template("minhatabela.csv",
  exp => newTrial(exp.group,
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            //.log() Nesse momento, o compilador simplemente ignora essa linha e não lê o log
            .wait()
            .remove()
            )
        )
{{< / highlight  >}}

O resultado está abaixo e, como você certamente notou, as informações que destacamos acima não estão presentes aqui. Sem o ```log``` dentro do ```newTrial```, simplesmente não temos as informações que nos são mais relevantes, como o "Reading Time" para cada trecho da sentença. Sem isso, um experimento de leitura automonitorada não faz sequer sentido.

{{< highlight r >}}
Columns below this comment are as follows:
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
1620228766,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,Start,1620228761699,NULL
1620228766,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,End,1620228762809,NULL
1620228766,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,PennController,1,_Trial_,Start,1620228762821,NULL
1620228766,313362cc8a2fca017214b0da440b8033,PennController,1,0,minhasfrases,NULL,PennController,1,_Trial_,End,1620228765325,NULL
1620228766,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,PennController,2,_Trial_,Start,1620228765327,NULL
1620228766,313362cc8a2fca017214b0da440b8033,PennController,2,0,minhasfrases,NULL,PennController,2,_Trial_,End,1620228766797,NULL
{{< / highlight >}}

Esse ```log```, portanto, é um que grava as propriedades do nosso controlador. Por isso, no PCIbex, ele é chamado de ```controller.log``` (você pode ter mais informações sobre ele [aqui](https://doc.pcibex.net/controller/controller-log/)). De fato, se você prestar atenção no código, perceberá que ele está logo depois de ```newController```.

O PCIbex tem vários tipos diferentes de ```log```, cada qual dependente das propriedades do elemento ao qual está vinculado. Por exemplo, há um [canvas.log](https://doc.pcibex.net/canvas/canvas-log/), um [button.log](https://doc.pcibex.net/button/button-log/), um [audio.log](https://doc.pcibex.net/audio/audio-log/) e até um [standard.log](https://doc.pcibex.net/standard-element-commands/standard-log/), dentre muitos outros.

## Usando ```newTrial.log``` para adicionar colunas a nosso resultado
Sabido isso, dê uma lida [nesse tipo de log aqui](https://doc.pcibex.net/global-commands/newtrial-log/), o chamado ```newTrial.log```. Como você deve ter percebido, nos permite adicionar novas colunas à nossa tabela de resultados, vinculadas ao nosso trial. Vamos usar o código abaixo para isso:

{{< highlight js "linenos=table,hl_lines=10-11" >}}
Template("minhatabela.csv",
  exp => newTrial(exp.group,
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
        .log("verbo", exp.verbo) // O primeiro argumento é o nome da coluna na tabela de dados e o segundo argumento é a variável definida após Template, que busca a coluna "verbo" na tabela csv.
        .log("numero", exp.numero)
        )
{{< / highlight  >}}

Se você rodar o experimento com esse código modificado, verá na sua tabela de resultado duas novas linhas (que destacamos abaixo), que apontam para as colunas que trazem as informações do verbo (o nome que demos para um dos ```newTrial.log```) e outra com as informações do número (o nome que demos para o outro ```newTrial.log```). Observe, no conjunto de resultados abaixo, a informação "tansitivo"/"intransitivo" e "sg" imediatamente antes do "reading time"

Esse elemeno acessou, na variável ```exp```, que continha "minhatabela.csv", as colunas "verbo" (```exp.verbo```) e "numero" (```exp.numero```).

{{< highlight r "linenos=table,hl_lines=17-18" >}}
Columns below this comment are as follows:
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
1620231199,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,Start,1620231195613,NULL
1620231199,313362cc8a2fca017214b0da440b8033,PennController,0,0,meuexemplo,NULL,PennController,0,_Trial_,End,1620231196384,NULL
# 13. verbo.
# 14. numero.
# 15. Comments.
1620231199,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,PennController,1,_Trial_,Start,1620231196397,transitivo,sg,NULL
# 15. Reading time.
# 16. Newline?.
# 17. Sentence (or sentence MD5).
# 18. Comments.
1620231199,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,1,A,1620231198254,transitivo,sg,182,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1620231199,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,2,menina,1620231198254,transitivo,sg,152,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1620231199,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,3,comeu,1620231198254,transitivo,sg,152,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1620231199,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,4,o,1620231198254,transitivo,sg,159,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
1620231199,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,Controller-DashedSentence,DashedSentence,5,bolo.,1620231198254,transitivo,sg,158,false,A menina comeu o bolo.,Any addtional parameters were appended as additional columns
# 15. Comments.
1620231199,313362cc8a2fca017214b0da440b8033,PennController,1,0,A,NULL,PennController,1,_Trial_,End,1620231198255,transitivo,sg,NULL
1620231199,313362cc8a2fca017214b0da440b8033,PennController,2,0,A,NULL,PennController,2,_Trial_,Start,1620231198258,intransitivo,sg,NULL
# 15. Reading time.
# 16. Newline?.
# 17. Sentence (or sentence MD5).
# 18. Comments.
1620231199,313362cc8a2fca017214b0da440b8033,PennController,2,0,A,NULL,Controller-DashedSentence,DashedSentence,1,O,1620231199479,intransitivo,sg,143,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
1620231199,313362cc8a2fca017214b0da440b8033,PennController,2,0,A,NULL,Controller-DashedSentence,DashedSentence,2,lobo,1620231199479,intransitivo,sg,144,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
1620231199,313362cc8a2fca017214b0da440b8033,PennController,2,0,A,NULL,Controller-DashedSentence,DashedSentence,3,morreu,1620231199479,intransitivo,sg,144,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
1620231199,313362cc8a2fca017214b0da440b8033,PennController,2,0,A,NULL,Controller-DashedSentence,DashedSentence,4,de,1620231199479,intransitivo,sg,144,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
1620231199,313362cc8a2fca017214b0da440b8033,PennController,2,0,A,NULL,Controller-DashedSentence,DashedSentence,5,fome.,1620231199479,intransitivo,sg,144,false,O lobo morreu de fome.,Any addtional parameters were appended as additional columns
# 15. Comments.
1620231199,313362cc8a2fca017214b0da440b8033,PennController,2,0,A,NULL,PennController,2,_Trial_,End,1620231199483,intransitivo,sg,NULL
{{< / highlight  >}}

Com isso, não precisaremos mudar o nome do nosso ```newTrial```, como tínhamos sugerido no início. Basta apenas usarmos um ```newTrial.log``` para incluírmos a informação que quisermos sobre o Trial no resultado. Não sei você, mas nós achamos uma solução elegante.
