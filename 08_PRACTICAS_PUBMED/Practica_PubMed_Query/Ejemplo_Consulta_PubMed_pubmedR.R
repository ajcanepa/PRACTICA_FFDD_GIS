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
#install.packages("pubmedR") # only once requiered
library(pubmedR)
#install.packages("bibliometrix") #requiered once
library(bibliometrix)


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

results <- biblioAnalysis(M1)
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
results <- biblioAnalysis(M1, sep = ";")

# summary resume los principales resultados del análisis bibliométrico
# Muestra la producción científica anual, los principales manuscritos por número de citas, los autores más productivos, los países más productivos, el total de citas por país, las fuentes más relevantes (revistas) y las palabras clave más relevantes.

S <- summary(object = results, k = 10, pause = FALSE)

# Existen una serie de gráficos que se obtienen de manera automática. Puede fallar según los campos obtenidos
plot(x = results, k = 10, pause = TRUE)


# * Análisis de las palabras conjuntas "Co-Word" --------------------------
# Conceptual Structure using keywords (method="CA")
# El objetivo del análisis de co-palabras es mapear la estructura conceptual de un marco utilizando las co-ocurrencias de palabras en una colección bibliográfica.
CS <- conceptualStructure(M1,field = "ID", method = "MCA", minDegree = 10, clust = 5, stemming = FALSE, labelsize = 15, documents = 20, graph = FALSE)

# Gráfico de dimensiones principales
plot(CS$graph_terms)

# Gráfico de dendrograma
plot(CS$graph_dendogram)
