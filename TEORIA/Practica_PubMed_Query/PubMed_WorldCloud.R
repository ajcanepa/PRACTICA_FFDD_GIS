# Instalación y Carga de Paquetes -----------------------------------------
# library(devtools)
# install_github("felixfan/PubMedWordcloud") # from GitHub

library(PubMedWordcloud)  


# Obtener PubMed Reference Numbers (PMIDs) --------------------------------
pmid1 <- getPMIDs(author = "Yan-Hui Fan", dFrom = 2007, dTo = 2020, n = 10)
pmid1

pmid2 <- getPMIDs(author="Yanhui Fan",dFrom=2007,dTo=2020,n=10)
pmid2


# Editar listado de artículos no propios ----------------------------------
# Dos artículos PMIDs son de otro autor
rm1 <- "22698742"
pmids1 <- editPMIDs(x=pmid1,y=rm1,method="exclude")

rm2 <- "20576513"
pmids2 <- editPMIDs(x=pmid2,y=rm2,method="exclude")

# Se unen todos los PMIDs en un solo vector
pmids <- editPMIDs(x=pmids1,y=pmids2,method="add")


# Obtención de resúmenes --------------------------------------------------
abstracts <- getAbstracts(pmids)


# Limpieza de resúmenes ---------------------------------------------------
cleanAbs <- cleanAbstracts(abstracts)


# Gráficas de Nube de Palabras --------------------------------------------
# Gráfico base
# x11()
plotWordCloud(cleanAbs,min.freq = 2, scale = c(2, 0.3))

# Sin rotar las palabras
plotWordCloud(cleanAbs,min.freq = 10, scale = c(2, 0.3),rot.per=0)

# Usando otra paleta de colores
colors <- colSets(type="Paired")
plotWordCloud(cleanAbs,min.freq = 2, scale = c(2, 0.3),colors=colors)

# Quitando las palabras derivadas (Stemming words)
cleanAbs2 <- cleanAbstracts(abstracts,stemDoc =TRUE)
plotWordCloud(cleanAbs2,min.freq = 2, scale = c(2, 0.3))


