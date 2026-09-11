# Importación de Datos ----------------------------------------------------
# * Importar *.xls y *.xlsx -----------------------------------------------
library(readxl)
Galapagos <- read_excel("INPUT/DATA/Galapagos_DB.xlsx", 
                        sheet = "DBR")
Galapagos
str(Galapagos)
summary(Galapagos)
# View(Galapagos) # Just in case


# * Importación desde CSV -------------------------------------------------
library(readr)
Acc_Car <- read_delim("INPUT/DATA/accidentalidad-por-carreteras.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE)

Acc_Car
summary(Acc_Car)
# View(Acc_Car)   # (comentado: View() abre el visor y no es reproducible al ejecutar el script)

table(Acc_Car$T.RED)

# Modificando el tipo (clase) de cada Columna
Acc_Car <- read_delim("INPUT/DATA/accidentalidad-por-carreteras.csv",
                      delim = ";", escape_double = FALSE, trim_ws = TRUE,
                      col_types = cols(
                        T.RED = readr::col_factor(levels = NULL)
                      ))

Acc_Car
str(Acc_Car)
summary(Acc_Car)

# * Importación desde la Web ----------------------------------------------
# Agua consumo humano desde la red
Agua_Consumo <- read_delim("https://datosabiertos.jcyl.es/web/jcyl/risp/es/salud/calidad-aguas-consumo/1284839789043.csv",
                           delim = ";")

Agua_Consumo
summary(Agua_Consumo)

Agua_Consumo$`Nº infraestructuras - Depósitos`
Agua_Consumo$`Nº de zonas de abastecimiento`
Agua_Consumo$`Análisis efectuados en las infraestructuras - Análisis completo`
Agua_Consumo$`Nº boletines analíticos de calidad de aguas de consumo humano por su calificación - Apta para el consumo con no conformidad`

# Datos Semi-Estructurados ------------------------------------
# * Importación desde CSV -------------------------------------------------
# Accidentalidad por Carreteras
# https://analisis.datosabiertos.jcyl.es/explore/dataset/accidentalidad-por-carreteras/export/?sort=ano
# Detalle en: https://datosabiertos.jcyl.es/web/jcyl/binarios/582/267/%C3%8Dndices_de_accidentalidad.pdf?blobheader=application%2Fpdf%3Bcharset%3DUTF-8&blobnocache=true
# Índice de Peligrosidad “IP” / Índice de Mortalidad “IM” / Índice de Accidentalidad Total “IAT” / Índice de Lesividad “IL” / Índice de Gravedad “IG”
library(readr)
Acc_Car <- read_delim("INPUT/DATA/accidentalidad-por-carreteras.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE)

Acc_Car

str(Acc_Car)
summary(Acc_Car)
#View(Acc_Car)

# * Desde JSON ------------------------------------------------------------
# Teoría json
# https://cran.r-project.org/web/packages/tidyjson/vignettes/visualizing-json.html
# https://www.json.org/json-en.html
library(tidyverse)
library(jsonlite)

# jsonlite::fromJSON() acepta una ruta local, una URL o una cadena de texto y,
# por defecto, simplifica el resultado a data.frame si el JSON representa una tabla
Acc_Car_Json <- fromJSON("INPUT/DATA/accidentalidad-por-carreteras.json")

Acc_Car_Json
head(Acc_Car_Json)

# ** Uso de tidyjson ------------------------------------------------------
# devtools::install_github("colearendt/tidyjson")
#https://github.com/colearendt/tidyjson
library(tidyjson)

data("worldbank")

head(worldbank)
# View(worldbank)   # (comentado: View() abre el visor y no es reproducible al ejecutar el script)

# Usamos `spread_all()` para formatear los datos
spread_all(worldbank)

worldbank %>% 
  spread_all() %>% 
  View()

# Aproximación Tidy para los accidentes en carretera
# tidyjson trabaja sobre el JSON "en crudo" (texto), no sobre el data.frame de jsonlite:
# leemos el fichero como una cadena de texto para pasárselo a las funciones de tidyjson
Acc_Car_Json_raw <- paste(readLines("INPUT/DATA/accidentalidad-por-carreteras.json"), collapse = "")

spread_all(Acc_Car_Json_raw)

Acc_Car_Json_raw %>%
  spread_all()
# %>% View()   # (comentado: View() abre el visor y no es reproducible al ejecutar el script)

# Guardamos el objeto
Acc_Car_TJson <- spread_all(Acc_Car_Json_raw)

# comparando
Acc_Car_TJson
lobstr::obj_size(Acc_Car_TJson)

Acc_Car
lobstr::obj_size(Acc_Car)


# Revisando que no existan arrays --> sino: https://github.com/colearendt/tidyjson#examples
spread_all(Acc_Car_Json_raw)
# %>% View()   # (comentado: View() abre el visor y no es reproducible al ejecutar el script)

Acc_Car_Json_raw %>%
  gather_object %>%
  json_types %>%
  count(name, type)

# ¿Qué pasa con el conjunto de datos WorldBank?
# worldbank %>% 
#   spread_all() %>% 
#   View()
worldbank %>% spread_all %>% glimpse() #str equivalent

# Funciona el spread_all? ¿hay arrays?
worldbank %>% 
  spread_all() %>% 
  gather_object %>% 
  json_types %>% 
  count(name, type)

# Observamos que uno de los elemetos sigue siendo un array. Para ingresar dentro de ese array, tenemos que:
worldbank %>%
  enter_object(majorsector_percent) %>%
  gather_array %>%
  spread_all %>%
  select(-document.id, -array.index)

# Si buscamos la inversión promedio para las diferentes zonas macroeconómicas
# Revisar el pipeline paso a paso
worldbank %>%
  spread_all %>% 
  select(region = regionname, funding = totalamt) %>%
  enter_object(majorsector_percent) %>% 
  gather_array() %>% 
  spread_all() %>% 
  rename(sector = Name, percent = Percent) %>%
  group_by(region, sector) %>%
  summarize(funding = mean(percent, na.rm = TRUE))

# EJERCICIO
# Gráfica de barras con las áreas geográficas en el eje X, el promedio de inversiones en el Y y con colores para cada sector de inversión (quitando "Other")

# * Desde XML -------------------------------------------------------------
# https://megapteraphile.wordpress.com/2020/03/29/converting-xml-to-tibble-in-r/
library(tidyverse)
library(XML)
library(xml2)

# Directo desde la web
file_url <- "https://www.w3schools.com/xml/simple.xml"
Data <- read_xml(file_url)

#Desde ficheros propios
#Data <- read_xml(x = "INPUT/DATA/simple.xml")

# `data` es un xml_document que contiene el contenido del documento xml, incluidas las etiquetas y el texto.
str(Data) # No mucha info porque no es tabular
Data

# la función `xmlParse()` del paquete XML, permite reconocer la gramática de xml y extraerla en formato xml.
Data_mxl <- xmlParse(Data)
Data_mxl

attributes(Data_mxl)

# ** De xml a data.frame --------------------------------------------------
# Usamos la función `xmlToDataFrame()` del paquete `XML`. 
DF_xml <- xmlToDataFrame(doc = Data_mxl, stringsAsFactors = FALSE)
DF_xml
str(DF_xml)

# Limpiamos y definimos correctamente las clases

DF_xml %>% 
  as_tibble() %>%
  transmute(
    name = factor(name),
    price_dollars = parse_number(price),
    description = description,
    calories = as.numeric(calories)
  )

# Creamos un objeto (intermedio)
Tibble_xml <- 
  DF_xml %>% 
  as_tibble() %>%
  transmute(
    name = factor(name),
    price_dollars = parse_number(price),
    description = description,
    calories = as.numeric(calories)
  )

Tibble_xml

# Graficamos
# Tibble_xml %>% 
#   ggplot(data = ., mapping = aes(x = name, y = price_dollars)) +
#   geom_bar(stat = "identity", aes(fill = calories))

Tibble_xml %>% 
  ggplot(data = ., mapping = aes(x = reorder(name, -price_dollars), y = price_dollars)) +
  geom_bar(stat = "identity", aes(fill = calories)) +
  scale_fill_gradient(low = "peachpuff", high = "red", space = "Lab", na.value = "grey50", guide = "colourbar",  aesthetics = "fill") +
  labs(x = "", y = "Precio (U.S. $)", fill = "Calorías") +
  scale_y_continuous(expand = expansion(mult = c(0, .1))) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1))


