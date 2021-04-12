---
title: "Instalando o R pela primeira vez"
tags: ["O básico do R"]
date: 2021-04-11T22:18:25-03:00
---
Esse artigo -- feito à pedido da minha amiga Ana Paula -- tem por objetivo apresentar o R e o R Studio, fornecendo um passo a passo muito básico de como instalá-los. Ao final desse texto, acreditamos que você estará mais informado sobre o que é o R e sobre as diferenças entre ele e o R Studio.

### O que é o R?
R é uma linguagem de programação e, ao mesmo tempo, um ambiente de trabalho para análise estatística, ou seja, é uma ferramenta específica para a manipulação de dados numéricos, produção de gráficos e modelagens estatísticas, das mais simples às mais complexas. O R (ou [R project](https://www.r-project.org/)) é uma ferramenta gratuita, parte do [Projeto GNU](https://www.gnu.org/gnu/thegnuproject.pt-br.html) e é mantido pela [R Foundation](https://www.r-project.org/foundation/), uma organização sem fins lucrativos.

### Por que usar o R?
Sucintamente, podemos dizer que [o R tem se tornado rapidamente uma das ferramentas estatísticas mais utilizadas no planeta](http://r4stats.com/articles/popularity/). Os motivos para isso são muitos, como já sugeria o [New York Times em 2009](https://www.nytimes.com/2009/01/07/technology/business-computing/07program.html), mas abaixo eu listo os que, para mim, são mais convincentes:

1. É gratuito: enquanto os programas de análise de dados como o SPSS (IBM) ou SAS (SAS Institute) custam pequenas fortunas, o R pode ser baixado da internet e usado imediatamente por qualquer um, seja por uma pessoa física seja por uma instituição.

2. É o mais usado pela comunidade: na área da psicolinguística, pelo menos desde os artigos já clássicos de [Jaeger (2008)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2613284/) e [Baayen, Davidson & Bates (2008)](https://www.sciencedirect.com/science/article/pii/S0749596X07001398), que apresentaram de forma ampla à comunidade uma solução para o problema colocado desde 1973 por [Clark](https://www.sciencedirect.com/science/article/abs/pii/S0022537173800143), o R parece ter se tornado a ferramenta mais utilizada pela comunidade mundial. Os artigos em geral apresentam os dados como analisados pelo R, as universidades oferecem cursos de R, os gráficos são produzidos com o R. Enfim, se você pretende se inserir de algum modo nessa comunidade, o R parece ser, se não essencial, pelo menos um facilitador.

3. É o que tem mais ajuda *online*: basicamente, se você precisa fazer alguma coisa no R, basta procurar no Google que uma resposta surgirá sem muito esforço, seja uma tarefa básica seja uma coisa muito complexa e difícil. E, se você não achar, basta colocar em algum fórum que alguém aparecerá para lhe ajudar em algum momento. Além disso, há milhares de tutoriais para o R disponíveis gratuitamente, como o de Modelos Mistos da [professora Mahayana Godoy](https://mahayana.me/mlm/), da UFRN. Para os programas pagos, em geral, é preciso contratar uma assistência especializada.

4. É o mais flexível: a menos que você seja um *data analyst* com habilidade de sobra para trabalhar com *python* ou com outras ferramentas avançadas, é pouco provável que consiga algo mais versátil do que o R. Com ele você pode manipular tabelas longas e complexas que travariam o seu Excel em pouco tempo; ou pode implementar complexos modelos bayesianos de regressão ordinal; ou elaborar gráficos interessantes, claros e informativos ótimos para impressionar nas apresentações; ou filtrar milhares de linhas de dados em segundos... Tudo isso usando a mesma ferramenta e a mesma linguagem de programação. Mais do que isso, você pode automatizar uma série de processos ANTES de elaborar o seu experimento, por exemplo, e daí economizar muito tempo na hora da análise final quando ele finalmente estiver pronto.

### Usar o R é muito difícil?
Sendo sincero, "sim" e "não". Se você está começando a programar, descobrirá muito rapidamente que a lógica de trabalho com o R é muito diferente da lógica dos programas com os quais está acostumado a lidar. Por exemplo, se você tem por hábito manipular seus dados no Excel, onde tudo é feito apertando botões em uma interface amigável, no máximo escrevendo uma função ou outra, terá que "virar algumas chaves" na sua cabeça, porque não é assim que o R funciona.

Esse processo pode demorar um pouco mais ou um pouco menos, mas certamente você terá que escalar uma curva de aprendizagem até estar minimamente habilitado para usar o R. O problema é que, no começo, o processo pode se mostrar bem frustrante: inúmeras vezes você quererá fazer uma manipulação mais complexa com a qual já está acostumado e, quando for fazê-la no R, receberá seguidas vezes uma irritante mensagem de erro. Pior! Você não terá a mínima ideia de por que diabos a tal mensagem aparece. Pior! Você checará dezenas de vezes as etapas do processo e terá certeza de que fez tudo certo. Mas a verdade é que não fez...

O que nós recomendamos é: não desista! Procure ajuda, pesquise no Google pelo código de erro que você está recebendo, pergunte para alguém, descanse e retorne ao problema com a cabeça fria num outro dia. Você vai eventualmente entendê-lo e ele se tornará óbvio. E então algum outro surgirá para te perturbar. É normal. E quando você menos esperar, estará fazendo coisas que seus companheiros de Excel jamais sonham alcançar. Enquanto eles estarão passando horas tentando arrancar os dados de uma planilha do [Ibex Farm](https://spellout.net/ibexfarm/), você fará isso com uma linha de código; enquanto eles buscam manualmente corrigir erros de digitação em uma longa lista de condições experimentais, você corrigirá tudo, com 100% de confiança, livre dos erros humanos, em menos de trinta segundos; enquanto eles estiverem passando perrengues para responder aquele parecerista que encrencou -- corretamente, eu diria -- com as suas belas ANOVAs, você estará fazendo os mais precisos modelos mistos que qualquer parecerista pudesse querer.

Em resumo, no início, o R te consumirá algum tempo e alguns fios de cabelo, mas, no final, facilitará em muito o seu trabalho com dados, de modo que você possa passar mais tempo debruçado sobre a teoria do que executando tarefas repetitivas no Excel.

### O que é o R RStudio?
O R Studio é uma IDE (Integrated Development Environment ou Ambiente de Desenvolvimento Intregrado) para o R, mas o que é uma IDE, afinal? Se você nunca programou antes, entender uma IDE pode ser um pouco complicado, mas, para o nosso caso, a ideia é que o R Studio funcione como um programa que facilita o manejo do R, uma espécie de interface mais amigável entre o R (o programa cru, digamos assim) e o usuário.

Por exemplo, se você estiver usando apenas o R, tudo a que terá acesso será um ambiente chamado "console". Nesse console, você poderá digitar comandos para que o R execute determinadas tarefas. No entanto, esses comandos aparecerão em fontes de cor única. Ao usar o R Studio, no entanto, você terá acesso a um "terminal" (chamado de *syntax-highlighting editor*), ou seja, a um espaço em que os comandos serão coloridos de acordo com o tipo de propriedade que cada parte do comando tem, facilitando muito a percepeção de códigos equivocados ou problemáticos de algum modo. Compare as imagens abaixo, por exemplo, em que temos o mesmo código no "terminal" do R Studio e no "console" do R, respectivamente.

![Comparação Console x Terminal](/Rimg.png)

Além disso, o R Studio apresenta uma série de paineis customizáveis em que você pode visualizar mais facilmente os seus dados, os seus gráficos ou mesmo investigar o histórico de comandos usados, manipular o seu ambiente de trabalho e um conjunto de outras funções. Dentre essas, ele apresenta, por exemplo, um "debugger", ou seja, o programa te dá algumas dicas, indicando quando o seu código viola certas regras de programação.

Se quiser saber mais sobre as funcionalidades do R Studio, dê uma olhada [neste link](https://www.rstudio.com/products/rstudio/features/).

#### O que o R Studio não é:
O R Studio não vai transformar o R em uma ferramenta que não precisa de programação. Para isso, existem outros projetos, como o [Action](http://www.portalaction.com.br/), que você pode tentar também. Saiba, no entanto, que usando o Action (ou outra ferramenta semelhante), você não terá a flexibilidade que terá com o R Studio. Muitas funcionalidades do R precisam de tempo para serem implementadas nesses programas, o que não é necessário no R Studio, já que, digamos assim, a ligação dele com o R é mais direta, visto usar a linguagem de programação daquele programa.

Vamos resumir então: o R é o "programa" (ou ambiente de trabalho, para se mais adequado) para manipulação de dados e o R Studio é uma espécie de interface com o usuário, para facilitar o uso do R. Logo, para usar o R Studio, primeiro você precisa instalar o R em seu computador e, em seguida, instalar o R Studio. Vamos a esses passos.

# Instalando o R no Windows

### Passo 1
Acesse o [link para download do R](https://cloud.r-project.org/) e clique em "Download R for Windows".

### Passo 2
Se você estiver instalando o R pela primeira vez (se não, por que diabos estaria lendo isso?), clique em "base" ou em "install R for the first time" (ambos levam para o mesmo lugar).

### Passo 3
Clique em "Download R "Versão" for Windows", sendo que onde está "Versão" estará o número da versão que você estará baixando, como "Download R 4.0.5 for Windows". Esse arquivo será um executável de formato .exe e seu nome será algo pareceido com "R-4.0.5-win.exe". Faça o download e salve esse arquivo em seu computador.

### Passo 4
Vá até onde você salvou o arquivo acima e dê dois cliques sobre ele, executando-o. Nesse momento serão pedidas uma série de autorizações para instalação do programa. Siga todos os passos recomendados e, ao final, o programa estará instalado em seu computador.

# Instalando o R Studio no Windows

### Passo 1
Acesse o [link para download do R Studio](https://www.rstudio.com/products/rstudio/download/) e clique em "Download" sob a etiqueta "RStudio Desktop - Open Source License - Free". Observe que você deve baixar o "RStudio Desktop", não o "RStudio Server".

### Passo 2
Encontre o seu sistema operacional (ou OS) na tabela, provavelmente "Windows 10" e clique no link para Download, que terá um formato semelhante a este: "RStudio-1.4.1106.exe".

### Passo 3
Vá até onde você salvou o arquivo acima e dê dois cliques sobre ele, executando-o. Nesse momento serão pedidas uma série de autorizações para instalação do programa. Siga todos os passos recomendados e, ao final, o programa estará instalado em seu computador.

# Um adendo: O que é CRAN?
CRAN é uma sigla para "Comprehensive R Archive Network", basicamente, uma rede global de servidores que armazenam o R em algum lugar perto de você. No Brasil, por exemplo, na data em que este post está sendo redigido, temos 5 [CRAN mirrors](https://cloud.r-project.org/mirrors.html), cada um em uma instituição diferente (Universidade Estadual de Santa Cruz, Universidade Federal do Paraná, Fundação Oswaldo Cruz -- RJ, Universidade de São Paulo, no Campus da Capital e no de Piracicaba). É dos repositórios nesses CRAN mirrors que você muitas vezes baixará o R e inúmeros de seus pacotes. Em geral, você não precisa ter muitas informações sobre isso. O R fará a busca adequada no lugar certo para você. Apenas colocamos essa informação aqui para você não ficar assustado se porventura ela aparecer por aí.
