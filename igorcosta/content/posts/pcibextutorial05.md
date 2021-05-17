---
title: "Começando do zero no PCIbex - Parte 05"
date: 2021-05-15T09:31:15-03:00
tags: ["Ibex Farm", "PCIbex", "Tutorial PCIbex"]
author: Igor Costa e Ana Paula Jakubów
---
##### Por Igor Costa (LAPAL/PUC-Rio) e Ana Paula Jakubów (LAPAL/PUC-Rio; UERJ)

Agora que já estabelecemos alguns conceitos básicos sobre o funcionamento do código, vamos dar alguns passos atrás e olhar para um aspecto muito importante no PCIbex: a organização dos estímulos experimentais na sua tabela .csv, complementando as informações que começamos a dar na [Parte 2](https://igordeo-costa.github.io/posts/pcibextutorial02/) do nosso tutorial.

Vamos partir da tabela que tínhamos deixado ao final daquele tutorial e que acabou sendo complementada no meio da [Parte 3](https://igordeo-costa.github.io/posts/pcibextutorial03/). Aqui está ela (apenas colocamos um destaque em dois dos conjuntos de itens para facilitar a explicação):

{{< highlight r "linenos=table,hl_lines=6-9 14-17" >}}
group,item,verbo,numero,frase
A,1,transitivo,sg,A menina comeu o bolo.
B,1,transitivo,pl,As menina comeu o bolo.
C,1,intransitivo,sg,A menina dormiu cedo.
D,1,intransitivo,pl,As menina dormiu cedo.
A,2,transitivo,sg,O lobo mordeu a lebre.
B,2,transitivo,pl,Os lobo mordeu a lebre.
C,2,intransitivo,sg,O lobo morreu de fome.
D,2,intransitivo,pl,Os lobo morreu de fome.
A,3,transitivo,sg,O bruxo beijou a coruja.
B,3,transitivo,pl,Os bruxo beijou a coruja.
C,3,intransitivo,sg,O bruxo caiu da vassoura.
D,3,intransitivo,pl,Os bruxo caiu da vassoura.
A,4,transitivo,sg,A gata bebeu leite.
B,4,transitivo,pl,As gata bebeu leite.
C,4,intransitivo,sg,A gata chegou tarde.
D,4,intransitivo,pl,As gata chegou tarde.
{{< / highlight >}}

## Montando um desenho _between_
Do modo como esses dados estão organizados, o PCIbex estará fazendo um design _between_ participantes.

__Design between:__  cada um dos participantes vê apenas uma condição experimental, sendo submetido a cada um dos itens dessa condição uma única vez. Por exemplo:

- para a condição __transitivo plural__, o participante que foi colocado na lista B vê 4 itens distintos (As menina comeu.../ Os lobo mordeu.../ Os bruxo beijou.../As gata bebeu...); mas ele não é submetido a nenhuma das demais condições.

- para a condição __intransitivo singular__, o participante que foi colocado na lista C vê itens distintos (A menina dormiu.../ O lobo morreu.../ O bruxo caiu.../ A gata chegou...); mas ele não é submetido a nenhuma das outras condições. E assim para as outras duas listas.

Até agora é isso o que viemos fazendo em todos os casos anteriores. Todos eram desenhos dessa natureza.

## Montando um design _within_
Então vamos ver, agora, como montar um desenho _within_ participantes, ou seja:

__Design within:__ cada um dos participantes vê todas as condições experimentais, sendo submetido a uma (e somente uma) versão de cada item experimental (mais à frente vamos mudar isso. Por enquanto, fiquemos no simples.). Por exemplo:

- o participante 1, digamos, será submetido a todas as condições (transitivo-sg; transitivo-pl; intransitivo-sg; intransitivo-pl) vendo um item diferente para cada uma delas, como abaixo:

item|verbo|numero|frase
|-|--------|--|-----
1|transitivo|sg|A menina comeu o bolo.
2|transitivo|pl|Os lobo mordeu a lebre.
3|intransitivo|sg|O bruxo caiu da vassoura.
4|intransitivo|pl|As gata chegou tarde.

- o participante 2, por sua vez, também será submetido a todas as condições, vendo um conjunto de versões diferente dos mesmos itens que foram vistos pelo participante 1, como abaixo:

item|verbo|numero|frase
|-|--------|--|-----
1|transitivo|pl|As menina comeu o bolo.
2|transitivo|sg|O lobo mordeu a lebre.
3|intransitivo|pl|Os bruxo caiu da vassoura.
4|intransitivo|sg|A gata chegou tarde.

E assim por diante.

Desse modo, para montar um desenho _within_ com os mesmos estímulos disponíveis acima, basta reorganizar a nossa tabela, como fizemos abaixo:

{{< highlight r "linenos=table,hl_lines=6-9 14-17" >}}
group,item,verbo,numero,frase
A,1,transitivo,sg,A menina comeu o bolo.
A,2,transitivo,pl,Os lobo mordeu a lebre.
A,3,intransitivo,sg,O bruxo caiu da vassoura.
A,4,intransitivo,pl,As gata chegou tarde.
B,1,transitivo,pl,As menina comeu o bolo.
B,2,transitivo,sg,O lobo mordeu a lebre.
B,3,intransitivo,pl,Os bruxo caiu da vassoura.
B,4,intransitivo,sg,A gata chegou tarde.
C,1,intransitivo,sg,A menina dormiu cedo.
C,2,intransitivo,pl,Os lobo morreu de fome.
C,3,transitivo,sg,O bruxo beijou a coruja.
C,4,transitivo,pl,As gata bebeu leite.
D,1,intransitivo,pl,As menina dormiu cedo.
D,2,intransitivo,sg,O lobo morreu de fome.
D,3,transitivo,pl,Os bruxo beijou a coruja.
D,4,transitivo,sg,A gata bebeu leite.
{{< / highlight >}}

Uma dica mnemônica que pode facilitar a sua vida: use a coluna item como guia para atribuir os grupos. Assim:

- para um __design between__, organize os estímulos pelo tipo de item, fazendo uma lista de todos os itens 1, depois 2, depois 3, etc. e apenas distribua os grupos em ordem para cada item (1A, 1B, 1C; 2A, 2B, 2C; etc.) como fizemos na primeira tabela. Desse modo, a coluna "group" estará definindo, de fato, os grupos experimentais, ou seja, algo como o "grupo controle" e os "grupos teste".

- para um __design within__, organize os itens em ordem crescente, um (e apenas um) para cada condição. Esgotados os itens, atribua o grupo A a esse conjunto; recomece a tarefa, organize os itens em ordem crescente, um por condição. Esgotados os itens, atribua o grupo B a esse conjunto (1A, 2A, 3A; 1B, 2B, 3B, etc.); e assim sucessivamente, como fizemos na tabela logo aqui acima. Desse modo, a coluna "group" estará definindo as listas experimentais, já que todos os sujeitos são submetidos a todas as condições, não há de fato "grupos", mas listas de sujeitos.

Como [nos informa um dos criadores do PCIbex](https://www.pcibex.net/forums/topic/choosing-subet-of-items-to-present/page/4/#post-6940):

> _The very function of the group/list column is to control between-subject row selection. All rows that should be presented to the same participant, even those defining different conditions as a result of a within-subject design manipulation, should have the same value in their group/list cell._

Ao final do processo, você terá o desenho experimental que deseja. É claro que você não precisa fazer nessa ordem (se fizer do modo correto, o PCIbex lerá do mesmo jeito), mas, fazendo assim, é mais fácil perceber eventuais erros humanos no processo.

## Montando um desenho misto: parte _between_ e parte _within_
Agora que isso ficou entendido, vamos complicar um pouquinho mais e imaginar um desenho ainda mais complexo, mantendo os mesmos fatores de antes, de modo que todos os sujeitos sejam submetidos a todas as condições (_within_), mas acrescentando um novo, em que um grupo veja uma condição e outro grupo veja outra (_between_).

 - **verbo:** transitivo x intransitivo - _within_
 - **numero:** singular (sg) x plural (pl) - _within_
 - **encaixamento:** encaixada x não encaixada - _between_

Você pode pensar no grupo que verá as sentenças não encaixadas como o grupo controle, por exemplo.

Se fizermos isso, nossa tabela duplicará de tamanho, já que cada um dos quatro itens agora terá uma versão encaixada e uma não encaixada (4 itens x 2 tipos de verbos x 2 tipos de números x 2 tipos de encaixamento = 32 versões dos 4 itens originais).

 {{< highlight r "linenos=table,hl_lines=6-9 14-17 22-25 30-33" >}}
 item,encaixamento,verbo,numero,frase
 1,encaixada,transitivo,sg,Paulo olhou a menina que comeu o bolo.
 2,encaixada,transitivo,pl,João beijou os lobo que mordeu a lebre.
 3,encaixada,intransitivo,sg,Taís ajudou o bruxo que caiu da vassoura.
 4,encaixada,intransitivo,pl,Maria acariciou as gata que chegou tarde.
 1,encaixada,transitivo,pl,Paulo olhou as menina que comeu o bolo.
 2,encaixada,transitivo,sg,João beijou o lobo que mordeu a lebre.
 3,encaixada,intransitivo,pl,Taís ajudou os bruxo que caiu da vassoura.
 4,encaixada,intransitivo,sg,Maria acariciou a gata que chegou tarde.
 1,encaixada,intransitivo,sg,Paulo olhou a menina que dormiu cedo.
 2,encaixada,intransitivo,pl,João beijou os lobo que morreu de fome.
 3,encaixada,transitivo,sg,Taís ajudou o bruxo que beijou a coruja.
 4,encaixada,transitivo,pl,Maria acariciou as gata que bebeu leite.
 1,encaixada,intransitivo,pl,Paulo olhou as menina que dormiu cedo.
 2,encaixada,intransitivo,sg,João beijou o lobo que morreu de fome.
 3,encaixada,transitivo,pl,Taís ajudou os bruxo que beijou a coruja.
 4,encaixada,transitivo,sg,Maria acariciou a gata que bebeu leite.
 1,n_encaixada,transitivo,sg,A menina comeu o bolo.
 2,n_encaixada,transitivo,pl,Os lobo mordeu a lebre.
 3,n_encaixada,intransitivo,sg,O bruxo caiu da vassoura.
 4,n_encaixada,intransitivo,pl,As gata chegou tarde.
 1,n_encaixada,transitivo,pl,As menina comeu o bolo.
 2,n_encaixada,transitivo,sg,O lobo mordeu a lebre.
 3,n_encaixada,intransitivo,pl,Os bruxo caiu da vassoura.
 4,n_encaixada,intransitivo,sg,A gata chegou tarde.
 1,n_encaixada,intransitivo,sg,A menina dormiu cedo.
 2,n_encaixada,intransitivo,pl,Os lobo morreu de fome.
 3,n_encaixada,transitivo,sg,O bruxo beijou a coruja.
 4,n_encaixada,transitivo,pl,As gata bebeu leite.
 1,n_encaixada,intransitivo,pl,As menina dormiu cedo.
 2,n_encaixada,intransitivo,sg,O lobo morreu de fome.
 3,n_encaixada,transitivo,pl,Os bruxo beijou a coruja.
 4,n_encaixada,transitivo,sg,A gata bebeu leite.
 {{< / highlight >}}

#### Primeira solução: errada!
Uma primeira solução para esse problema seria pensar o seguinte: a coluna "group" controla as linhas que são apresentadas aos sujeitos. Logo, se atribuirmos às sentenças "encaixadas" o grupo A e às "não encaixadas" o grupo B, então o PCIbex fará a divisão adequada dos sujeitos nos grupos. Faça isso e veja o que acontece. Se você tiver preguiça de incluir uma nova coluna chamada group com A e B, simplesmente mude o nome da coluna "encaixamento" na tabela acima para "group", desse modo:

{{< highlight r >}}
item,group,verbo,numero,frase
1,encaixada,transitivo,sg,Paulo olhou a menina que comeu o bolo.
2,encaixada,transitivo,pl,João beijou os lobo que mordeu a lebre.
3,encaixada,intransitivo,sg,Taís ajudou o bruxo que caiu da vassoura.
{{< / highlight >}}

O problema será evidente: o mesmo item experimental será mostrado várias vezes ao mesmo sujeito. Na verdade, o sujeito que estiver, digamos, no grupo "encaixada" verá todas as 16 versões de itens aí disponíveis, o que claramente não faz nenhum sentido. Isso ocorre porque nós sinalizamos para o programa fazer a distribuição _between_, mas não a _within_.

#### Segunda solução: agora a correta!
A outra opção seria fazer o que fizemos antes, organizando um conjunto de itens em ordem crescente e então atribuindo uma lista a cada conjunto de itens, mais ou menos como abaixo:

{{< highlight r "linenos=table,hl_lines=18-33" >}}
group,item,encaixamento,verbo,numero,frase
A,1,encaixada,transitivo,sg,Paulo olhou a menina que comeu o bolo.
A,2,encaixada,transitivo,pl,João beijou os lobo que mordeu a lebre.
A,3,encaixada,intransitivo,sg,Taís ajudou o bruxo que caiu da vassoura.
A,4,encaixada,intransitivo,pl,Maria acariciou as gata que chegou tarde.
B,1,encaixada,transitivo,pl,Paulo olhou as menina que comeu o bolo.
B,2,encaixada,transitivo,sg,João beijou o lobo que mordeu a lebre.
B,3,encaixada,intransitivo,pl,Taís ajudou os bruxo que caiu da vassoura.
B,4,encaixada,intransitivo,sg,Maria acariciou a gata que chegou tarde.
C,1,encaixada,intransitivo,sg,Paulo olhou a menina que dormiu cedo.
C,2,encaixada,intransitivo,pl,João beijou os lobo que morreu de fome.
C,3,encaixada,transitivo,sg,Taís ajudou o bruxo que beijou a coruja.
C,4,encaixada,transitivo,pl,Maria acariciou as gata que bebeu leite.
D,1,encaixada,intransitivo,pl,Paulo olhou as menina que dormiu cedo.
D,2,encaixada,intransitivo,sg,João beijou o lobo que morreu de fome.
D,3,encaixada,transitivo,pl,Taís ajudou os bruxo que beijou a coruja.
D,4,encaixada,transitivo,sg,Maria acariciou a gata que bebeu leite.
E,1,n_encaixada,transitivo,sg,A menina comeu o bolo.
E,2,n_encaixada,transitivo,pl,Os lobo mordeu a lebre.
E,3,n_encaixada,intransitivo,sg,O bruxo caiu da vassoura.
E,4,n_encaixada,intransitivo,pl,As gata chegou tarde.
F,1,n_encaixada,transitivo,pl,As menina comeu o bolo.
F,2,n_encaixada,transitivo,sg,O lobo mordeu a lebre.
F,3,n_encaixada,intransitivo,pl,Os bruxo caiu da vassoura.
F,4,n_encaixada,intransitivo,sg,A gata chegou tarde.
G,1,n_encaixada,intransitivo,sg,A menina dormiu cedo.
G,2,n_encaixada,intransitivo,pl,Os lobo morreu de fome.
G,3,n_encaixada,transitivo,sg,O bruxo beijou a coruja.
G,4,n_encaixada,transitivo,pl,As gata bebeu leite.
H,1,n_encaixada,intransitivo,pl,As menina dormiu cedo.
H,2,n_encaixada,intransitivo,sg,O lobo morreu de fome.
H,3,n_encaixada,transitivo,pl,Os bruxo beijou a coruja.
H,4,n_encaixada,transitivo,sg,A gata bebeu leite.
{{< / highlight >}}

Vamos tentar entender o que estamos fazendo aqui e o porquê isso funciona:

- Primeiro, agora temos 8 listas experimentais (de A até H);
- Os sujeitos submetidos às listas de A até D só veem sentenças encaixadas (grupo teste ou fator _between_), mas eles veem todas as condições de "verbo" e de "número" (fatores _within_);
- Os sujeitos submetidos às listas de E até H só veem sentenças não encaixadas (grupo controle ou fator _between_), mas eles veem todas as condições de "verbo" e de "número" (fator _within_).

Mas não fique parado aqui olhando para essa tabela: crie um _script_ (ou copie e cole o primeiro que usamos [aqui](https://igordeo-costa.github.io/posts/pcibextutorial04/)) e veja a mágica em funcionamento.

Feito isso, basta organizar uma tabela de distratoras, aleatorizar tudo como vimos na [Parte 03](https://igordeo-costa.github.io/posts/pcibextutorial03/) e ser feliz.

Mas ainda não vimos como tomar medidas repetidas dos participantes por condição, ou seja, como fazer para que o mesmo participante seja submetido a vários itens da mesma condição e não a apenas um, como até agora estamos fazendo.

## Tomando medidas repetidas por condição de cada sujeito
Vamos ver, então, como submeter o mesmo sujeito a vários itens na mesma condição. Para tanto, vamos tomar apenas as sentenças encaixadas e criar mais 4 itens para esse conjunto de dados, de modo que tenhamos um total de 8 itens experimentais e, portanto, 32 versões de cada item, como abaixo:

{{< highlight r "linenos=table,hl_lines=2 6 10 14 18 22 26 30" >}}
group,item,encaixamento,verbo,numero,frase
A,1,encaixada,transitivo,sg,Paulo olhou a menina que comeu o bolo.
B,1,encaixada,transitivo,pl,Paulo olhou as menina que comeu o bolo.
C,1,encaixada,intransitivo,sg,Paulo olhou a menina que dormiu cedo.
D,1,encaixada,intransitivo,pl,Paulo olhou as menina que dormiu cedo.
A,2,encaixada,transitivo,pl,João beijou os lobo que mordeu a lebre.
B,2,encaixada,transitivo,sg,João beijou o lobo que mordeu a lebre.
C,2,encaixada,intransitivo,pl,João beijou os lobo que morreu de fome.
D,2,encaixada,intransitivo,sg,João beijou o lobo que morreu de fome.
A,3,encaixada,intransitivo,sg,Taís ajudou o bruxo que caiu da vassoura.
B,3,encaixada,intransitivo,pl,Taís ajudou os bruxo que caiu da vassoura.
C,3,encaixada,transitivo,sg,Taís ajudou o bruxo que beijou a coruja.
D,3,encaixada,transitivo,pl,Taís ajudou os bruxo que beijou a coruja.
A,4,encaixada,intransitivo,pl,Maria acariciou as gata que chegou tarde.
B,4,encaixada,intransitivo,sg,Maria acariciou a gata que chegou tarde.
C,4,encaixada,transitivo,pl,Maria acariciou as gata que bebeu leite.
D,4,encaixada,transitivo,sg,Maria acariciou a gata que bebeu leite.
A,5,encaixada,transitivo,sg,Pedro aplaudiu o jogador que virou o jogo.
B,5,encaixada,transitivo,pl,Pedro aplaudiu os jogador que virou o jogo.
C,5,encaixada,intransitivo,sg,Pedro aplaudiu o jogador que escorregou no jogo.
D,5,encaixada,intransitivo,pl,Pedro aplaudiu os jogador que escorregou no jogo.
A,6,encaixada,transitivo,pl,Lua visitou as freira que alimentou o mendigo.
B,6,encaixada,transitivo,sg,Lua visitou a freira que alimentou o mendigo.
C,6,encaixada,intransitivo,pl,Lua visitou as freira que saiu da igreja.
D,6,encaixada,intransitivo,sg,Lua visitou a freira que saiu da igreja.
A,7,encaixada,intransitivo,sg,Josemar seduziu a moça que escorregou na poça.
B,7,encaixada,intransitivo,pl,Josemar seduziu as moça que escorregou na poça.
C,7,encaixada,transitivo,sg,Josemar seduziu a moça que cantou a música.
D,7,encaixada,transitivo,pl,Josemar seduziu as moça que cantou a música.
A,8,encaixada,intransitivo,pl,Juliana atingiu o rapaz que sai do ônibus.
B,8,encaixada,intransitivo,sg,Juliana atingiu o rapaz que sai do ônibus.
C,8,encaixada,transitivo,sg,Juliana atingiu o rapaz que chutou o gato.
D,8,encaixada,transitivo,pl,Juliana atingiu os rapaz que chutou o gato.
{{< / highlight >}}

 O que fizemos acima pode parecer muito confuso e complexo, mas não é. Observe as marcações do grupo A, que reproduzimos na tabela abaixo:

 |group|verbo|numero|frase|item|
 |---------|-----|------|-----|----|
 |A|transitivo|sg|Paulo olhou a menina que comeu o bolo.|1|
 |A|transitivo|pl|João beijou os lobo que mordeu a lebre.|2|
 |A|intransitivo|sg|Taís ajudou o bruxo que caiu da vassoura.|3|
 |A|intransitivo|pl|Maria acariciou as gata que chegou tarde.|4|
 |A|transitivo|sg|Pedro aplaudiu o jogador que virou o jogo.|5|
 |A|transitivo|sg|Lua visitou as freira que alimentou o mendigo.|6|
 |A|intransitivo|sg|Josemar seduziu a moça que escorregou na poça.|7|
 |A|intransitivo|pl|Juliana atingiu o rapaz que sai do ônibus.|8|

 Agora, se quiser, faça uma tabela semelhante para o Grupo B. Como você pode ver, para organizar rapidamente esse tipo de tabela, basta organizar os itens em ordem crescente (de 1 até 8) e atribuir a todo esse conjunto o Grupo A; em seguida, organize um segundo conjunto de 1 até 8 e atribua o Grupo B; o mesmo para o grupo C e D. No caso, em questão, cada sujeito verá 2 itens em cada uma das 4 condições.

 Se você tiver mais itens, digamos, 12 itens, basta organizá-los em conjuntos de 1 até 12 e aplicar os grupos por conjuntos de itens.

 Abaixo vamos reescrever a mesma tabela acima organizada dessa maneira (observe que ambas funcionam igualmente bem para o PCIbex):

 {{< highlight r "linenos=table,hl_lines=10-17 26-32" >}}
 group,item,encaixamento,verbo,numero,frase
 A,1,encaixada,transitivo,sg,Paulo olhou a menina que comeu o bolo.
 A,2,encaixada,transitivo,pl,João beijou os lobo que mordeu a lebre.
 A,3,encaixada,intransitivo,sg,Taís ajudou o bruxo que caiu da vassoura.
 A,4,encaixada,intransitivo,pl,Maria acariciou as gata que chegou tarde.
 A,5,encaixada,transitivo,sg,Pedro aplaudiu o jogador que virou o jogo.
 A,6,encaixada,transitivo,pl,Lua visitou as freira que alimentou o mendigo.
 A,7,encaixada,intransitivo,sg,Josemar seduziu a moça que escorregou na poça.
 A,8,encaixada,intransitivo,pl,Juliana atingiu o rapaz que sai do ônibus.
 B,1,encaixada,transitivo,pl,Paulo olhou as menina que comeu o bolo.
 B,2,encaixada,transitivo,sg,João beijou o lobo que mordeu a lebre.
 B,3,encaixada,intransitivo,pl,Taís ajudou os bruxo que caiu da vassoura.
 B,4,encaixada,intransitivo,sg,Maria acariciou a gata que chegou tarde.
 B,5,encaixada,transitivo,pl,Pedro aplaudiu os jogador que virou o jogo.
 B,6,encaixada,transitivo,sg,Lua visitou a freira que alimentou o mendigo.
 B,7,encaixada,intransitivo,pl,Josemar seduziu as moça que escorregou na poça.
 B,8,encaixada,intransitivo,sg,Juliana atingiu o rapaz que sai do ônibus.
 C,1,encaixada,intransitivo,sg,Paulo olhou a menina que dormiu cedo.
 C,2,encaixada,intransitivo,pl,João beijou os lobo que morreu de fome.
 C,3,encaixada,transitivo,sg,Taís ajudou o bruxo que beijou a coruja.
 C,4,encaixada,transitivo,pl,Maria acariciou as gata que bebeu leite.
 C,5,encaixada,intransitivo,sg,Pedro aplaudiu o jogador que escorregou no jogo.
 C,6,encaixada,intransitivo,pl,Lua visitou as freira que saiu da igreja.
 C,7,encaixada,transitivo,sg,Josemar seduziu a moça que cantou a música.
 C,8,encaixada,transitivo,sg,Juliana atingiu o rapaz que chutou o gato.
 D,1,encaixada,intransitivo,pl,Paulo olhou as menina que dormiu cedo.
 D,2,encaixada,intransitivo,sg,João beijou o lobo que morreu de fome.
 D,3,encaixada,transitivo,pl,Taís ajudou os bruxo que beijou a coruja.
 D,4,encaixada,transitivo,sg,Maria acariciou a gata que bebeu leite.
 D,5,encaixada,intransitivo,pl,Pedro aplaudiu os jogador que escorregou no jogo.
 D,6,encaixada,intransitivo,sg,Lua visitou a freira que saiu da igreja.
 D,7,encaixada,transitivo,pl,Josemar seduziu as moça que cantou a música.
 D,8,encaixada,transitivo,pl,Juliana atingiu os rapaz que chutou o gato.
 {{< / highlight >}}

## Rodando o nosso experimento completo (até aqui)
Feito isso, já podemos pensar em rodar nossa experimento "completo" (mas apenas por enquanto): vamos mantê-lo com o conjunto de frases experimentais em que tínhamos encaixadas e não encaixadas como fator _between_ (não esse último que vimos, mas o anterior) e o conjunto abaixo de frases distratoras (como cada lista vê apenas 4 sentenças experimentais, coloquemos o triplo de distratoras):

{{< highlight r "linenos=table,hl_lines=18-33" >}}
group,frase
dist,Distratora 1.
dist,Distratora 2.
dist,Distratora 3.
dist,Distratora 4.
dist,Distratora 5.
dist,Distratora 6.
dist,Distratora 7.
dist,Distratora 8.
dist,Distratora 9.
dist,Distratora 10.
dist,Distratora 11.
dist,Distratora 12.
{{< / highlight >}}

Ambas essas tabelas .csv devem entrar na aba ```Resources```. E o código abaixo será o que rodaremos:

{{< highlight js >}}
PennController.ResetPrefix(null)

Sequence("instrucao", rshuffle("distratoras", "experimentais"))

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

Feito isso, podemos avançar para inclusão de perguntas de compreensão para cada sentença, o que faremos na [Parte 6](https://igordeo-costa.github.io/posts/pcibextutorial06/).
