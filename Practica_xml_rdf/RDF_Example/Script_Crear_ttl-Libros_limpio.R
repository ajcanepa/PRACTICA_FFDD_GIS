# Contenido RDF/Turtle como vector de texto
ttl <- c(
  "@prefix ex: <http://example.org/> .",
  "@prefix schema: <http://schema.org/> .",
  "@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .",
  "",
  "# Personas",
  "ex:Ana a schema:Person ;",
  "       schema:name \"Ana Torres\" .",
  "",
  "ex:Carlos a schema:Person ;",
  "          schema:name \"Carlos Gómez\" .",
  "",
  "# Libros",
  "ex:Libro1 a schema:Book ;",
  "          schema:name \"Web Semántica Básica\" ;",
  "          schema:author ex:Ana ;",
  "          schema:datePublished \"2021\"^^xsd:gYear .",
  "",
  "ex:Libro2 a schema:Book ;",
  "          schema:name \"Linked Data Avanzado\" ;",
  "          schema:author ex:Carlos ;",
  "          schema:datePublished \"2023\"^^xsd:gYear ."
)

# Guardar en archivo UTF-8 sin BOM
writeLines(ttl, "Practica_xml_rdf/RDF_Example/libros.ttl")
