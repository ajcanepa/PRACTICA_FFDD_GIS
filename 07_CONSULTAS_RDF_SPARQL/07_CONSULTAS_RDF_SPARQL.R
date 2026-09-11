# Consultas RDF usando Tidyverse ------------------------------------------
# Paquete `rdflib`: Tools to Manipulate and Query Semantic Data // En https://cran.r-project.org/web/packages/rdflib/

# * Carga de Paquetes -----------------------------------------------------
library(rdflib)
library(dplyr)
library(tidyr)
library(tibble)
library(jsonld)


# * Set de datos ----------------------------------------------------------
# Trabajaremos con el set de datos `mtcars` en el que construiremos un triple

data(mtcars)
mtcars
colnames(mtcars)

# Creando los triples a partir de `mtcars`
mtcars %>% 
  rownames_to_column("Model") %>% 
  gather(attribute,measurement, -Model) %>% 
  head()

# Creamos el objeto car_triples
car_triples <- 
  mtcars %>% 
  rownames_to_column("Model") %>% 
  gather(attribute,measurement, -Model)

str(car_triples)

# No es un Tidy-dataset, porque:
# Primera columna `Model` --> *subject*
# Segunda columna `attribute` --> propiedad a ser medida ó *predicate*
# Tercera columna `measurement` --> valor medido ú *object*
# Call it key-property-value or subject-predicate-object


# * Uso de Identificadores URI/URL ----------------------------------------
# Transformamos la variable `Model` a un nivel mayor de abstracción, a un ID
car_triples <- 
  mtcars %>% 
  rownames_to_column("Model") %>% 
  rowid_to_column("subject") %>% 
  gather(predicate, object, -subject)

head(car_triples)
str(car_triples)

# Qué pasa si tenemos la misma tranformación con otro dataset? --> ejemplo `iris`
# Problema porque el subject (ID) no es único

data(iris)
str(iris)

# Creamos el objeto iris_triples
iris_triples <- 
  iris %>%
  rowid_to_column("subject") %>%
  gather(key = predicate, value = object, -subject)

head(iris_triples)


# ** Subject URI ----------------------------------------------------------
# Para evitar problemas en la WWW, referenciamos no con un ID, sino con una URI
# Así el ID 1 --> http://example.com/iris#1

# Reemplazamos el objeto
iris_triples <- 
  iris %>%
  rowid_to_column("subject") %>%
  mutate(subject = paste0("http://example.com/iris#", subject)) %>%
  gather(key = predicate, value = object, -subject)

head(iris_triples)


# ** Predicate URI -------------------------------------------------------
# Mismo concepto que aplica para sujetis, también aplica para predicados

iris_triples <- 
  iris %>%
  rowid_to_column("subject") %>%
  mutate(subject = paste0("http://example.com/iris#", subject)) %>%
  gather(key = predicate, value = object, -subject) %>%
  mutate(predicate = paste0("http://example.com/iris#", predicate)) %>% 
  mutate(object = as.numeric(object))

head(iris_triples)
str(iris_triples)

# ** Datatype URIs --------------------------------------------------------
# Todo parece bien, salvo que nuestro objeto (que deberían ser doubles) son character por una coercion
str(iris_triples)

# Para representar doubles en xml escquema y/o en RDF necesitamos ver https://www.w3.org/TR/rdf11-concepts/#section-Datatypes
# String --> http://www.w3.org/2001/XMLSchema#string
# Integer --> http://www.w3.org/2001/XMLSchema#integer
# Double debería ser "5.1"^^http://www.w3.org/2001/XMLSchema#double


# * Triples en el paquete rdflib ------------------------------------------
# Hasta ahora los triples eran "dataframes" acomodados
# el paquete `rdflib` agrega un objeto de clase `rdf`.

# ** Objeto rdf (en memoria) ----------------------------------------------
rdf1 <- rdf()

# Agregamos datos al modelo RDF (gráfico RDF) con rdf_add
# Necesitamos crear una URI base --> http://example.com/iris#

base <- "http://example.com/iris#"

rdf1 %>% 
  rdf_add(subject = paste0(base, "obs1"), 
          predicate = paste0(base, "Sepal.Length"), 
          object = 5.1)

rdf1

str(rdf1)

# ** Prefijos para las URIs (CURIE) ---------------------------------------
# Los namespace (en XML) pueden teenr un prefijo seguido de ":"
# Entonces si definimos a iris: como el equivalente a http://example.com/iris#
# Tendríamos iris:Sepal.Length, iris:Sepal.With

# ** URI v/s URL ----------------------------------------------------------
# URL --> uniform resource locator, aka web address
# URI --> uniform resource identifier --> puede ser una URL y más cosas (DOI, ISBN, etc.)

