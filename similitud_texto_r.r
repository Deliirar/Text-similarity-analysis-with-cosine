#Análisis de similitud de texto
install(NLP)
install(tm)
install(RColorBrewer)
install(SnowballC)
install(wordcloud)
install(dplyr)
install(readr)
install(cluster)
install(tidytext)
install(tokenizers)
install(syuzhet)
install(readxl)
install(topicmodels)
install(quanteda)
install(openxlsx)
install(quanteda.textstats)
install(quanteda.textmodels)
install(quanteda.textplots)

library(NLP)
library(tm)
library(RColorBrewer)
library(SnowballC)
library(wordcloud)
library(dplyr)
library(readr)
library(cluster)
library(tidytext)
library(tokenizers)
library(syuzhet)
library(readxl)
library(topicmodels)
library(quanteda)
library(openxlsx)
library(quanteda.textstats)
library(quanteda.textmodels)
library(quanteda.textplots)

# Subir datos

text_casos <-  read_excel("C:/Users/User/Desktop/Análisis de coincidencia/items_completo_plano.xlsx", sheet="casos")
text_enunciados_a <- read_excel("C:/Users/User/Desktop/Análisis de coincidencia/items_completo_plano.xlsx", sheet="enunciados_a")
text_enunciados_n <- read_excel("C:/Users/User/Desktop/Análisis de coincidencia/items_completo_plano.xlsx", sheet="enunciados_n")

# Seleccionar del dataframe cargado la columna que contiene el texto para analizar

ANALISIS_CASOS <- corpus((text_casos$textcaso))
ANALISIS_ENUNCIADOSA <- corpus((text_enunciados_a$textenunciado))
ANALISIS_ENUNCIADOSN <- corpus((text_enunciados_n$textenunciado))


# se eliminan caracterees, numeros y cadenas que no son necesarias

analisis_c<- dfm(corpus_subset(ANALISIS_CASOS),
                 remove = stopwords("spanish"), stem = TRUE, remove_punct = TRUE)

analisis_ea<- dfm(corpus_subset(ANALISIS_ENUNCIADOSA),
                 remove = stopwords("spanish"), stem = TRUE, remove_punct = TRUE)

analisis_en<- dfm(corpus_subset(ANALISIS_ENUNCIADOSN),
                  remove = stopwords("spanish"), stem = TRUE, remove_punct = TRUE)

# se reliza la comparaciÃ³n de los textos por pares

comparacion_c <- textstat_simil(analisis_c, analisis_c,margin = "documents", method = "cosine")

resultado_c <- as.data.frame(comparacion_c)


comparacion_e <- textstat_simil(analisis_ea, analisis_en,margin = "documents", method = "cosine")

resultado_e <- as.data.frame(comparacion_e)

# filtrar los texto que tienen coincidencia superior a un valor especifico

filtroc <- resultado_c %>%filter(cosine>=0.8)
filtroe <- resultado_e %>%filter(cosine>=0.8)

# se extrae el resultado a formato excel

tablas <- list("indice_casos"=filtroc,"indice_enunciados"=filtroe)
openxlsx::write.xlsx(tablas, "indicadores_casos.xlsx")
