# CONSULTAS EN PUBMED  ----------------------------------------------------

# Creación de claves ------------------------------------------------------
# https://cran.r-project.org/web/packages/pubmedR/vignettes/A_Brief_Example.html
# Registro en la plataforma “my ncbi account” (https://www.ncbi.nlm.nih.gov/account/) 
# Clicar en el botón “account settings page” (https://www.ncbi.nlm.nih.gov/account/settings/).
# 
# Una vez que tengas la API Key, debes establecer el argumento api_key=“your API key”, o de lo contrario: api_key=“NULL”:
# Acceso recomendado, usando ORCID y UBU
# username: 
# APIKEY: 

# Carga de Paquetes -------------------------------------------------------
# install.packages(c("pubmedR", "bibliometrix", "wordcloud", "wordcloud2", "RColorBrewer",
#                    "tidyverse", "maps"))  # solo una vez

library(tidyverse)
library(pubmedR)
library(bibliometrix)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)


# * API KEY ---------------------------------------------------------------
# Si tienes tu API KEY
api_key <- "TU API KEY"

# Si no tienes una API KEY
#api_key = NULL

# Motor de Búsqueda - Query -----------------------------------------------
# Deberás ingresar en https://pubmed.ncbi.nlm.nih.gov/advanced/
# Definir un motor de búsqueda y copiar/pegar el contenido del "Query box" en un objeto llamado `query`.
query <- "((pollution[Title]) AND (air[Title])) AND (rural[Title])"


# Consultando la BBDD PubMed ----------------------------------------------

# * Número de artículos ---------------------------------------------------
# Con este comando sabrás cuántos documentos te devuelve la query que has generado (contrástalo con el resultado de la web de pubmed)
res <- pmQueryTotalCount(query = query, api_key = api_key)

res$total_count

res$query_translation

# * Descarga de la metadata -----------------------------------------------
# Podrás descargar la metadata asociada a los artículos, como el abstract, autores, etc.
# Puedes manipular el argumento limit tal que descargues un conjunto de datos menor al resultado total del query. Recomendado si te regresa más de 500 artículos. Como es solo un ejercicio podéis trabajar con un máximo de 250-300 artículos.
# Lo almacenaremos en el objeto D
D <- pmApiRequest(query = query, limit = res$total_count, api_key = api_key)

class(D)

attributes(D)


# The function pmApiRequest returns a list D composed by 5 objects:
# “data”. It is the xml-structured list containing the bibliographic metadata collection downloaded from the PubMed database.
# “query”. It a character object containing the original query formulated by the user.
# “query_translation”. It a character object containing the query, translated by the NCBI Automatic Terms Translation system and submitted to the PubMed database.
# “records_downloaded”. It is an integer object indicating the total number of records downloaded and stored in “data”.
# “total_counts”. It is an integer object indicating the total number of records matching the query (stored in the “query_translation” object").


# * Desde xml a dataframe -------------------------------------------------
# Deberemos transformar el objeto D con formato xml en un dataframe
M <- pmApi2df(D)

str(M)
head(M)

# Ahora mismo ya puedes trabajar con este conjunto de datos en un formato datafrane (marco de datos) estructurado. 


# Uso del paquete Bibliometrix --------------------------------------------
# https://www.bibliometrix.org/vignettes/Introduction_to_bibliometrix.html
# https://github.com/massimoaria/bibliometrix
# podemos utilizar algunas funciones bibliometrix para obtener una visión general de la colección bibliográfica
# bibliometrix es una herramienta R para la investigación cuantitativa en cienciometría y bibliometría.

# * Descarga del bibtext desde la web -------------------------------------
# Descargado Directamente desde la página de PubMed
# file <- "pubmed-COVIDTitle-set.txt"
# M1 <- convert2df(file = file, dbsource = "pubmed", format = "plaintext")

# * Principales datos de la colección -------------------------------------
M1 <- convert2df(D, dbsource = "pubmed", format = "api")

str(M1)

# PubMed NO proporciona número de citas (TC) ni referencias citadas (CR).
summary(M1$TC)

sum(!is.na(M1$CR) & M1$CR != "")

# Lo que sí es muy rico en PubMed son los términos MeSH (campo ID),
# los títulos (TI), los resúmenes (AB), autores (AU), revistas (SO) y
# afiliaciones (C1 / AU_UN).

# Términos MeSH genéricos que conviene eliminar en casi todos los gráficos
genericos <- c("HUMANS", "HUMAN", "FEMALE", "MALE", "ADULT", "AGED",
               "MIDDLE AGED", "AGED, 80 AND OVER", "YOUNG ADULT",
               "ADOLESCENT", "CHILD", "CHILD, PRESCHOOL", "INFANT",
               "INFANT, NEWBORN", "ANIMALS", "PREGNANCY")


# ** Análisis bibliométrico -----------------------------------------------
results <- biblioAnalysis(M1, sep = ";")

