library(rdflib)

# Cargar grafo RDF
g <- rdf_parse("Practica_xml_rdf/RDF_Example/personas_limpio.ttl")

# Consulta tipo SQL pero en SPARQL
query <- "
PREFIX schema: <http://schema.org/>

SELECT ?persona ?nombre ?ciudad
WHERE {
  ?persona a schema:Person ;
           schema:name ?nombre ;
           schema:homeLocation ?c .
  ?c schema:name ?ciudad .
}
"

res <- rdf_query(g, query)
print(res)
