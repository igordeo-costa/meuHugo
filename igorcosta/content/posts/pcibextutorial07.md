---
title: "Começando do zero no PCIbex - Parte 07"
date: 2021-08-02T19:05:10-03:00
tags: ["Ibex Farm", "PCIbex", "Tutorial PCIbex"]
author: Igor Costa e Ana Paula Jakubów
---
##### Por Igor Costa (LAPAL/PUC-Rio) e Ana Paula Jakubów (LAPAL/PUC-Rio; UERJ)

Vimos como montar um experimento de leitura automonitorada nas Partes 1 a 7. No entanto, sempre que fazemos experimentos com seres humanos, precisamos de autorização de um Comitê de Ética. Cada universidade tem seu Comitê de Ética, um comitê (como o nome diz) responsável por analisar os projetos submetidos e suas adequações de acordo com a [Resolução CNS nº 510/16](http://conselho.saude.gov.br/resolucoes/2016/Reso510.pdf). Todo projeto de pesquisa submetido a um Comitê de Ética deve apresentar um _Termo de Compromisso Livre e Esclarecido_, o TCLE. Este documento deve informar ao participante aspectos sobre o objetivo da pesquisa, riscos e benefícios ao participar do experimento, deve assegurar o sigilo de dados pessoais, entre outras exigências. É importante que seu projeto e TCLE estejam de acordo com as normas vigentes para que o Comitê de Ética da sua universidade avalie seus documentos. Verifique as normas para coleta e armazenamento de dados para sua pesquisa junto ao Comitê de Ética da sua universidade.

No momento do experimento, precisamos apresentar o TCLE ao participante. Como esse documento costuma conter um texto de cerca de uma página ou mais, é interessante termos um documento que possa ser acessado via o código do PCIbex. Para acessar arquivos com texto no PCIbex, usamos arquivos do tipo ```html```.

Há duas opções para criar o seu texto ```html```:

1 - Você pode escrever todas as informações num bloco de notas, salvar como ```.txt```, transferir para ```resources``` no PCIbex e alterar a extensão de ```.txt``` para ```.html```;

2 - Você pode clicar no sinal ```+``` em ```resources``` no PCIbex, nomeá-lo como ```TCLE.html```, por exemplo, e começar a digitar seu texto na aba que surgir.

Para criar e formatar textos em ```html```, usamos a linguagem ```css```. Há muitas informações sobre ```css```, mas recomendamos [esse site incrível](https://www.w3schools.com/css/) que permite alterar os códigos fornecidos e imediatamente ver as transformações realizadas. Vamos ver como ficaria um texto com formatação ```css```:

{{< highlight html >}}
<h1 style="text-align:center;font-size:18px; font-family: Calibri"><b>Termo de Compromisso Livre e Esclarecido</b></h1>
<p style="text-align:justify;font-size:18px; font-family: Calibri">Você está sendo convidado(a) a participar, como voluntário(a), desta pesquisa.</p>
<p style="text-align:justify;font-size:18px; font-family: Calibri"> <b>Objetivos:</b></p>
<p style="text-align:justify;font-size:18px; font-family: Calibri"> <b>Riscos:</b></p>
<p style="text-align:justify;font-size:18px; font-family: Calibri"> <b>Benefícios:</b></p>
<p style="text-align:center;font-size:18px; font-family: Calibri"><input type="checkbox" class="obligatory"><b>EU ENTENDI O TCLE E ACEITO PARTICIPAR DA PESQUISA.</b></p>
{{< / highlight >}}

O código acima parece uma grande bagunça. Por isso, vamos isolar a primeira linha do código para explicar o que toda essa linguagem faz com seu texto, mas recomendamos usar o [w3schools](https://www.w3schools.com/css/) para informações mais completas:


Tudo o que for formatação de texto, deve aparecer entre ```< >```.

- ```<h1``` indica que é um título. A letra "h" é de _heading_.

- ```style=``` deve sempre aparecer antes da formatação do estilo, como tamanho de fonte e alinhamento, sendo que os argumentos devem aparecer entre aspas duplas ```" "``` e separados por ponto e vírgula ```;```.

- ```"text-align:center;``` primeiro argumento de ```style``` que indica que o texto deve estar alinhado ao centro.

- ```font-size:18px;``` segundo argumento de ```style``` que indica o tamanho da fonte como 18 pixels - aqui é necessário converter pontos em pixel - há vários conversores disponíveis na internet.

- ```font-family: Calibri">``` último argumento de ```style```, que indica o tipo de fonte, como Calibri. É necessário verificar os tipos de famílias de fontes disponíveis no site indicado acima. Repare que, com o fechamento de ```>```, terminamos a formatação.

- ```<b>Termo de Compromisso Livre e Esclarecido</b>``` as tags html sempre têm que ser abertas e fechadas. No exemplo em questão, ```<b>``` abre a tag que torna um texto negrito (_bold_) e ```</b>``` fecha a tag. Logo, tudo o que estiver entre elas ficará em negrito.

- ```</h1>``` indica o fim do título, já que estamos fechando a tag que abrimos lá na primeira linha.

- ```<p style="text-align:center;font-size:18px; font-family: Calibri">``` você já conhece essa parte. A única diferença aqui é que em vez da tag ```h``` (de _heading_), usamos a tag ```p```, de _parágrafo_.

- ```<input type="checkbox" class="obligatory">``` Aqui incluímos uma caixa que deve ser obrigatoriamente marcada pelo participante para que possa prosseguir.

- ```<b>EU ENTENDI O TCLE E ACEITO PARTICIPAR DA PESQUISA.</b></p>``` este é o texto que aparecerá na caixa.

Repare que temos o início da formatação marcado com ```< >``` e o fim da formatação marcado com ```</ >```. Você pode colar o texto com essa formatação em um bloco de notas ou em uma aba de ```resources``` no PCIbex, conforme indicado nas opções 1 e 2 acima. Podemos, agora, incorporar o arquivo ```.html```com o TCLE no código do experimento do PCIbex usando o elemento ```newHtml```. Além disso, é possível, também, permitir que o participante só avance,se concordar com o TCLE. Para isso, acrescentamos o comando ```.checkboxWarning()``` em ```newHtml``` e precisamos adicionar outros comandos em ```.wait()``` em ```newButton```, parecidos com os que vimos em ```newScale``` na [Parte06](https://igordeo-costa.github.io/posts/pcibextutorial06/):

{{< highlight js >}}
newTrial("termo",
     newHtml("TCLE","TCLE.html") // existe um elemento do tipo newHtml chamado "TCLE" que imprime o arquivo TCLE.html
        .checkboxWarning("Você só pode prosseguir se aceitar o TCLE") // inclui uma tela de aviso caso o participante não aceite os termos do TCLE
        .print()
        .log()
,
newButton("<b> CONTINUAR </b>")
      .center()
      .print()
      .wait(getHtml("TCLE").test.complete() // Verifica se o TCLE foi lido e marcado
                  .failure(getHtml("TCLE").warn()) // Retorna o aviso de erro indicado acima em checkboxWarning()
        )
)
{{< / highlight >}}

Além do TCLE, dependendo do nosso _design_ experimental e das nossa perguntas de pesquisa, podemos pedir informações do participante como idade, nível de escolaridade, entre outras. Conforme vimos na [Parte 06](https://igordeo-costa.github.io/posts/pcibextutorial06/), há diferentes formas de solicitar respostas ao participante:

- ```DropDown```: cria uma tela com opções por meio de rolagem
- ```TextInput```: possibilita ao participante digitar um texto
- ```Scale```: fornece uma escala de respostas com itens que podem ser selecionados

Vamos testar aqui uma opção de resposta em que o participante precisa digitar uma resposta e uma opção em que o participante precisa selecionar uma alternativa dentre outras. Vejamos primeiro a opção em que o participante deve digitar. Para isso, usamos ```newTextInput```.

**Atenção:** ```newText``` apresenta um texto seu, ```newTextInput```abre uma caixa de texto, permitindo que outros digitem um texto. Ah! Vamos adicionar uma informação nova em ```newText``` que diz respeito à formatação de texto usando a linguagem ```css``` - veja mais [aqui](https://doc.pcibex.net/how-to-guides/adding-css/).

Vamos ver:

{{< highlight js >}}
newTrial("infoidade",
    newText("Por favor, antes de começarmos, preencha as seguintes informações:")
        .css("font-size", "20px") // formatação do tamanho da fonte do texto usando css
        .css("font-family", "Calibri") // formatação do tipo de fonte do texto usando css
        .center()
        .print()
    ,
    newText("<p>Digite abaixo a sua idade:</p>")
        .center()
        .print()
    ,
    newTextInput("idade", "") // adiciona uma caixa, chamada "idade", que permite ao participante digitar um texto; o segundo argumento indica que não há texto na caixa
        .center()
        .css("margin","1em") // formatação de tamanho da caixa de texto
        .print()
        .log() // computa a informação digitada
)
{{< / highlight >}}

O segundo argumento do elemento ```newTextInput``` pode ser vazio, como ilustrado no código acima por meio de ```""```,  ou pode conter um texto como "digite aqui a sua idade".  Este texto seria então exibido dentro da caixa, indicando para o participante a ação que deve realizar. Experimente essa alternativa.

Repare que adicionamos ```.log()``` em ```newTextInput("idade", "")```, mas se deixarmos dessa forma, a idade não aparecerá nos resultados. Isso acontece porque, como informado na [documentação do PCIbex](https://doc.pcibex.net/advanced-tutorial/11_collecting-participant-info.html), a informação de um ```TextInput``` não pode ser passada automaticamente para ```.log()```. Para armazenarmos a informação digitada em ```TextInput```, precisamos criar uma variável pode meio de ```newVar```:

{{< highlight js >}}
newTrial("infoidade",
    newText("Por favor, antes de começarmos, preencha as seguintes informações:")
        .css("font-size", "20px") // formatação do tamanho da fonte do texto usando css
        .css("font-family", "Calibri") // formatação do tipo de fonte do texto usando css
        .center()
        .print()
    ,
    newText("<p>Digite abaixo a sua idade:</p>")
        .center()
        .print()
    ,
    newTextInput("idade", "") // adiciona uma caixa, chamada "idade", que permite ao participante digitar um texto; o segundo argumento indica que não há texto na caixa
        .center()
        .css("margin","1em") // formatação de tamanho da caixa de texto
        .print()
        .log() // computa a informação digitada (Igor, na verdade, não sei se precisa desse log aqui ou só em newVar abaixo...)
    ,
    newVar("IDADE") //cria uma variável para estocar a informação de ´´´newTextInpur("idade", "")´´´
        .global() // indica que essa variável deve ser estocada para todos os participantes
        .set(getTextInput("idade")) // retoma o elemento que deve ter sua informação armazenada
        .log("idade") // cria uma coluna chamada "idade" nos resultados
)
{{< / highlight >}}

Podemos, também, inserir um botão para continuar para a próxima etapa, mas permitir que o botão seja clicado apenas quando o participante inserir as informações pedidas. Para isso, inserimos alguns comandos dentro de ```.wait()``` em ```newButton```:

{{< highlight js >}}
 newButton("CONTINUAR")
        .center()
        .print()
        .wait(getTextInput("idade").testNot.text("")) // getTextInput acessa o newTextInput chamado "idade" e .testNot.text("") indica que dentro de "idade" não será aceita a possibilidade de um texto estar vazio ("")
{{< / highlight >}}


Vamos ver agora como pedir para que o participante selecione uma opção dentre algumas alternativas. Vamos usar o elemento ```newDropDown```, pois já vimos o elementos ```newScale``` na [Parte06](https://igordeo-costa.github.io/posts/pcibextutorial06/). Este elemento vai criar uma tela de rolagem com opções por escrito. Veja abaixo:

{{< highlight js >}}
newTrial("infoescolaridade",
    newText("<p>Informe seu nível de escolaridade:</p>") // texto com orientações
        .center()
        .print()
    ,
    newDropDown("escolaridade", "selecionar")
        .add("Ensino Fundamental incompleto", "Ensino Fundamental completo", "Ensino Médio incompleto", "Ensino Médio completo", "Ensino Superior completo", "Ensino Superior incompleto") // adiciona opções à tela de rolagem, as quais aparecem como argumento de add
        .center()
        .print()
        .log() // computa a informação selecionada
)
{{< / highlight >}}

Assim como fizemos em ```newTextInput```, vamos incluir um botão condicional, isto é, o participante só avança no experimento se marcar uma das opções em ```newDropDown```:

{{< highlight js >}}
newButton("CONTINUAR")
        .center()
        .print()
        .wait(getDropDown("escolaridade").test.selected()) // verifica se uma opção foi, de fato, selecionada no elemento newDropDown acima chamado "escolaridade"
)
{{< / highlight >}}

Todo o código que montamos aqui deve aparecer no início do experimento, conforme abaixo. Este é o código completo:

{{< highlight js >}}
PennController.ResetPrefix(null)

Sequence("termo","infoidade","infoescolaridade","instrucao", rshuffle("experimentais", "distratoras"), SendResults(), "fim")

newTrial("termo",
     newHtml("TCLE","TCLE.html")
        .checkboxWarning("Você só pode prosseguir se aceitar o TCLE")
        .print()
        .log()
,
newButton("<b> CONTINUAR </b>")
      .center()
      .print()
      .wait(getHtml("TCLE").test.complete()
                  .failure(getHtml("TCLE").warn())
        )
)
,
newTrial("infoidade",
    newText("Por favor, antes de começarmos, preencha as seguintes informações:")
        .css("font-size", "20px")
        .css("font-family", "Calibri")
        .center()
        .print()
    ,
    newText("<p>Digite abaixo a sua idade:</p>")
        .center()
        .print()
    ,
    newTextInput("idade", "")
        .center()
        .css("margin","1em")
        .print()
        .log()
    ,
    newVar("IDADE")
        .global()
        .set(getTextInput("idade"))
        .log("idade")
    ,
     newButton("CONTINUAR")
        .center()
        .print()
        .wait(getTextInput("idade").testNot.text(""))
)
,
newTrial("infoescolaridade",
    newText("<p>Informe seu nível de escolaridade:</p>")
        .center()
        .print()
    ,
    newDropDown("escolaridade", "selecionar")
        .add("Ensino Fundamental incompleto", "Ensino Fundamental completo", "Ensino Médio incompleto", "Ensino Médio completo", "Ensino Superior completo", "Ensino Superior incompleto")
        .center()
        .print()
        .log()
    ,
    newButton("CONTINUAR")
        .center()
        .print()
        .wait(getDropDown("escolaridade").test.selected())
)
,
newTrial("instrucao",
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
            .labelsPosition("right")
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
                newText("Não foi dessa vez")
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
    .log("verbo", exp.verbo)
    .log("numero", exp.numero)
)
,
Template("minhasdistratoras.csv",
  dist => newTrial("distratoras",
        newController("DashedSentence", {s: dist.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
        ,
        newText("pergunta", dist.pergunta)
            .center()
            .print()
        ,
        newScale("respostas",dist.respC, dist.respE)
            .center()
            .labelsPosition("right")
            .vertical()
            .log()
            .print()
            .wait(getScale("respostas").test.selected())
            .remove()
        ,
        clear()
        ,
        getScale("respostas")
            .test.selected(dist.respC)
            .success(
                newText("Muito bem!")
                    .cssContainer({"font-size": "160%", "color": "green"})
                    .print()
                    .center()
            )
            .failure(
                newText("Não foi dessa vez.")
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
,
newTrial("fim",
    defaultText
        .center()
        .print()
        .wait()
    ,
    newText("Agradecemos sua participação! <br><br> Você já pode fechar seu navegador.")
    )
{{< / highlight >}}

Na próxima parte, vamos investigar os resultados gerados pelo PCIbex.
