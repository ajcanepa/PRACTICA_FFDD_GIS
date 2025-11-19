library(rdflib)

g <- rdf_parse("Practica_xml_rdf/RDF_Example/libros.ttl")

queryA <- "
PREFIX schema: <http://schema.org/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT ?autor ?nombreAutor ?libro ?titulo
WHERE {
  ?autor a schema:Person ;
         schema:name ?nombreAutor .
  ?libro a schema:Book ;
         schema:name ?titulo ;
         schema:author ?autor .
}
ORDER BY ?nombreAutor
"

resultadoA <- rdf_query(g, queryA)
print(resultadoA)


queryB <- "
PREFIX schema: <http://schema.org/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT ?libro ?titulo ?anio
WHERE {
  ?libro a schema:Book ;
         schema:name ?titulo ;
         schema:datePublished ?anio .
  FILTER(xsd:gYear(?anio) > \"2021\"^^xsd:gYear)
}
"

resultadoB <- rdf_query(g, queryB)
print(resultadoB)
