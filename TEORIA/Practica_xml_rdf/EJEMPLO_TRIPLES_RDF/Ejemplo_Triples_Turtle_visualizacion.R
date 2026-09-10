# Ejemplos de Serializaciones en Turtle -----------------------------------
## Carga de Paquetes -----------------------------------------------------
library(rdflib)
library(tidyverse)
library(visNetwork)


## Tabla de datos original -----------------------------------------------
# 1. TUS DATOS
medicos <- tibble(
  ID = c(101, 102),
  Nombre = c("Dr. Smith", "Dra. Jones"),
  Ciudad = c("London", "Madrid")
)


## Creación de un RDF ----------------------------------------------------

#2. PREPARACIÓN: Crear grafo vacío
grafo_rdf <- rdf()

#3. CONSTRUCCIÓN (Igual que antes, usando URIs completas)
for(i in 1:nrow(medicos)) {
  
  # Define la URI completa del sujeto manualmente
  sujeto_uri <- paste0("http://hospital.ejemplo.org/", medicos$ID[i])
  
  # Añadir Nombre
  rdf_add(grafo_rdf, 
          subject   = sujeto_uri,
          predicate = "http://schema.org/name", 
          object    = medicos$Nombre[i])
  
  # Añadir Ciudad
  rdf_add(grafo_rdf, 
          subject   = sujeto_uri,
          predicate = "http://schema.org/addressLocality", 
          object    = medicos$Ciudad[i])
}


## Exportamos la serialización -------------------------------------------
#4. EXPORTAR (AQUÍ es donde definimos los prefijos)
# Pasamos un vector con nombre: c(PREFIJO = "URI")
rdf_serialize(grafo_rdf, 
              doc = "Practica_xml_rdf/EJEMPLO_TRIPLES_RDF/OUTPUT/mis_datos.ttl", 
              format = "turtle",
              namespace = c(ex = "http://hospital.ejemplo.org/", 
                            schema = "http://schema.org/"))


## Consultando el RDF con SPARQL -----------------------------------------
# Usamos una consulta SPARQL simple para sacar todo a un dataframe
df_grafico <- rdf_query(grafo_rdf, "SELECT ?sujeto ?predicado ?objeto WHERE { ?sujeto ?predicado ?objeto }")


# Renombramos para que las librerías gráficas lo entiendan mejor, según:

# ----------------------------------------------------------------------
# TABLA DE REFERENCIA: MAPEO RDF -> VISUALIZACIÓN
# ----------------------------------------------------------------------
# Concepto RDF  | Original (SPARQL) | Destino (visNetwork) | Visual
# ----------------------------------------------------------------------
# Sujeto        | s                 | from                 | Origen
# Predicado     | p                 | label                | Etiqueta
# Objeto        | o                 | to                   | Destino
# ----------------------------------------------------------------------

colnames(df_grafico) <- c("from", "label", "to")

df_grafico


# Visualización con igraph ------------------------------------------------
library(igraph)

# 1. Convertir dataframe a objeto igraph
g <- graph_from_data_frame(df_grafico, directed = TRUE)

# 2. Pintarlo
plot(g, 
     vertex.size = 20,           # Tamaño del nodo
     vertex.label.cex = 0.8,     # Tamaño letra
     edge.arrow.size = 0.5,      # Tamaño flecha
     main = "Visualización con igraph")


# Visualización con visNetwork --------------------------------------------
# install.packages("visNetwork")
library(visNetwork)

# 1. Crear lista de nodos (deben ser únicos)
nodos <- data.frame(id = unique(c(df_grafico$from, df_grafico$to)))
nodos$label <- nodos$id # Que la etiqueta sea el mismo ID

# 2. Crear lista de aristas (relaciones)
aristas <- df_grafico # Ya tiene las columnas 'from' y 'to' necesarias

# 3. Pintar
visNetwork(nodos, aristas, main = "Grafo RDF Interactivo") %>%
  visEdges(arrows = "to") %>%    # Poner flechas
  visOptions(highlightNearest = TRUE) # Iluminar al hacer clic


# Color específico para cada Predicado ------------------------------
# 1. Preparar NODOS (igual que antes)
nodos <- data.frame(id = unique(c(df_grafico$from, df_grafico$to)))
nodos$label <- nodos$id 

