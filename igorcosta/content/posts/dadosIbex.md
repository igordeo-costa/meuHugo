---
title: "Acessando dados do Ibex e PCIbex com o R"
tags: ["Ibex Farm", "PCIbex", "R stringr"]
date: 2021-04-08T19:37:46-03:00
---
O objetivo deste artigo é mostrar como você pode acessar facilmente os resultados do seu experimento do [Ibex Farm](https://spellout.net/ibexfarm/) ou do [PCIbex](https://doc.pcibex.net/) usando o R, sobretudo com as funcionalidades do pacote [stringr](https://www.rdocumentation.org/packages/stringr/versions/1.4.0) para separar em múltiplas colunas as variáveis que compõem as condições experimentais, geralmente disponíveis em uma única coluna.

# Acessando os dados do Ibex Farm
Eu já falei um pouquinho [aqui](https://igordeo-costa.github.io/posts/escalalikert/) sobre acesso aos dados do Ibex Farm. Como disse por lá, a melhor forma, a meu ver, é usar o pacote [ibextor](https://github.com/antonmalko/ibextor), que tem uma função para cada tipo de controlador disponível, ou seja, uma para extrair dados de leitura automonitorada (`get_results_ds`), sendo o `ds` uma abreviação de "DashedSentence"; uma para extrair os dados de julgamento de aceitabilidade (`get_results_aj`), sendo o `aj` de "AcceptabilityJudgment"; uma para extrair os dados de questionários (`get_results_q`), sendo o `q`, obviamente, de "Question"; e uma para extrair os dados de julgamento de aceitabilidade em que o falante moninota a leitura da sentença (`get_results_daj`), sendo o `daj` de "DashedAcceptabilityJudgment" feito com sentença.

Sendo assim, para tornar os dados de *output* do Ibex legíveis, basta você usar como argumento para uma dessas funções o `PATH` do seu arquivo .csv, ou seja, basta dar a localização desse arquivo no seu computador, como no exemplo que dei lá no outro post:

 ```
 dados<-get_results_aj("/home/dados/Acadêmicos/Doutorado/EXPERIMENTOS_2021/EscalaLikert/Resultados.csv")
 ```
E é só! Mais nada! Você não precisa ficar tentando limpar os dados no Excel ou coisa semelhante. Com apenas essa linha de código você já tem uma tabela normal, com cada dado em uma coluna, como mostra o resultado abaixo (não se assuste com a mensagem dada pela função, ela só está dizendo que apagou algumas colunas inúteis):

```
> head(dados)
  subj presentation_order   type item                                                                                          question answer quest_rt
1    1                  5 Treino NULL A parte destacada da frase (em negrito) é compatível com a parte não destacada (em fonte normal).      4    51328
2    1                  6 Treino NULL A parte destacada da frase (em negrito) é compatível com a parte não destacada (em fonte normal).      2    29362
3    1                  7 Treino NULL A parte destacada da frase (em negrito) é compatível com a parte não destacada (em fonte normal).      5     6666
4    1                 58    D_2 NULL A parte destacada da frase (em negrito) é compatível com a parte não destacada (em fonte normal).      5    16914
5    1                 91   D_35 NULL A parte destacada da frase (em negrito) é compatível com a parte não destacada (em fonte normal).      5     9465
6    1                 87   D_31 NULL A parte destacada da frase (em negrito) é compatível com a parte não destacada (em fonte normal).      5    13327
                                                                                                                     sentence                                    subj_uid
1                       O jogador de futebol que foi convocado compareceu no horário%2C <b>mas não estava em plena forma.</b> 1615578921_9b55b3473cc4d662de9e8d3c82557742
2           Os professores de judô da academia se encontraram para o treino%2C <b>mas eles não tinha esquecido o quimono.</b> 1615578921_9b55b3473cc4d662de9e8d3c82557742
3                                   As frutas caíram da árvore mais cedo no verão%2C <b>mas a garotada comeu assim mesmo.</b> 1615578921_9b55b3473cc4d662de9e8d3c82557742
4        A loja de frutas da praça principal da cidade não abriu naquele dia%2C <b>mas vendia produtos sempre excelentes.</b> 1615578921_9b55b3473cc4d662de9e8d3c82557742
5                   A viagem de fim de semana não foi como o esperado pelo grupo <b>porque eles não planejaram muito bem.</b> 1615578921_9b55b3473cc4d662de9e8d3c82557742
6 O intelectual buscou escrever uma obra compreensível para o público%2C <b>mas o acadêmico esperava demais dos leitores.</b> 1615578921_9b55b3473cc4d662de9e8d3c82557742
```
Esses dados podem parecer bagunçados, mas eles na verdade já estão no formato que desejamos. Eles só parecem meio loucos porque há algumas colunas com frases inteiras das quais nós até podemos eventualmente precisar, mas que, nesse momento, não nos interessam. Por isso, podemos simplesmente fazer uma limpeza desses dados, jogando fora essas colunas (perceba que você não está modificando em nada seu arquivo original, que está "muito bem, obrigado", guardado do jeito que saiu do Ibex, na pasta onde você o deixou. Nós estamos aqui trabalhando com uma cópia bonita dele.)

Se você quiser vê-los com mais clareza, basta fazer uma exclusão dessas colunas inúteis com o pacote `dplyr`:

```
dados<-dados %>%
  select(-c(question, sentence, subj_uid))
```
Observe o sinal de menos antes da função concatenar `-c()`, indicando que você quer uma seleção que *não inclua* as colunas ali especificadas. O resultado será algo assim (bem mais amigável!):

```
> head(dados, 12)
   subj presentation_order         type item answer quest_rt
1     1                  5       Treino NULL      4    51328
2     1                  6       Treino NULL      2    29362
3     1                  7       Treino NULL      5     6666
4     1                 58          D_2 NULL      5    16914
5     1                 91         D_35 NULL      5     9465
6     1                 87         D_31 NULL      5    13327
7     1                 56 e.todo-um_PL   12      2     9433
8     1                 80         D_24 NULL      5    13869
9     1                 89         D_33 NULL      5     6917
10    1                 62          D_6 NULL      5    13107
11    1                 61          D_5 NULL      5     8330
12    1                 51 e.todo-um_SG   11      2    12583
```
Perceba que partimos de um conjunto de dados intragáveis, praticamente impossíveis de manipular ou de serem abertos no Excel para uma tabelinha linda e maravilhosa. E isso usando apenas duas ou três linhas de código. Mas aí chegamos a um ponto em que muita gente empaca: separar as variáveis que compõem as condições em colunas diferentes. Isso, contudo, também é muito fácil: basta usar o pacote `stringr`.

Observe nos dados acima que a coluna "type" contém as etiquetas para as frases de Treino, para as Distratoras (iniciadas com "D_") e para as experimentais (iniciadas com um "e."). Devemos, então, ficar apenas com as experimentais, que é o que nos interessa nesse momento. Vamos fazer isso em um passo simples: filtrar apenas as sentenças experimentais com a função `filter`, do pacote `dplyr`, e a função `str_detect`, do pacote `stringr`:

```
dados <- dados %>%
  filter(str_detect(type, "^e"))
```
A função `str_detect` buscou na coluna "type" apenas os elementos começados (o sinal de `^`) com a letra "e", ou seja, os nossos itens experimentais, que já estavam marcados assim desde o Ibex, inclusive para garantir a aleatorização durante a apresentação do experimento. O resultado agora ficou assim:

```
> head(dados)
  subj presentation_order         type item answer quest_rt
1    1                 56 e.todo-um_PL   12      2     9433
2    1                 51 e.todo-um_SG   11      2    12583
3    1                 14 e.um-todo_PL    2      5    18145
4    1                 41 e.um-todo_SG    9      5     9728
5    1                 25 e.um-todo_SG    5      5    15724
6    1                 30 e.um-todo_PL    6      2    21496
```
 O maior problema é que os fatores estudados (nesse caso, a Ordem dos quantificadores - um-todo e todo-um) e o Número da anáfora (SG e PL) estão numa mesma coluna ("type") e a gente precisa deles em duas colunas diferentes. Para isso, vamos usar a função `separate` do pacote `tidyr`, irmão do `dplyr`:

 ```
 dados <- dados %>%
  separate(type, c("Ordem", "Num"), "[_]")
 ```
O resultado será algo assim:

```
> head(dados)
  subj presentation_order     Ordem Num item answer quest_rt
1    1                 56 e.todo-um  PL   12      2     9433
2    1                 51 e.todo-um  SG   11      2    12583
3    1                 14 e.um-todo  PL    2      5    18145
4    1                 41 e.um-todo  SG    9      5     9728
5    1                 25 e.um-todo  SG    5      5    15724
6    1                 30 e.um-todo  PL    6      2    21496
```
Com ele em mãos, fica mais fácil entender a função: ela recebeu como *input* a coluna "type", criou duas novas colunas, uma chamada "Ordem" e outra chamada "Num" (você pode chamá-las como quiser, obviamente) e usou o *underline* como elemento de separação. Logo, onde havia *underline* nos dados originais, ou seja, justamente antes de SG ou PL, a função fez a separação. Mas ainda temos um problema: na coluna ordem, não queremos aquele "e." antes de "todo-um" ou "um-todo". Usemos de novo `separate`, mas agora com o ponto final (.) como elemento de separação:

```
dados <- dados %>%
  separate(Ordem, c("a", "Ordem"), "[.]")
```
O resultado será algo assim, com uma coluna, de nome "a" inútil.

```
head(test)
 subj presentation_order a   Ordem Num item answer quest_rt
1    1                 56 e todo-um  PL   12      2     9433
2    1                 51 e todo-um  SG   11      2    12583
3    1                 14 e um-todo  PL    2      5    18145
4    1                 41 e um-todo  SG    9      5     9728
5    1                 25 e um-todo  SG    5      5    15724
6    1                 30 e um-todo  PL    6      2    21496
```
Você pode simplesmente excluir essa coluna com a função `select`:

```
dados <- dados %>%
  select(-a)
```
E pronto, seus dados estão super limpos e organizados.

Pode parecer muito porque fomos fazendo passo a passo a fim de facilitar a compreensão, mas, no final das contas, o código todo tem apenas seis linhas. É ridiculamente simples para toda a tarefa que ele desempenhou e que ficaríamos horas para fazer, digamos, no Excel, sem contar com os possíveis erros humanos advindos do processo. Eis o código completo:

```
dados<-dados %>%
  select(-c(question, sentence, subj_uid)) %>%
  filter(str_detect(type, "^e")) %>%
  separate(type, c("Ordem", "Num"), "[_]") %>%
  separate(Ordem, c("a", "Ordem"), "[.]") %>%
  select(-a)
```

# Acessando os dados do PCIbex
No PCIbex as coisas são ainda mais fáceis, já que você não precisa de uma função para cada tipo de controlador. Basta usar a função `read.pcibex`, disponibilizada pelos autores [aqui](https://doc.pcibex.net/how-to-guides/data-transformation/), passando, como sempre, o `PATH` do seu arquivo como argumento da função.(Os dados aqui usamos me foram gentilmente cedidos pela amiga Ana Paula).

```
dados<-read.pcibex("/home/igor/Downloads/results.txt")
```
Como no caso anterior, você terá um monte de colunas, muitas das quais você não precisa:

```
> head(dados)
  Results.reception.time MD5.hash.of.participant.s.IP.address Controller.name Order.number.of.item Inner.element.number Label Latin.Square.Group PennElementType PennElementName Parameter Value    EventTime        id  age   birth     live                     school Comments
1             1617327899     28783ca8d9607ccae99087129ad2830b  PennController                    1                    0  TCLE               NULL  PennController               0   _Trial_ Start 1.617328e+12 undefined NULL                                                     
2             1617327899     28783ca8d9607ccae99087129ad2830b  PennController                    1                    0  TCLE               NULL  PennController               0  _Header_ Start 1.617328e+12 undefined NULL                                                     
3             1617327899     28783ca8d9607ccae99087129ad2830b  PennController                    1                    0  TCLE               NULL  PennController               0  _Header_   End 1.617328e+12 undefined NULL                                                     
4             1617327899     28783ca8d9607ccae99087129ad2830b  PennController                    1                    0  TCLE               NULL  PennController               0   _Trial_   End 1.617328e+12 undefined NULL                                                     
5             1617327899     28783ca8d9607ccae99087129ad2830b  PennController                    2                    0  info               NULL  PennController               1   _Trial_ Start 1.617328e+12 undefined   34 xdfgsdg sdsdsdfg Ensino Superior incompleto     NULL
6             1617327899     28783ca8d9607ccae99087129ad2830b  PennController                    2                    0  info               NULL  PennController               1  _Header_ Start 1.617328e+12 undefined   34 xdfgsdg sdsdsdfg Ensino Superior incompleto     NULL
```

Livre-se delas com a função `select`, do `dplyr`:

```
dados<-dados %>%
  select(-c(Results.reception.time,
            MD5.hash.of.participant.s.IP.address,
            Controller.name,
            Latin.Square.Group,
            PennElementType,
            PennElementName,
            school,
            live,
            Comments))
```

E você terá algo assim:
```
> head(dados)
  Order.number.of.item Inner.element.number Label Parameter Value    EventTime        id  age   birth
1                    1                    0  TCLE   _Trial_ Start 1.617328e+12 undefined NULL        
2                    1                    0  TCLE  _Header_ Start 1.617328e+12 undefined NULL        
3                    1                    0  TCLE  _Header_   End 1.617328e+12 undefined NULL        
4                    1                    0  TCLE   _Trial_   End 1.617328e+12 undefined NULL        
5                    2                    0  info   _Trial_ Start 1.617328e+12 undefined   34 xdfgsdg
6                    2                    0  info  _Header_ Start 1.617328e+12 undefined   34 xdfgsdg
```
Como anteriormente, você precisará investigar os seus dados. Nesse caso, as informações de que precisamos estão na coluna "Label". Você pode investigar a composição dessa coluna com a função `unique`:

```
> unique(dados$Label)
 [1] "TCLE"         "info"         "instructions" "treino"       "A-3"          "distL-5"      "B-1"          "distT-5"      "C-2"          "distSi-2"     "F-3"          "distR-1"      "E-4"          "distR-3"      "D-1"          "distR-5"      "G-4"          "distSi-8"    
[19] "H-3"          "distSi-3"     "B-2"          "distSi-1"     "A-2"          "distSi-5"     "D-3"          "H-4"          "distSi-4"     "F-4"          "distT-3"      "distT-8"      "E-2"          "distR-6"      "C-4"          "distL-1"      "distT-1"      "distSe-5"    
[37] "B-4"          "H-1"          "distSe-6"     "distL-8"      "D-4"          "distL-3"      "G-1"          "distR-4"      "D-2"          "distT-6"      "distR-2"      "C-3"          "distL-7"      "F-1"          "distSe-8"     "F-2"          "distT-4"      "E-3"         
[55] "A-4"         
```
Observe que aqui temos várias informações de que não precisamos: "TCLE", "treino", "info", "instructions" e todas as distratoras, que são de vários tipos, mas começam invariavelmente com "dist". As sentenças experimentais, por sua vez, não começam com uma letra específica, como "e". Logo, não temos uma informação recorrente para poder filtrar apenas as experimentais a partir dela. Vamos, então, primeiro eliminar o que não queremos e deixar só as experimentais:

```
dados <- dados %>%
  filter(!Label %in% c("TCLE", "treino", "info", "instructions")) %>%
  filter(!str_detect(Label, "^dist"))
```
Repare que a única coisa que fizemos de diferente aí foi usar o sinal de exclamação (`!`) na função `filter`, indicando negação: ou seja, queremos ficar com tudo que não seja o que está especificado nessas funções. Observe também o uso da função `str_detect`, que também foi negada, ou seja, queremos apenas o que não é distratora, ou seja, o que não começa com dist (`^dist`). O resultado é esse, com apenas as sentenças experimentais na coluna "Label":

```
head(dados)
 Order.number.of.item Inner.element.number Label Parameter Value    EventTime        id  age birth
1                    8                    0   A-3   _Trial_ Start 1.617328e+12 undefined NULL      
2                    8                    0   A-3  _Header_ Start 1.617328e+12 undefined NULL      
3                    8                    0   A-3  _Header_   End 1.617328e+12 undefined NULL      
4                    8                    0   A-3         1  João 1.617328e+12 undefined  159 false
5                    8                    0   A-3         2 levou 1.617328e+12 undefined  153 false
6                    8                    0   A-3         3 todos 1.617328e+12 undefined  152 false
```
Com isso, basta o passo final com a função `separate`, do `tidyr`:

```
dados <- dados %>%
  separate(Label, c("Cond", "Item"), "[-]")
```
Observe que o elemento separador aqui é o traço simples (-) e não o *underline*. O resultado será assim:

```
> head(dados)
  Order.number.of.item Inner.element.number Cond Item Parameter Value    EventTime        id  age birth
1                    8                    0    A    3   _Trial_ Start 1.617328e+12 undefined NULL      
2                    8                    0    A    3  _Header_ Start 1.617328e+12 undefined NULL      
3                    8                    0    A    3  _Header_   End 1.617328e+12 undefined NULL      
4                    8                    0    A    3         1  João 1.617328e+12 undefined  159 false
5                    8                    0    A    3         2 levou 1.617328e+12 undefined  153 false
6                    8                    0    A    3         3 todos 1.617328e+12 undefined  152 false
```
Exatamente o que precisávamos! Novamente, o código para fazer isso tudo é ridiculamente pequeno: ele tem, de fato, apenas 5 linhas!

```
dados<-dados %>%
  select(-c(Results.reception.time,
            MD5.hash.of.participant.s.IP.address,
            Controller.name,
            Latin.Square.Group,
            PennElementType,
            PennElementName,
            school,
            live,
            Comments)) %>%
  filter(!Label %in% c("TCLE", "treino", "info", "instructions")) %>%
  filter(!str_detect(Label, "^dist")) %>%
  separate(Label, c("Cond", "Item"), "[-]")
```
O pacote `stingr` é de fato muito útil e teria me poupado muita dor de cabeça se eu o tivesse conhecido antes. Se você quiser vê-lo sendo usado para fazer umas coisas mais poderosas, dê uma olhada nos primeiros minutos [desse vídeo](https://www.youtube.com/watch?v=_1msVvPE_KY), da diva do R [Julia Silge](https://juliasilge.com/), e divirta-se!