# ** Serialización --------------------------------------------------------
# El formato que hemos visto se denomina N-Quads
# Podemos serializar un objeto con la función `rdf_serialize()`
rdf1
?rdf_serialize()

# Ejemplo
doc <- system.file("extdata/example.rdf", package = "redland")
rdf1 <- rdf_parse(doc, format = "rdfxml") 
rdf1

# XML-based schema
options(rdf_print_format = "rdfxml")
rdf1

# TURTLE
options(rdf_print_format = "turtle")
rdf1

# JSON-LD
# “the thing in the curly braces,” (i.e. the JSON “object”)
options(rdf_print_format = "jsonld")
rdf1

# @id --> property
# @context --> define datatypes, use multiple namespaces, and permit different names in the JSON keys from that found in the URLs.

# Agregando un @context
rdf_serialize(rdf1, "example.json", "jsonld") %>% 
  jsonld_compact(context = '{"@vocab": "http://purl.org/dc/elements/1.1/"}')


# ** De tablas a Gráficos -------------------------------------------------
# No todos los set de datos pueden almacenarse en forma tabular (tidy)
# ej:
ex <- system.file("extdata/person.json", package = "rdflib")
cat(readLines(ex), sep = "\n")

# Serialización a N-Quads
options(rdf_print_format = "nquads")
ex
rdf2 <- rdf_parse(ex, "jsonld")
rdf2

# El `adress` se ha entregado como un nodo en blanco `_:b0`

# Esto mismo se conoce como una estructura "aplanada" (flattend)
jsonld_flatten(ex, context = "http://schema.org")

# Atención en la estructura típica de un JSON, anidada con los {} indicando un objeto raíz (superior)


# Podríamos regresar a la estructura anterior, entregando un marco que especifique qué tipo de archivo es el root
jsonld_flatten(ex) %>%
  jsonld_frame('{"@type": "http://schema.org/Person"}') %>%
  jsonld_compact(context = "http://schema.org")

# Las diferencias entre las 2 representaciones (nested/flattened) es solamente estética!



# ** Más ejemplos para crear RDFs -----------------------------------------
x1 <- as_rdf(iris, NULL, "iris:")
x1

x2 <- as_rdf(cars, NULL, "mtcars:")
x2

# Objeto grande RDF
rdf3 <- c(x1,x2)
rdf3
class(rdf3)
str(rdf3)

# * Volviendo a las Tablas -----------------------------------------------


# ** Consulta Usando SPARQL -----------------------------------------------
# generamos una consulta en SPARQL, definiendo un motor de búsqueda
library(SPARQL)
library(tidyverse)
library(rdflib)

sparql <-
  'SELECT  ?Species ?Sepal_Length ?Sepal_Width ?Petal_Length  ?Petal_Width
WHERE {
 ?s <iris:Species>  ?Species .
 ?s <iris:Sepal.Width>  ?Sepal_Width .
 ?s <iris:Sepal.Length>  ?Sepal_Length . 
 ?s <iris:Petal.Length>  ?Petal_Length .
 ?s <iris:Petal.Width>  ?Petal_Width 
}'

# Creamos un objeto que sea una consulta (siguiendo el motor de búsqueda), sobre un objeto RDF ya creado
# rdf3

iris2 <- rdf_query(rdf3, sparql)

iris2

# ** Consulta Usando tidy_schema del paquete rdflib -----------------------
# Cargamos la función
source(system.file("examples/tidy_schema.R", package = "rdflib"))
View(tidy_schema) # revisar el SPARQL interno

sparql_tidy <- tidy_schema("Species",  "Sepal.Length", "Sepal.Width", prefix = "iris")

iris3 <- rdf_query(rdf3, sparql_tidy)
iris3


# ** Consulta Usando dbpedia ----------------------------------------------
# AVISO: los paquetes SPARQL y WikidataQueryServiceR han sido RETIRADOS de CRAN
# (SPARQL en 2022, WikidataQueryServiceR en 2026). Ya no se mantienen, aunque
# siguen siendo instalables manualmente. Más abajo se muestra primero este
# enfoque original (por fidelidad histórica) y, después, una alternativa moderna
# con httr2 + jsonlite que no depende de ningún paquete huérfano.

# *** Enfoque original: paquetes SPARQL y WikidataQueryServiceR ------------
# El paquete SPARQL fue retirado de CRAN; puede instalarse desde el Archive:
# install.packages(
#   "https://cran.r-project.org/src/contrib/Archive/SPARQL/SPARQL_1.16.tar.gz",
#   repos = NULL, type = "source"
# )
library(SPARQL)
library(tidyverse)

# Mirar el Query Editor online
endpoint <- "https://dbpedia.org/sparql"

