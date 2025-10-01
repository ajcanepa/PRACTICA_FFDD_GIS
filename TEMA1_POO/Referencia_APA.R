Referencia_APA <- function(doi = NULL, BIBTEX = FALSE) {
  # Verifica si el DOI está presente
  if (is.null(doi)) {
    stop("Debes proporcionar un DOI.")
  }
  
  # Instalar y cargar paquetes necesarios
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(rcrossref, lubridate, RefManageR, stringr)
  
  # Limpiar el DOI si viene con el prefijo completo
  doi_clean <- sub("https?://doi.org/", "", doi)
  
  # Obtener datos del artículo
  article_data <- tryCatch(
    cr_works(dois = doi_clean)$data,
    error = function(e) {
      stop("Error al obtener los datos del DOI. Verifica que sea válido.")
    }
  )
  
  # Procesar autores en formato APA: "Apellido, Iniciales."
  authors_df <- article_data$author[[1]]
  format_author <- function(author) {
    initials <- str_extract_all(author$given, "\\b\\w") %>% unlist() %>% paste(collapse = ".")
    paste0(author$family, ", ", initials, ".")
  }
  authors_formatted <- sapply(seq_len(nrow(authors_df)), function(i) format_author(authors_df[i, ]))
  authors_APA <- paste(authors_formatted, collapse = ", ")
  
  # Si hay más de 20 autores, usar el formato APA con "..." y el último autor
  if (length(authors_formatted) > 20) {
    authors_APA <- paste0(
      paste(authors_formatted[1:19], collapse = ", "),
      ", ... ",
      authors_formatted[length(authors_formatted)]
    )
  }
  
  # Título del artículo (sin etiquetas HTML)
  title <- gsub("<[^>]*>", "", article_data$title)
  
  # Nombre de la revista
  journal <- article_data$container.title
  
  # Volumen, número, páginas
  volume <- article_data$volume
  issue <- article_data$issue
  pages <- article_data$page
  
  # Año de publicación
  year <- NA
  if (!is.null(article_data$published.online)) {
    year <- year(ymd(article_data$published.online))
  } else if (!is.null(article_data$published.print)) {
    year <- year(ymd(article_data$published.print))
  } else {
    year <- article_data$created$`date-parts`[[1]][1]
  }
  
  # Construir referencia en formato APA
  reference_APA <- paste0(
    authors_APA, " (", year, "). ",
    title, ". ",
    journal, ", ",
    volume, if (!is.null(issue)) paste0("(", issue, ")"), ", ",
    pages, ". https://doi.org/", doi_clean
  )
  
  # Imprimir la referencia APA
  cat("\n📘 Referencia APA:\n")
  cat(reference_APA, "\n")
  
  # Si se solicita, imprimir también la entrada BibTeX
  if (BIBTEX) {
    bib <- tryCatch(
      RefManageR::GetBibEntryWithDOI(doi_clean),
      error = function(e) {
        warning("No se pudo obtener la entrada BibTeX para este DOI.")
        return(NULL)
      }
    )
    if (!is.null(bib)) {
      cat("\n📚 Entrada BibTeX:\n")
      print(toBibtex(bib))
    }
  }
}