# Sin necesidad de crear el objeto
DF_xml %>% 
  as_tibble() %>%
  transmute(
    name = factor(name),
    price_dollars = parse_number(price),
    description = description,
    calories = as.numeric(calories)
  ) %>% 
  ggplot(data = ., mapping = aes(x = reorder(name, -price_dollars), y = price_dollars)) +
  geom_bar(stat = "identity", aes(fill = calories)) +
  scale_fill_gradient(low = "peachpuff", high = "red", space = "Lab", na.value = "grey50", guide = "colourbar",  aesthetics = "fill") +
  labs(x = "", y = "Precio (U.S. $)", fill = "Calorías") +
  scale_y_continuous(expand = expansion(mult = c(0, .1))) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1))


# Exportación de Datos  ---------------------------------------------------


# * Exportar environment --------------------------------------------------

# ** Exportar objetos de R ------------------------------------------------
?saveRDS

# Carga de datos
data("worldbank")

# Tabulación sin crear objeto (a modo de prueba)
worldbank %>% 
  spread_all() 

# Creación de un objeto con los datos tabulados
Data_WorldBank <-
  worldbank %>%
  spread_all() 

Data_WorldBank

# Guardamos el objeto creado
saveRDS(object = Data_WorldBank, file = "OUTPUT/DATA/WorldBankData.rds")

