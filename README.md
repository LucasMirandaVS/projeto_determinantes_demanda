# Analisando os determinantes da demanda por etanol no Brasil

Neste projeto, tratei de analisar quais são as principais variáveis determinantes da demanda por etanol nos estados brasileiros. Este projeto foi realizado como parte da minha dissertação de mestardo em Economia Aplicada pelo Programa de Pós Graduação em Economia Aplicada da Universidade Federal de Ouro Preto. 

## Objetivos
Objetivo Geral: 
* Determinar as relações e os principais determinantes da demanda de etanol nos estados brasileiros no período de 2010 a 2019.

Objetivos Específicos:
* Analisar a resposta dos consumidores de etanol às variações nos preços do etanol, da gasolina e da renda nos estados brasileiros;
* Verificar as principais variáveis que determinam a demanda por etanol no Brasil; 
* Verificar se houveram mudanças na estrutura do mercado de combustíveis após os acontecimentos macroeconômicos e geopolíticos no período analisado;
* Verificar se existem 	diferenças entre as elasticidades preço e cruzada para estados produtores 	e não produtores de etanol.

## Metodologia
O modelo empregado neste trabalho consiste na organização dos dados em um painel de modo a combinar mais de uma unidade de seção cruzada (cross-section) para mais de um período de tempo. A estimação por dados em painel tem como objetivo levar em consideração a heterogeneidade não observada pelos estados. 

Por essa razão, serão empregados alguns testes estatísticos de modo a escolher qual modelo melhor se ajusta aos dados.  Primeiramente, será empregado o teste formal desenvolvido por Hausman baseado no cálculo da diferença dos estimadores entre os modelos de efeitos fixos e aleatórios. Este teste pode ser usado para indicar qual destas especificações é mais apropriada aos dados. A hipótese nula do teste indica que as diferenças entre os regressores não são significativas. Assim, ao não se rejeitar a hipótese nula, pode-se concluir que o modelo mais apropriado deva considerar os efeitos aleatórios ao longo do tempo.

A organização de dados em painel pode apresentar ainda problemas de heteroscedasticidade e autocorrelação dos erros. Por essa razão, será aplicado ao modelo o teste de Wooldridge para avaliação de autocorrelação de primeira ordem, além da implementação de erros padrões robustos de modo a lidar com a heterocedasticidade.

Com base nas equações propostas na revisão de literatura, a equação de demanda a ser estimada pode ser definida da seguinte forma:
![image](https://user-images.githubusercontent.com/77032413/194127398-60168c13-8c0d-46a6-8cf3-5642298004a2.png)
Sendo i = 1,…, 25 e t = 2010 a 2019.

As variáveis da equação são as que seguem:

### Dados
Em virtude da ausência de dados confiáveis para as séries de preços de todas as unidades federativas, foram excluídos os estados do Amapá e Distrito Federal. Dessa forma, as variáveis definidas no modelo e suas respectivas fontes podem ser definidas da seguinte forma:

* Consumo de etanol (QE) 

Extraído do site da ANP com periodicidade anual no período de 2010 a 2019 para os estados brasileiros (com exceção do Amapá e Distrito Federal) e apresentado em m³ (metros cúbicos).

* Preços médios do etanol e da gasolina (PE & PG)

Os preços médios do etanol e da gasolina foram obtidos por meio do boletim da ANP, em seu canal Defesa da Concorrência''. Os dados foram utilizados com periodicidade anual no período de 2010 a 2019 e deflacionados por meio do Índice de Preços ao Consumidor Amplo (IPCA);

* Produto Interno Bruto per capita (Y)

O PIB per capita dos estados  em R$ no período de 2010 a 2018, deflacionado pelo IPCA,  foi utilizado como variável “proxy” para mensurar a renda do consumidor. Tais dados foram extraídos do site IPEADATA.

* Frota de Veículos Movidos à Etanol, Gasolina ou Flexfuel (TxF)

Número de veículos com motor com o ciclo Otto, que funcionam a base de gasolina, etanol ou flex fuel. Variável obtida no site do SENATRAN com frequência de 2010 a 2019 para todos os estados da união ( com exceção do Amapá e Distrito Federal). 

Além das variáveis definidas anteriormente, incluiu-se também duas variáveis binárias, cujo comportamento pode ser definido como segue:

![image](https://user-images.githubusercontent.com/77032413/194126395-e0645592-46b7-4eeb-ae01-a407f8b9b01d.png)

## Resultados

A estimativa de um modelo de dados em painel ocorre através de diferentes métodos. No presente trabalho foram considerados os seguintes métodos: Pooled, efeitos fixos e efeitos aleatórios. Após a estimação dos modelos, o próximo passo é verificar a significância estatística dos modelos através dos testes estatísticos mencionados na metodologia. 

O resultados dos testes estatísticos encontram-se na tabela abaixo:

![image](https://user-images.githubusercontent.com/77032413/194324998-1f3eb6b9-712f-4378-9154-4649ed671377.png)

O resultado do teste de Hausman, cuja hipótese nula é a de um efeito aleatório consistente e assintoticamente eficiente ou efeito fixo consistente, e a hipótese alternativa é a de um efeito aleatório inconsistente ou efeito fixo consistente. O resultado de 752,36 indica que deve se rejeitar a 1% de significância a hipótese nula de que o modelo que melhor se ajusta aos dados é o de efeitos aleatórios. Isto indica que os modelos estimados devem necessariamente considerar a presença de efeitos fixos.

Tendo em vista os resultados dos testes estatísticos e seguindo os procedimentos mencionados na metodologia, optou-se por utilizar estimadores com efeitos fixos para realizar a estimação da equação de demanda. Os resultados da estimação da equação de demanda por etanol encontram-se na tabela abaixo:

![image](https://user-images.githubusercontent.com/77032413/194325449-3ba9562d-d400-4c8d-85cc-dac31eed75f7.png)