summary(results)

str(results)

results$Aff_frac

head(results$Aff_frac)


# *  Integridad de los metadatos ------------------------------------------
# Tras importar un marco de datos bibliográfico, podemos comprobar si los metadatos incluidos en él están completos mediante missingData().
com <- missingData(M1)

str(com)

com$mandatoryTags

com$allTags


# * Análisis bibliométrico ------------------------------------------------
# La función biblioAnalysis calcula las principales medidas bibliométricas.
#results <- biblioAnalysis(M1, sep = ";")
results

# summary resume los principales resultados del análisis bibliométrico
# Muestra la producción científica anual, los principales manuscritos por número de citas, los autores más productivos, los países más productivos, el total de citas por país, las fuentes más relevantes (revistas) y las palabras clave más relevantes.

S <- summary(object = results, k = 10, pause = FALSE)

# Existen una serie de gráficos que se obtienen de manera automática. Puede fallar según los campos obtenidos
plot(x = results, k = 10, pause = TRUE)


# * Análisis de las palabras conjuntas "Co-Word" --------------------------
# Conceptual Structure using keywords (method="MCA")
# El objetivo del análisis de co-palabras es mapear la estructura conceptual de un marco utilizando las co-ocurrencias de palabras en una colección bibliográfica.
CS <- conceptualStructure(M1,field = "ID", method = "MCA", minDegree = 10, clust = 5, stemming = FALSE, labelsize = 15, documents = 20, graph = FALSE)

# Gráfico de dimensiones principales
plot(CS$graph_terms)

# Gráfico de dendrograma
plot(CS$graph_dendogram)



# * Producción científica anual (ggplot2) ---------------------------------
prod <- 
  M1 %>%
  filter(!is.na(PY)) %>%
  count(PY, name = "n")

ggplot(prod, aes(x = PY, y = n)) +
  geom_col(fill = "steelblue", alpha = 0.7) +
  geom_line(colour = "darkred", linewidth = 0.4) +
  geom_point(colour = "darkred") +
  labs(title = "Producción científica anual",
       x = "Año", y = "Nº de artículos") +
  theme_minimal()

# * Nube de palabras de términos MeSH ------------------------------------
# tableTag() cuenta la frecuencia de cualquier campo del data frame

mesh <- tableTag(M1, Tag = "ID", sep = ";")

mesh_df <- data.frame(word = names(mesh), freq = as.numeric(mesh)) %>%
  filter(!word %in% genericos, word != "")

head(mesh_df, 20)

# a) Versión estática (paquete wordcloud)
set.seed(123)
x11()
wordcloud(words = mesh_df$word, freq = mesh_df$freq,
          max.words = 100, min.freq = 2,
          random.order = FALSE, rot.per = 0.2, scale = c(3, 0.5),
          colors = brewer.pal(8, "Dark2"))

# b) Versión interactiva (paquete wordcloud2, se abre en el Viewer)
#wordcloud2(head(mesh_df, 150), size = 0.5, color = "random-dark")


# * Países: producción y mapa mundial -----------------------------------
# Extraemos el país del autor de correspondencia/primer autor desde la
# afiliación. Puede quedar algún NA si la afiliación está incompleta.
M1 <- metaTagExtraction(M1, Field = "AU1_CO", sep = ";")

paises <- M1 %>%
  filter(!is.na(AU1_CO), AU1_CO != "") %>%
  count(AU1_CO, name = "n") %>%
  arrange(desc(n))

# a) Barras
x11()
ggplot(head(paises, 15), aes(x = reorder(AU1_CO, n), y = n)) +
  geom_col(fill = "seagreen") +
  coord_flip() +
  labs(title = "Países más productivos (primer autor)", x = NULL, y = "Artículos") +
  theme_minimal()

# b) Mapa mundial (los nombres de bibliometrix y de 'maps' no siempre coinciden)
mundo <- map_data("world")
paises_mapa <- paises %>%
  mutate(region = tools::toTitleCase(tolower(AU1_CO)),
         region = recode(region, "Usa" = "USA", "United Kingdom" = "UK",
                         "Korea" = "South Korea"))
x11()
ggplot(left_join(mundo, paises_mapa, by = "region"),
       aes(long, lat, group = group, fill = n)) +
  geom_polygon(colour = "white", linewidth = 0.1) +
  scale_fill_gradient(low = "#c6dbef", high = "#08306b",
                      na.value = "grey90", name = "Artículos") +
  labs(title = "Producción científica por país") +
  theme_void()

# c) Red de colaboración entre países
M1 <- metaTagExtraction(M1, Field = "AU_CO", sep = ";")
NetCO <- biblioNetwork(M1, analysis = "collaboration",
                       network = "countries", sep = ";")

x11()
networkPlot(NetCO, n = 30, Title = "Colaboración entre países",
            type = "circle", size = TRUE, labelsize = 0.8,
            remove.isolates = TRUE)
