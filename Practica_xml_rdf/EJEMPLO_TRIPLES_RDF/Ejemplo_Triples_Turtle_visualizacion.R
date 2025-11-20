library(rdflib)
library(dplyr)

# 1. TUS DATOS
medicos <- tibble(
  ID = c(101, 102),
  Nombre = c("Dr. Smith", "Dra. Jones"),
  Ciudad = c("London", "Madrid")
)

# 2. PREPARACIÓN: Crear grafo vacío
grafo_rdf <- rdf()

# 3. CONSTRUCCIÓN (Igual que antes, usando URIs completas)
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

# 4. EXPORTAR (AQUÍ es donde definimos los prefijos)
# Pasamos un vector con nombre: c(PREFIJO = "URI")
rdf_serialize(grafo_rdf, 
              doc = "OUTPUT/mis_datos.ttl", 
              format = "turtle",
              namespace = c(ex = "http://hospital.ejemplo.org/", 
                            schema = "http://schema.org/"))


# Usamos una consulta SPARQL simple para sacar todo a un dataframe
df_grafico <- rdf_query(grafo_rdf, "SELECT ?s ?p ?o WHERE { ?s ?p ?o }")

# Renombramos para que las librerías lo entiendan mejor
colnames(df_grafico) <- c("from", "label", "to")

df_grafico


library(igraph)

# 1. Convertir dataframe a objeto igraph
g <- graph_from_data_frame(df_grafico, directed = TRUE)

# 2. Pintarlo
plot(g, 
     vertex.size = 20,           # Tamaño del nodo
     vertex.label.cex = 0.8,     # Tamaño letra
     edge.arrow.size = 0.5,      # Tamaño flecha
     main = "Visualización con igraph")


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