# Query 1
query_example <- "SELECT * WHERE {
?athlete rdfs:label 'Alexia Putellas'@en
}"

QD <- SPARQL(url = endpoint, query = query_example)

str(QD)

DF <- as_tibble(QD$results)
DF

# Query 2
query_example <- "SELECT * WHERE {
?athlete rdfs:label 'Alexia Putellas'@en ;
  dbo:number  ?number .
}"

QD <- SPARQL(url = endpoint, query = query_example)

str(QD)

DF <- as_tibble(QD$results)
DF

# Query 3
query_example <- "SELECT * WHERE {
?athlete rdfs:label 'Alexia Putellas'@en ;
  dbo:number  ?number ;
  dbo:birthPlace  ?place .
}"

QD <- SPARQL(url = endpoint, query = query_example)

str(QD)

DF <- as_tibble(QD$results)
DF$place



# ** Consulta Usando Wikidata ---------------------------------------------
# https://github.com/wikimedia/WikidataQueryServiceR
# WikidataQueryServiceR fue retirado de CRAN; puede instalarse desde GitHub:
# devtools::install_github("wikimedia/WikidataQueryServiceR")
library(WikidataQueryServiceR)

?WDQS 
# https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries/examples

# Ejemplo: obtención de los géneros de una película determinada. En este ejemplo, buscamos una "instancia de" (P31) "película" (Q11424) que tenga la etiqueta "La cabaña en el bosque" (Q45394), obtenemos sus géneros (P136) y, a continuación, utilizamos el servicio de etiquetas WDQS para devolver las etiquetas de género.

pelis <- query_wikidata('SELECT DISTINCT
  ?genre ?genreLabel
WHERE {
  ?film wdt:P31 wd:Q11424.
  ?film rdfs:label "The Cabin in the Woods"@en.
  ?film wdt:P136 ?genre.
  SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
}')

pelis
str(pelis)

# https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries/examples
# Esta consulta busca todos los artículos cuyo valor de instancia de (P31) es gato doméstico (Q146). Utiliza el servicio wikibase:label para devolver las etiquetas en su idioma por defecto o en inglés.

gatos <- query_wikidata('SELECT 
                        ?item ?itemLabel
                        WHERE {
                        ?item wdt:P31 wd:Q146. # Must be of a cat
                        SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE], en". } # Helps get the label in your language, if not, then en language
                      }')

gatos


# *** Enfoque recomendado: httr2 + jsonlite -------------------------------
# El protocolo SPARQL 1.1 no exige ningún cliente especializado: es una petición
# HTTP GET ordinaria, con la consulta en el parámetro 'query' y la cabecera
# Accept: application/sparql-results+json para pedir la respuesta en JSON. Con
# httr2 (para la petición) y jsonlite (para analizar la respuesta) no dependemos
# de ningún paquete específico de SPARQL.
library(httr2)
library(jsonlite)

consultar_sparql <- function(endpoint, query) {
  resp <-
    request(endpoint) %>%
    req_url_query(query = query) %>%
    req_headers(Accept = "application/sparql-results+json") %>%
    req_perform()

  resultado <- resp_body_json(resp, simplifyVector = FALSE)

  # La forma JSON de una respuesta SPARQL siempre sigue el mismo esquema:
  # resultado$head$vars        -> nombres de las variables pedidas en el SELECT
  # resultado$results$bindings -> una lista por fila, con un {type, value} por variable
  variables <- unlist(resultado$head$vars)

  filas <- lapply(resultado$results$bindings, function(fila) {
    valores <- lapply(variables, function(v) {
      if (!is.null(fila[[v]])) fila[[v]]$value else NA_character_
    })
    names(valores) <- variables
    as_tibble(valores)
  })

  bind_rows(filas)
}

# Con esta única función, ya reutilizable, repetimos la consulta a DBpedia:
consultar_sparql(
  endpoint = "https://dbpedia.org/sparql",
  query = "SELECT * WHERE {
    ?athlete rdfs:label 'Alexia Putellas'@en ;
      dbo:number     ?number ;
      dbo:birthPlace ?place .
  }"
)

# Y la consulta a Wikidata, sin depender de WikidataQueryServiceR:
consultar_sparql(
  endpoint = "https://query.wikidata.org/sparql",
  query = 'SELECT ?item ?itemLabel WHERE {
    ?item wdt:P31 wd:Q146.
    SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE], en". }
  }'
)


# Referencias -------------------------------------------------------------
# https://adv-r.hadley.nz/index.html
# https://rstudio-education.github.io/hopr/
# https://r4ds.had.co.nz/
# https://dplyr.tidyverse.org/
# https://ggplot2.tidyverse.org/index.html