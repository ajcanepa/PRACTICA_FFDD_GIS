# Construiremos un cladograma utilizando esta información para identificar el rango taxonómico de cada OTU, y su rango taxonómico parental compartido.

# https://github.com/ropensci/RNeXML/tree/9f66e55d0dc31f60047491ed38c0754fe323ede8
install.packages("RNeXML", deps = TRUE)
install.packages("phytools", deps = TRUE)
install.packages("xslt", deps = TRUE)
install.packages("rdflib", dependencies = TRUE)


# https://docs.ropensci.org/RNeXML/articles/sparql
library("rdflib")
library("xml2")
library("phytools")
library("RNeXML")


# Leemos un archivo de ejemplo que contiene anotaciones de metadatos semánticos que describen las unidades taxonómicas (OTU) utilizadas en el árbol.
nexml <- nexml_read(system.file("examples/primates.xml", package = "RNeXML"))

nexml

# Comenzamos extrayendo el grafo RDF del NeXML

rdf <- get_rdf(system.file("examples/primates.xml", package = "RNeXML"))

tmp <- tempfile()  # so we must write the XML out first

xml2::write_xml(rdf, tmp) 

graph <- rdf_parse(tmp)

# A continuación, obtenemos el URI del NCBI del taxón que tiene el rango "Orden", es decir, la raíz de la filogenia de los primates. El operador de punto . entre cláusulas implica una unión, en este caso.

root <- rdf_query(graph, 
                  "SELECT ?uri WHERE { 
    ?id <http://rs.tdwg.org/ontology/voc/TaxonConcept#rank> <http://rs.tdwg.org/ontology/voc/TaxonRank#Order> . 
    ?id <http://rs.tdwg.org/ontology/voc/TaxonConcept#toTaxon> ?uri    
}")

root

# Esto hace uso del lenguaje de consulta SPARQL proporcionado por el paquete rrdf. También definiremos algunas funciones de ayuda que utilizan consultas SPARQL. Aquí definimos una función para obtener el nombre

get_name <- function(id) {
  max <- length(nexml@otus[[1]]@otu)
  for(i in 1:max) {
    if ( nexml@otus[[1]]@otu[[i]]@id == id ) {
      label <- nexml@otus[[1]]@otu[[i]]@label
      label <- gsub(" ","_",label)
      return(label)
    }
  }
}


# A continuación, definimos una función recursiva para construir un árbol newick a partir de la información del rango taxonómico.

recurse <- function(node){
  
  # fetch the taxonomic rank and id string
  rank_query <- paste0(
    "SELECT ?rank ?id WHERE {
            ?id <http://rs.tdwg.org/ontology/voc/TaxonConcept#toTaxon> <",node,"> .
            ?id <http://rs.tdwg.org/ontology/voc/TaxonConcept#rank> ?rank
          }")
  result <- rdf_query(graph, rank_query)
  
  # get the local ID, strip URI part
  id <- result$id
  id <- gsub("^.+#", "", id, perl = TRUE)
  
  # if rank is terminal, return the name
  if (result$rank == "http://rs.tdwg.org/ontology/voc/TaxonRank#Species") {
    return(get_name(id))
  }
  
  # recurse deeper
  else {
    child_query <- paste0(
      "SELECT ?uri WHERE {
                ?id <http://www.w3.org/2000/01/rdf-schema#subClassOf> <",node,"> .
                ?id <http://rs.tdwg.org/ontology/voc/TaxonConcept#toTaxon> ?uri
            }")
    children <- rdf_query(graph, child_query)
    
    return(paste("(", 
                 paste(sapply(children$uri, recurse), 
                       sep = ",", collapse = "," ), 
                 ")",  
                 get_name(id), # label interior nodes
                 sep = "", collapse = ""))
  }
}


# Con estas funciones, es muy sencillo construir el árbol a partir de los datos semánticos RDFa y visualizarlo

newick <- paste(recurse(root), ";", sep = "", collapse = "")

tree <- read.newick(text = newick)

collapsed <- collapse.singles(tree)

plot(collapsed, 
     type = 'cladogram', 
     show.tip.label = FALSE, 
     show.node.label = TRUE, 
     cex = 0.75, 
     edge.color = 'grey60', 
     label.offset = -9)