# Cargamos el objeto de R guardado como rds.
rm(Data_WorldBank)

Data_WorldBank <- readRDS(file = "OUTPUT/DATA/WorldBankData.rds")


# ** Exportar Environment de R --------------------------------------------
# Como guardar TODOS los objetos que hemos creado.
# Para guardar los objetos del "Environment", usamos save.image()

# * Exportar a excel/csv --------------------------------------------------
write_csv(x = Data_WorldBank, file = "OUTPUT/DATA/WorldBankData.csv")
write_delim(x = Data_WorldBank, file = "OUTPUT/DATA/WorldBankData.txt", delim = ",") # probar con delim = ";"

# * Exportar a JSON -------------------------------------------------------
# La operación inversa de fromJSON() es toJSON() (paquete jsonlite)

x <- list(
  alpha = 1:5,
  beta  = "Bravo",
  gamma = list(a = 1:3, b = NULL),
  delta = c(TRUE, FALSE)
)

x

# pretty = TRUE indenta el JSON resultante para que sea legible por humanos
JSON_x <- toJSON(x, pretty = TRUE)
cat(JSON_x)

# auto_unbox = TRUE convierte los vectores de longitud 1 en escalares JSON
# ("Bravo" en lugar de ["Bravo"]), lo habitual al serializar un único registro
toJSON(list(nombre = "Ana", edad = 34), auto_unbox = TRUE, pretty = TRUE)

# La conversión de ida y vuelta (round-trip) recupera el objeto de R original
fromJSON(JSON_x)

write(x = JSON_x, file = "OUTPUT/DATA/JSON_x.json")


# Usando el conjunto de datos starwars
jsonstarwars <- toJSON(dplyr::starwars, pretty = TRUE)
cat(jsonstarwars)
fromJSON(jsonstarwars)

write(x = jsonstarwars, file = "OUTPUT/DATA/StarWars.json")


# * Exportar a xml --------------------------------------------------------
# file_url <- "https://www.w3schools.com/xml/simple.xml"  # ya estaba ejecutado
# Data <- read_xml(file_url)                              # ya estaba ejecutado
Data
write_xml(x = Data, file = "OUTPUT/DATA/Data.xml")