# 2. Preparar ARISTAS con COLORES (Aquí está la magia)
aristas <- df_grafico %>%
  mutate(
    # Creamos la columna 'color' usando case_when (super útil para mapeos)
    color = case_when(
      label == "http://schema.org/name"            ~ "blue",
      label == "http://schema.org/addressLocality" ~ "red",
      TRUE                                         ~ "black" # Color por defecto
    ),
    # OPCIONAL: Limpiamos la etiqueta para que no se vea la URL gigante en el dibujo
    label = case_when(
      label == "http://schema.org/name"            ~ "Nombre",
      label == "http://schema.org/addressLocality" ~ "Ciudad",
      TRUE ~ label
    )
  )

# 3. Pintar el gráfico
visNetwork(nodos, aristas, main = "Grafo RDF con Colores por Predicado") %>%
  visEdges(arrows = "to", width = 2) %>% # width hace las líneas más gruesas
  visOptions(highlightNearest = TRUE)


#Fusión de Nodos ---------------------------------------------------------

# 1) ACTUALIZAR LA TABLA
# Agregamos la columna "Profesion" con valor fijo "Médico"
medicos <- tibble(
  ID = c(101, 102),
  Nombre = c("Dr. Smith", "Dra. Jones"),
  Ciudad = c("London", "Madrid")
) %>%
  mutate(Profesion = "Médico")

#2) CREAR EL PROCESO RDF CON NUEVO NAMESPACE
grafo_rdf <- rdf()

# Definimos las URIs base para usar en el bucle
base_data <- "http://hospital.ejemplo.org/datos/"
base_voc  <- "http://hospital.ejemplo.org/vocabulario/" # Nuevo Namespace para "Profesión"

for(i in 1:nrow(medicos)) {
  
  sujeto_uri <- paste0(base_data, medicos$ID[i])
  
  # Triple A: Nombre (Schema.org)
  rdf_add(grafo_rdf, 
          subject   = sujeto_uri,
          predicate = "http://schema.org/name", 
          object    = medicos$Nombre[i])
  
  # Triple B: Ciudad (Schema.org)
  rdf_add(grafo_rdf, 
          subject   = sujeto_uri,
          predicate = "http://schema.org/addressLocality", 
          object    = medicos$Ciudad[i])
  
  # Triple C: Profesión (NUESTRO NUEVO VOCABULARIO)
  # Usamos la URI base_voc + "tieneProfesion"
  rdf_add(grafo_rdf, 
          subject   = sujeto_uri,
          predicate = paste0(base_voc, "tieneProfesion"), 
          object    = medicos$Profesion[i]) 
}

# (Opcional) Aquí guardarías el archivo .ttl con los namespaces definidos
rdf_serialize(grafo_rdf, doc = "Practica_xml_rdf/EJEMPLO_TRIPLES_RDF/OUTPUT/medicos_v2.ttl", format = "turtle",
              namespace = c(data = base_data, 
                            voc  = base_voc, 
                            schema = "http://schema.org/"))


# 3) y 4) PREPARACIÓN VISUAL (CONEXIÓN Y COLORES)
# A. Extraemos los triples a un dataframe
df_grafico <- rdf_query(grafo_rdf, "SELECT ?s ?p ?o WHERE { ?s ?p ?o }")
colnames(df_grafico) <- c("from", "label", "to")

# B. Configuración de Nodos y Aristas
# Al ser "Médico" exactamente la misma cadena de texto para ambos,
# visNetwork entenderá automáticamente que es EL MISMO nodo.

aristas <- df_grafico %>%
  mutate(
    # Lógica de Colores (Punto 4: Naranja para la profesión)
    color = case_when(
      grepl("tieneProfesion", label) ~ "orange", # Si contiene "tieneProfesion" -> Naranja
      grepl("name", label)           ~ "blue",
      grepl("addressLocality", label)~ "red",
      TRUE                           ~ "black"
    ),
    # Limpiamos las etiquetas para que se vea bonito en el gráfico
    label = case_when(
      grepl("tieneProfesion", label) ~ "Profesión",
      grepl("name", label)           ~ "Nombre",
      grepl("addressLocality", label)~ "Ciudad",
      TRUE                           ~ label
    )
  )

nodos <- data.frame(id = unique(c(aristas$from, aristas$to)))
nodos$label <- nodos$id # Usamos el ID como etiqueta inicial

# Truco estético: Limpiamos las etiquetas de los nodos para quitar las URLs largas
nodos$label <- gsub("http://hospital.ejemplo.org/datos/", "", nodos$label)


# VISUALIZACIÓN FINAL
visNetwork(nodos, aristas, main = "Grafo Médico Conectado") %>%
  visEdges(arrows = "to", width = 2) %>%
  visNodes(shape = "dot", size = 20) %>%
  visOptions(highlightNearest = TRUE)

