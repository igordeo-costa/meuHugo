---
title: "Começando do zero no PCIbex - Parte 03"
date: 2021-05-05T19:13:25-03:00
tags: ["Ibex Farm", "PCIbex", "Tutorial PCIbex"]
author: Igor Costa e Ana Paula Jakubów
---
##### Por Igor Costa (LAPAL/PUC-Rio) e Ana Paula Jakubów (LAPAL/PUC-Rio; UERJ)

Nessa parte do nosso tutorial, vamos avançar um pouco mais e brincar com a aleatorização dos nossos estímulos experimentais, além de incluir algumas sentenças distratoras. Como sempre, para acompahar o que está aqui, é importante que você tenha lido as primeiras partes:

[Começando no PCIbex do zero - Parte 01](https://igordeo-costa.github.io/posts/pcibextutorial01/)

[Começando no PCIbex do zero - Parte 02](https://igordeo-costa.github.io/posts/pcibextutorial02/)

A fim de fazer a aleatorização, não vamos usar o elemento ```Sequence```. A [documentação do PCIbex para ele](https://doc.pcibex.net/global-commands/sequence/) tem pouca coisa, recomendando a [documentação original do Ibex Farm sobre sequência de apresentação](https://github.com/addrummond/ibex/blob/master/docs/manual.md#shuffle-sequences). Leia com atenção, pois essa parte é difícil, talvez a mais difícil de todas, mas vamos tentar dar uma mastigadinha aqui para você.

## Criando uma sequência de apresentação
Para essa parte do tutorial, vamos usar o mesmo código e a mesma tabela de estímulos experimentais que estávamos usando na [Parte 02](https://igordeo-costa.github.io/posts/pcibextutorial02/), com a diferença que mudamos o nome dos dois trials que temos para "instrucao" e "experimentais" e acrescentamos uma única linha de código bem no início, antes do primeiro trial.

Lembre-se: ainda estamos com essa tabela de itens experimentais:

{{< highlight r >}}
group,item,verbo,numero,frase
A,1,transitivo,sg,A menina comeu o bolo.
B,1,transitivo, pl,As menina comeu o bolo.
A,2,transitivo,sg,O lobo mordeu a lebre.
B,2,transitivo,pl,Os lobo mordeu a lebre.
{{< / highlight >}}

E esse o código que vamos rodar agora.

{{< highlight js >}}
PennController.ResetPrefix(null)

Sequence("instrucao", randomize("experimentais")) // Essa é a linha nova que acrescentamos

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
            )
        )
{{< / highlight >}}
Como você deve ter notado, o elemento ```Sequence``` controla a sequência de apresentação dos itens do seu experimento: no nosso caso, acrescentamos o elemento ```randomize``` como segundo argumento da sequência, para que ele aleatorize a apresentação dos itens experimentais. É muito importante acrescentar o comando ```Sequence```no início do seu código e repetir exatamente os nomes dados aos blocos de apresentação em ```newTrial```ao longo do seu código.Dica: não use acentos no seu código.

{{< highlight js >}}
Sequence("instrucao", randomize("experimentais"))
{{< / highlight >}}

O código acima, portanto, apresenta primeiro o trial de nome "instrucao" e, em seguida, os itens experimentais, chamado "experimentais", aleatorizados para cada sujeito.

Simples, não é? Então vamos complicar um pouco.

## Adicionando sentenças distratoras
Vamos agora criar uma tabela com um conjunto de 4 sentenças distratoras, como abaixo (e incluí-la na aba ```Resources```):

{{< highlight r >}}
group,frase
dist,Distratora 1.
dist,Distratora 2.
dist,Distratora 3.
dist,Distratora 4.
{{< / highlight >}}

E acrescentemos um novo trial a fim de acessar essa tabela:

{{< highlight js >}}
// Não vamos repetir o código inteiro aqui. Você já entendeu como funciona, não é?

Template("minhatabela.csv",
  exp => newTrial("experimentais",
        newController("DashedSentence", {s: exp.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
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
            )
        )
{{< / highlight >}}
Lá no início, acrescentamos a seguinte sequência:

{{< highlight js >}}
Sequence("instrucao", randomize("experimentais"), randomize("distratoras"))
{{< / highlight >}}
Agora veja o que aconteceu... Não funcionou! Observe que os dois elementos do tipo ```randomize``` estão... bem... em sequência, um após o outro. O que o código está fazendo, portanto, é rodar a instrução, depois rodar as experimentais aleatorizadas e depois as distratoras aleatorizadas. Não é isso o que queremos. Queremos as distratoras mescladas com as experimentais. Para fazer isso, usaremos o elemento ```shuffle```:

{{< highlight js >}}
Sequence("instrucao", shuffle(randomize("experimentais"), randomize("distratoras")))
{{< / highlight >}}

Observe que agora o código funciona assim: cada ```randomize``` aleatoriza o seu conjunto de sentenças (experimentais e distratoras); ```shuffle``` mistura esse conjunto aleatorizado; e ```Sequence``` apresenta esse conjunto depois da instrução, porque é o segundo na lista de apresentação, depois de "instrucao". Importante destacar que ```shuffle``` também mantém os elementos do mesmo tipo o mais espaçados possível. Desse modo, como temos 4 distratoras e 2 experimentais, ele colocará a seguinte ordem: 2 distratoras, seguidas de 1 experimental, seguida de 2 distratoras, ou, esquematicamente:

{{< highlight r >}}
dist, dist, [exp], dist, dist, [exp]
{{< / highlight >}}
Mas, você deve estar se perguntando, por que ele não coloca as 4 distratoras entre as experimentais, assim?

{{< highlight r >}}
[exp], dist, dist, dist, dist, [exp]
{{< / highlight >}}

Desse modo, elas estariam ainda mais afastadas, impedindo que o sujeito percebesse o que estaria sendo testado. Bem, ele não faz isso porque, se o fizesse, as experimentais estariam "o mais afastadas possível", mas as distratoras não. Logo, para achar o equilíbro tanto para as experimentais quanto para as distratoras, ele segue a primeira opção.

Entendido isso, o PCIbex tem uma outra forma, menos verborrágica, de fazer a aleatorização acima, usando a função ```rShuffle```:

Essa sequência:
{{< highlight js >}}
Sequence("instrucao", rshuffle("experimentais", "distratoras"))
{{< / highlight >}}

Faz a mesma coisa que essa sequência:

{{< highlight js >}}
Sequence("instrucao", shuffle(randomize("experimentais"), randomize("distratoras")))
{{< / highlight >}}

## Complicando a sequência de apresentação
Vamos supor, agora, que nós tenhamos dois tipos distintos de distratoras, as distratoras normais e as distratoras exóticas, que vamos incluir em ```Resources``` como um novo arquivo ```.csv``` (se quiser, você pode pensar em distratoras gramaticais e agramaticais ou algo assim):

{{< highlight r >}}
group,frase
dist,Distratora exótica 1.
dist,Distratora exótica 2.
dist,Distratora exótica 3.
dist,Distratora exótica 4.
{{< / highlight >}}

Vamos incluir mais um trial no nosso código-base para acessar essa tabela:

{{< highlight js >}}
// A essa altura do campeonato você já sabe fazer isso,
// então só vamos deixar aqui o trechinho final do código caso você tenha alguma dúvida.

Template("minhasdistratoras.csv",
  dist => newTrial("distratoras",
        newController("DashedSentence", {s: dist.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
        )

,

Template("maisdistratoras.csv",
  dist2 => newTrial("dist_exotic",
        newController("DashedSentence", {s: dist2.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
        )
{{< / highlight >}}

E agora vamos definir o que queremos: queremos que as sentenças experimentais aleatorizadas apareçam mescladas com as sentenças distratoras normais aleatorizadas e com as distrators exóticas aleatorizadas, num grande mix de todo tipo de sentença.

Vamos tentar primeiro essa sequência:

{{< highlight js >}}
Sequence("instrucao", rshuffle("distratoras", "dist_exotic"), randomize("experimentais"))
{{< / highlight >}}

Antes de rodar esse código, pare e pense um pouco por que ele não fará o que queremos. Tente explicar para si mesmo em voz alta. Fez? Então vamos fazer o mesmo aqui também: o compilador vai rodar primeiro a "instrucao"; depois rodará o mix de sentenças distratoras misturas e aleatorizadas (e apenas elas); e só então rodará as experimentais aleatorizadas. Perceba que quase conseguimos o que queríamos. Faltou apenas misturar o mix de distratoras com as experimentais. Vamos, então, colocar tudo isso em um novo ```shuffle```, como abaixo:

{{< highlight js >}}
Sequence("instrucao", shuffle(rshuffle("distratoras", "dist_exotic"), randomize("experimentais")))
{{< / highlight >}}

Vamos entender passo a passo, começando sempre do elemento mais encaixado:

- ```randomize("experimentais")```: aleatoriza as sentenças experimentais;
- ```rshuffle("distratoras", "dist_exotic")```: aleatoriza as distratoras, aleatoriza as distratoras exóticas e faz um mix delas;
- ```shuffle(rshuffle("distratoras", "dist_exotic"), randomize("experimentais"))```: faz um mix dos dois conjuntos anteriores.

Se ainda assim não ficou claro, rode o código com a primeira sequência dada e observe como está organizado; em seguida, rode com a segunda sequência e observe como está organizado.

## Pensando para além da sequência de apresentação
Vamos esquecer por um minuto as sentenças distratoras e focar apenas nas experimentais. Imaginemos que agora temos dois conjuntos de sentenças experimentais: um conjunto com verbos transitivos:

{{< highlight r >}}
group,item,verbo,numero,frase
A,1,transitivo,sg,A menina comeu o bolo.
B,1,transitivo,pl,As menina comeu o bolo.
A,2,transitivo,sg,O lobo mordeu a lebre.
B,2,transitivo,pl,Os lobo mordeu a lebre.
{{< / highlight >}}

E um conjunto com verbos intransitivos:

{{< highlight r >}}
group,item,verbo,numero,frase
A,1,intransitivo,sg,A menina caiu.
B,1,intransitivo,pl,As menina caiu.
A,2,intransitivo,sg,O lobo morreu.
B,2,intransitivo,pl,Os lobo morreu.
{{< / highlight >}}

Você já sabe definir um código para esses dois grupos: você precisa de um Template para cada um deles, mas vamos facilitar para você e deixar o código pronto abaixo:

{{< highlight js >}}
Template("experimentais2.csv",
  exp2 => newTrial("exp_intransit",
        newController("DashedSentence", {s: exp2.frase})
            .center()
            .print()
            .log()
            .wait()
            .remove()
            )
        )
{{< / highlight >}}
Agora vamos usar a seguinte sequência de apresentação, para vermos o que ocorre:

{{< highlight js >}}
Sequence("instrucao", "experimentais", "exp_intransit")
{{< / highlight >}}
Ele apresentou as "experimentais" depois as "exp_intransit", ou seja, para um grupo, apresentou as sentenças no singular e para o outro as sentenças equivalentes no plural:


| Conjunto A - Singular | Conjunto B - Plural |
|:--------------------:|:------------------:|
| A menina comeu o bolo. | As menina comeu o bolo.|
| O lobo mordeu a lebre. | Os lobo mordeu a lebre.|
| A menina caiu. | As menina caiu.|
| O lobo morreu. | Os lobo morreu.|

Nesse caso, não queremos que o mesmo sujeito que viu "A menina comeu o bolo" veja "A menina caiu". O problema, aqui, não está na sequência de apresentação, mas na organização das tabelas de experimentos, nas quais "A menina comeu o bolo" e "A menina caiu" foram ambas alocadas sob o ```group``` etiquetado como ```A```.

|group| Conjunto A - Singular |group |Conjunto B - Plural |
|:---:|:--------------------:|:---:|:------------------:|
A | A menina comeu o bolo. |B |As menina comeu o bolo.|
A | O lobo mordeu a lebre. |B |Os lobo mordeu a lebre.|
A | A menina caiu. |B | As menina caiu.|
A | O lobo morreu. |B |Os lobo morreu.|

O compilador não tem dó nesse caso: como ele foi programado para colocar todos os sujeitos que veem sentenças do tipo ```A``` no mesmo grupo (ou lista), então é isso que ele vai fazer. Se você quiser que ele faça diferente, terá que alocar tais sentenças em diferentes ```group``` e não há nada que você possa fazer na sequência de apresentação para mudar isso, mesmo que as sentenças estejam em outro arquivo.

Assim sendo, para o caso em questão, talvez não faça diferença deixar todas as sentenças experimentais num mesmo arquivo ```.csv``` e todas as distratoras em outro. E vamos assumir também que não tenha problema o nosso sujeito ver a versão transitiva e intransitiva da mesma sentença. Essa será nossa tabela de experimentais:

{{< highlight r >}}
group,item,verbo,numero,frase
t_sg,1,transitivo,sg,A menina comeu o bolo.
t_pl,1,transitivo,pl,As menina comeu o bolo.
i_sg,1,intransitivo,sg,A menina dormiu cedo.
i_pl,1,intransitivo,pl,As menina dormiu cedo.
t_sg,2,transitivo,sg,O lobo mordeu a lebre.
t_pl,2,transitivo,pl,Os lobo mordeu a lebre.
i_sg,2,intransitivo,sg,O lobo morreu de fome.
i_pl,2,intransitivo,pl,Os lobo morreu de fome.
t_sg,3,transitivo,sg,O bruxo beijou a coruja.
t_pl,3,transitivo,pl,Os bruxo beijou a coruja.
i_sg,3,intransitivo,sg,O bruxo caiu da vassoura.
i_pl,3,intransitivo,pl,Os bruxo caiu da vassoura.
t_sg,4,transitivo,sg,A gata bebeu leite.
t_pl,4,transitivo,pl,As gata bebeu leite.
i_sg,4,intransitivo,sg,A gata chegou tarde.
i_pl,4,intransitivo,pl,As gata chegou tarde.
{{< / highlight >}}
Agora, cada sujeito lerá 4 sentenças diferentes, todas na mesma condição experimental e teremos 4 listas (```group```):

Verbo | Número | group
:---:|:---:|:---:
transitivo | singular | t_sg
transitivo | plural | t_pl
intransitivo | singular | t_sg
intransitivo | plural | t_pl

Imagine que continuássemos com dois conjuntos de distratoras, 4 normais:

{{< highlight r >}}
group,frase
dist,Distratora 1.
dist,Distratora 2.
dist,Distratora 3.
dist,Distratora 4.
{{< / highlight >}}

E 4 exóticas:

{{< highlight js >}}
group,frase
dist,Distratora exótica 1.
dist,Distratora exótica 2.
dist,Distratora exótica 3.
dist,Distratora exótica 4.
{{< / highlight >}}
Com isso, poderíamos definir uma sequência de apresentação como aquela abaixo:

{{< highlight js >}}
Sequence("instrucao", rShuffle("distratoras", "dist_exotic"), randomize("experimentais"))
{{< / highlight >}}
Ou simplesmente colocar todas elas no mesmo arquivo:

{{< highlight r >}}
group,frase
dist,Distratora 1.
dist,Distratora 2.
dist,Distratora 3.
dist,Distratora 4.
dist,Distratora exótica 1.
dist,Distratora exótica 2.
dist,Distratora exótica 3.
dist,Distratora exótica 4.
{{< / highlight >}}

E definir uma sequência mais simples:

{{< highlight r >}}
Sequence("instrucao", rShuffle("distratoras", "experimentais"))
{{< / highlight >}}

Tudo isso funcionaria do mesmo jeito. Você precisa apenas definir o que funciona melhor para você e para o seu experimento.

Até agora trabalhamos apenas com designs _between subjects_. E se quiséssemos que todos os sujeitos vissem itens de todas as condições? Como fazer. Veremos esse ponto no [Parte 4](https://igordeo-costa.github.io/posts/pcibextutorial04/) do nosso tutorial.
