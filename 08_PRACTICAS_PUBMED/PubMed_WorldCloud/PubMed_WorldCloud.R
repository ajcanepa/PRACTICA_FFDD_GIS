# Instalación y Carga de Paquetes -----------------------------------------
# library(devtools)
# install_github("felixfan/PubMedWordcloud") # from GitHub

library(PubMedWordcloud)  


# Obtener PubMed Reference Numbers (PMIDs) --------------------------------
pmid1 <- getPMIDs(author = "Yan-Hui Fan", dFrom = 2007, dTo = 2020, n = 10)
pmid1

pmid2 <- getPMIDs(author="Yanhui Fan",dFrom=2007,dTo=2020,n=10)
pmid2


# Editar listado de artículos no propios ----------------------------------
# Dos artículos PMIDs son de otro autor
rm1 <- "22698742"
pmids1 <- editPMIDs(x=pmid1,y=rm1,method="exclude")

rm2 <- "20576513"
pmids2 <- editPMIDs(x=pmid2,y=rm2,method="exclude")

# Se unen todos los PMIDs en un solo vector
pmids <- editPMIDs(x=pmids1,y=pmids2,method="add")


# Obtención de resúmenes --------------------------------------------------
abstracts <- getAbstracts(pmids)


# Limpieza de resúmenes ---------------------------------------------------
cleanAbs <- cleanAbstracts(abstracts)


# Gráficas de Nube de Palabras --------------------------------------------
# Gráfico base
# x11()
plotWordCloud(cleanAbs,min.freq = 2, scale = c(2, 0.3))

# Sin rotar las palabras
plotWordCloud(cleanAbs,min.freq = 10, scale = c(2, 0.3),rot.per=0)

# Usando otra paleta de colores
colors <- colSets(type="Paired")
plotWordCloud(cleanAbs,min.freq = 2, scale = c(2, 0.3),colors=colors)

# Quitando las palabras derivadas (Stemming words)
cleanAbs2 <- cleanAbstracts(abstracts,stemDoc =TRUE)
plotWordCloud(cleanAbs2,min.freq = 2, scale = c(2, 0.3))


# Enfoque tidyverse: tidytext + ggplot2 -----------------------------------
# PubMedWordcloud no se actualiza desde 2019 y usa gráficos base de R.
# Una alternativa moderna es 'tidytext', que aplica los principios tidy a la
# minería de texto (una palabra = una fila de un tibble), y permite reutilizar
# count(), filter(), anti_join() y ggplot2 en lugar de una API específica.

library(tidytext)
library(ggwordcloud)
library(stringr)

# 'M' proviene de la práctica pubmedR (Ejemplo_Consulta_PubMed_pubmedR.R),
# donde M <- pmApi2df(D). Trabajamos con la columna de resúmenes M$AB.
palabras_frecuentes <-
  tibble(abstract = M$AB) %>%
  unnest_tokens(output = word, input = abstract) %>%
  anti_join(stop_words, by = "word") %>%   # elimina palabras vacías ("the", "and"...)
  filter(!str_detect(word, "^[0-9]+$")) %>% # elimina tokens puramente numéricos
  count(word, sort = TRUE) %>%
  slice_max(n, n = 100)

ggplot(palabras_frecuentes, aes(label = word, size = n, colour = n)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 14) +
  scale_colour_gradient(low = "steelblue", high = "firebrick") +
  theme_minimal()


