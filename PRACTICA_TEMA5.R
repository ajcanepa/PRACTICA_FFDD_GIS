## TEMA 5 ##
# Vectores ----------------------------------------------------------------
# * Vectores atómicos -----------------------------------------------------

# Crear un objeto
x <- 3

# Imprimir (en consola) un objeto
print(x)
# Para pedir ayuda de una función en línea se usa el ?
?print

x
class(x)
typeof(x)

#Vector numérico entero
y <- 3L
class(y)
typeof(y)

# Vector operación matemática
z <- 1L + 1L
z
class(z)
typeof(z)

# Tipos de vectores
lgl_var <- c(TRUE, FALSE)
int_var <- c(1L, 6L, 10L)
dbl_var <- c(1, 2.5, 4.5)
chr_var <- c("these are", "some strings")

typeof(chr_var)

# ** Valores Ausentes -----------------------------------------------------
x <- c(1,5,8,10)
mean(x)

x <- c(1, 5, NA, 10)
mean(x)

mean(x, na.rm = TRUE)

is.numeric(x)
as.character(x)

# ** Coacción (Coercion) --------------------------------------------------
# Regla para coercion: character → double → integer → logical
c(1,2,3)
typeof(c(1,2,3))

c(1,2,"Pablo")
typeof(c(1,2,'Pablo'))

c(TRUE,FALSE,FALSE, 2L, 3.53, "estamos dormidos")
typeof(c(TRUE,FALSE,FALSE, 2L, 3.55))
typeof(c(TRUE,FALSE,FALSE, 1L, 2, "Tubby"))

# Regla de coercion --> útil
x <- c(FALSE, FALSE, TRUE)
x
is.logical(x)
as.numeric(x)
typeof(x)

#Funciones matemáticas también siguen la "coercion"
sum(x)
mean(x)
sum(c("Todos", "estamos", "aburrid@s"))

# Forzar con as. a un cáracter
c(1, 1.5, "A")
as.numeric(c(1, 1.5, "Joaquina"))

x <- c(1, 1.5, "A")
typeof(x)

# ** Nombres -----------------------------------------------------------------
# Primera aproximación a entrega de nombres (de elementos)
x <- c(a = 1, b = 2, c = 3)
x
class(x)
typeof(x)
attributes(x)
names(x)


# Segunda aproximación a entrega de nombres (de elementos)
x <- c(1:5)
x
attributes(x)
length(x)

names(x) <- c("a", "b", "c")
names(x)

# Tercera aproximación a entrega de nombres (de elementos)
x <- setNames(1:3, c("h", "j", "k"))
names(x)
x
# Para quitar los nombres usamos unname()
x <- unname(x)
x

# ** Dimensiones ----------------------------------------------------------
# VECTORES
x <- c(1:5)

dim(x)
length(x)

# MATRICES
x <- matrix(c(1:10, "hola", "pablo"), nrow = 3, ncol = 4)
x

dim(x)
class(x)
typeof(x)

x <- matrix(letters[1:6], nrow = 3, ncol = 4)
x

dim(x)
class(x)
typeof(x)


# DATAFRAMES
df1 <- data.frame(
  Numeros = 1:5, 
  Letras = letters[1:5])

df1

dim(df1)
class(df1)
typeof(df1)
attributes(df1)

# LISTAS
l1 <- list(
  Enteros = 1:50, 
  Letra = "a", 
  Logico = c(TRUE, FALSE, TRUE), 
  Numeros = c(2.3, 5.9)
)

l1

dim(l1)
typeof(l1)
length(l1)
attributes(l1)
str(l1)

# ** Indexación Vectores --------------------------------------------------
A <- c("a", "b", "c", "d", "e", "f", "g", "h")
A

# Elementos dentro del vector A
A[3]

# Rango
A[1:3]

# Último elemento
length(A)
A[8]
A[length(A)]

# indexacion de vectores devuelve mismo vector
A[1:3]
typeof(A[1:3])

# ** Factores -------------------------------------------------------------
x <- factor(c("a", "b", "b", "a"))
x
typeof(x)
attributes(x)

# Ejemplo #2 de factores
sex_char <- c("m", "m", "m")
sex_char
typeof(sex_char)
table(sex_char)

sex_factor <- factor(sex_char, levels = c("m", "f"), labels = c("Macho", "Hembra"))
sex_factor

attributes(sex_factor)
table(c("m", "m", "m"))
table(sex_factor)

# ** Factores ordinales ---------------------------------------------------
grade <- ordered(c("b", "b", "a", "c"), levels = c("c", "b", "a"))
grade


# * Fechas ----------------------------------------------------------------
# Los vectores de fecha se construyen sobre los vectores dobles
today <- Sys.Date()
today
class(today)
typeof(today)
attributes(today)

# Fechas desde caracter
c("1970-02-01")
class(c("1970-02-01"))
Newdate <- as.Date(c("1970/02/01"))
Newdate
class(Newdate)
unclass(Newdate)

# * Fechas-Horas ----------------------------------------------------------
# Base R proporciona dos formas de almacenar información de fecha y hora, POSIXct y POSIXlt.
now_ct <- as.POSIXct("2018-08-01 22:00", tz = "UTC")
now_ct
typeof(now_ct)
attributes(now_ct)

#tzone, permite cambiar la zona horaria muy fácilmente
structure(now_ct)
structure(now_ct, tzone = "Asia/Tokyo")
structure(now_ct, tzone = "Australia/Lord_Howe")

# * Duraciones ------------------------------------------------------------
# Representan la cantidad de tiempo entre pares de fechas o fechas-horas.
# Se almacenan en `difftimes`

one_week_1 <- as.difftime(1, units = "weeks")
one_week_1
typeof(one_week_1)
attributes(one_week_1)

one_week_2 <- as.difftime(7, units = "days")
one_week_2
typeof(one_week_2)
attributes(one_week_2)

difftime(structure(now_ct), structure(now_ct), units = "week")

difftime(structure(now_ct), structure(Sys.Date()), units = "hours")


# Matrices/Arrays ---------------------------------------------------------
# Matrices guardan la información en 2 dimensiones
# Arrays guardan la información en 2 o más dimensiones
m <- matrix(seq(1:6), nrow = 2)
m <- matrix(seq(1:6), nrow = 2, byrow = TRUE)
m
str(m)
typeof(m)
class(m)

# * Coercion --------------------------------------------------------------
m
m1 <- matrix(c(1, 2, 3, 4, 5, "Pablo"), nrow = 2)
m1
str(m1)
typeof(m1)


# ** Indexación de Matrices -----------------------------------------------
# Al haber dos dimensiones, la indexación respeta estas dimensiones
# Siempre: "filas, columnas"
m2 <- matrix(seq(1:8), nrow = 4, byrow = TRUE)
m2

# Indexación por posición
dim(m2)

# Indexación de la segunda fila (fila = 2, columnas = todas)
m2[2,]

# Indexación de la segunda columna (fila = todas, columnas = 2)
m2[,2]

# Indexación por nombres
colnames(m2)
colnames(m2) <- c("Impares", "Pares")
colnames(m2)

m2

# Primera columna
m2[,1]
m2[,"Impares"]

# Segunda columna
m2[1:3,"Pares"]

m2[c(1,2,4),"Pares"]

# indexación matrices no cambia la clase
class(m2)
typeof(m2)

str(m2[1:3,"Pares"])
class(m2[1:3,"Pares"])
typeof(m2[1:3,"Pares"])

# Tabla de datos (Dataframe) ----------------------------------------------
# Probablemente el formato más usado. 
#Análogo heterogéneo de las matrices.
df1 <- data.frame(
  Numeros = 1:5, 
  Letras = letters[1:5])

str(df1)
typeof(df1)
attributes(df1)

# Carga de paquete y uso de tibble
library(dplyr)

df2 <- tibble(
  Numeros = 1:5, 
  Letras = letters[1:5])
df2
typeof(df2)
str(df2)


# ** Concatenación/Combinación de dataframes -------------------------------
#

# Ciclado en dataframes
data.frame(x = 1:4, y = 'Spain')


# *** Tibble v/s Dataframe ------------------------------------------------

#data.frame
data.frame(
  x = 1:3,
  y = x * 2
)

# tibble
# library(dplyr) # debería estar cargado de antes
tibble(
  x = 1:3,
  y = x*2
)

dplyr::starwars

# ** Indexación de dataframes ---------------------------------------------
df1
df2

# Indexación por nombre
df1$Numeros
str(df1$Numeros)

df2$Letras
str(df2$Letras)

# Indexar por posición
df1
df1[1:2,2]
df1[,1]

# indexación por posición y nombre
df1$Letras
df1[, "Letras"]
df1[1:3, "Letras"]

df1[c(1,3,5), "Letras"]

# Diff. tibble v/s data.frame
# df1 = dataframe
str(df1$Numeros)
# df2 es un vector
str(df2$Numeros)

str(df1$Nu)
str(df2$Nu)



# Listas ------------------------------------------------------------------
# Análogos heterogéneos de los vectores
# función `list()`

l1 <- list(
  Enteros = c(1:3), 
  Letra = c("a"), 
  Logico = c(TRUE, FALSE, TRUE), 
  Numeros = c(2.3, 5.9)
)

l1

typeof(l1)
str(l1)

# Lazy-evaluation en listas
lobstr::obj_size(mtcars)

l2 <- list(mtcars, mtcars, mtcars, mtcars[1:3, 2])
lobstr::obj_size(l2)


# ** Combinación de listas ------------------------------------------------
# Listas --> vectores recursivos
l4 <- list(list(1,2), c(3,4))
l4

l5 <- c(list(1,2), c(3,4))
str(l5)


# **Coacción / Coercion de Listas -----------------------------------------
# Para probar una lista usar `is.list()`.
# Para coaccionar a una lista usar `as.list()`.
list(1:3)

typeof(list(1:3))

seq(1:3)
list(seq(1:3))
typeof(seq(1:3))

as.list(seq(1:3))

typeof(as.list(seq(1:3)))

list(c(seq(1:3), "hola"))

typeof(list(c(seq(1:3), "hola")))

# ** Indexación de Listas -------------------------------------------------
# Al igual que las Matrices las listas se pueden indexar por posición (Dimensión) y/o por nombre, o por ambas.
l1
l1[[3]][2]
# Por dimensión
l1[[1]]
l1[[1]][2]
l1[[3]][2]
str(l1[[1]])

#Por nombre
str(l1)

l1$Logico[3]
l1$Letra

#agrego una dimensión más
# Sin entregar el nombre
l1[[5]] <- df2
str(l1)

# A través de entregar el nombre
l1$DataFrame <- df1
str(l1)
l1

l1[[5]]$Letras[3]

l1[[5]]$Letras

l1$Logico
l1$Logico[2]

# Muy poco usado
l1[["Logico"]]


# Funciones en R ----------------------------------------------------------

# * Condicionales ---------------------------------------------------------

# ** Condicional `if` -----------------------------------------------------
# Determinar si un paciente tiene presión arterial alta. 
# La presión arterial alta se define aquí como una presión sistólica mayor a 140 mmHg.

# Definir la presión arterial sistólica de un paciente
presion_sistolica <- 145

# Utilizar una estructura if para verificar si la presión arterial es alta
if (presion_sistolica > 140) {
  print("El paciente tiene presión arterial alta.")
}


# ** Condicional `if-else` ------------------------------------------------
# Ahora vamos a realizar una clasificación más detallada de la presión arterial. 
# La presión arterial se considera normal si es menor o igual a 120 mmHg, alta si está entre 121 y 140 mmHg, y muy alta si es mayor a 140 mmHg.

# Definir la presión arterial sistólica de un paciente
presion_sistolica <- 135

# Utilizar una estructura if-else para clasificar la presión arterial
if (presion_sistolica <= 120) {
  print("La presión arterial del paciente es normal.")
} else if (presion_sistolica <= 140) {
  print("El paciente tiene presión arterial alta.")
} else {
  print("El paciente tiene presión arterial muy alta.")
}


# ** Condicional `ifelse` -------------------------------------------------
# Usaremos ifelse para aplicar una función vectorial a un conjunto de datos. 
# Supongamos que tenemos un vector con las presiones arteriales de varios pacientes y queremos etiquetarlos como "Normal", "Alta" o "Muy alta".

# Definir un vector con las presiones arteriales de varios pacientes
presiones_sistolicas <- c(115, 130, 145, 125, 110)

# Utilizar ifelse para clasificar cada valor en el vector
clasificacion <- ifelse(
  presiones_sistolicas <= 120, 
  "Normal", 
  ifelse(
    presiones_sistolicas <= 140, 
    "Alta", 
    "Muy alta"
  )
)

# Mostrar la clasificación
print(clasificacion)



# * Iteraciones -----------------------------------------------------------

# ** tapply / apply -------------------------------------------------------

#  *** `tapply()` ---------------------------------------------------------
# El comando tapply en R se utiliza para aplicar una función a subconjuntos de datos, agrupados por una variable.
# Supongamos que tenemos un conjunto de datos sobre pacientes diabéticos y queremos calcular la media de los niveles de glucosa en sangre para diferentes categorías de índice de masa corporal (IMC).

# Crear un dataframe con datos simulados sobre pacientes diabéticos
datos <- data.frame(
  paciente = 1:10,
  glucosa = c(120, 135, 140, 125, 130, 155, 145, 160, 150, 165),
  imc_categoria = c('Normal', 'Sobrepeso', 'Obesidad', 'Normal', 'Sobrepeso', 
                    'Obesidad', 'Obesidad', 'Sobrepeso', 'Normal', 'Obesidad')
)

# Usar tapply para calcular la media de los niveles de glucosa por categoría de IMC
media_glucosa <- tapply(datos$glucosa, datos$imc_categoria, mean)

# Mostrar los resultados
print(media_glucosa)

# tapply: Aplica la función mean a los valores en glucosa, agrupados por la variable imc_categoria. Esto devuelve la media de glucosa para cada categoría de IMC.
# tapply: Es útil cuando tienes un dataframe y quieres aplicar una función a grupos de datos definidos por una variable categórica.


# *** `apply()` -----------------------------------------------------------
# El comando apply en R se utiliza para aplicar una función a las márgenes de una matriz o dataframe
# Supongamos que tenemos una matriz con niveles de glucosa en sangre para varios pacientes en diferentes momentos y queremos calcular la media de glucosa para cada paciente.

# Crear una matriz con datos simulados sobre niveles de glucosa en sangre
glucosa_matriz <- matrix(
  c(120, 135, 140, 
    125, 130, 155, 
    145, 160, 150, 
    165, 170, 175), 
  nrow = 4, 
  byrow = TRUE,
  dimnames = list(paciente = paste("Paciente", 1:4), 
                  momento = paste("Momento", 1:3))
)

glucosa_matriz

# Usar apply para calcular la media de los niveles de glucosa por paciente
media_por_paciente <- apply(glucosa_matriz, 1, mean)

# Mostrar los resultados
print(media_por_paciente)

# apply: Aplica la función mean a las filas (MARGIN = 1) de la matriz. Esto devuelve la media de glucosa para cada paciente.
# apply: Es útil cuando trabajas con matrices o dataframes y quieres aplicar una función a lo largo de una dimensión específica (filas o columnas).

# ** While Loop -----------------------------------------------------------
# Monitoreo de Nivel de Glucosa en Sangre
# Necesitamos medir los niveles diarios de glucosa hasta que el nivel de glucosa sea menor o igual a un valor objetivo (por ejemplo, 120 mg/dL)

# Definir el nivel de glucosa objetivo
nivel_objetivo <- 120

# Inicializar el nivel de glucosa del paciente
nivel_glucosa <- 150

# Inicializar un contador para registrar las lecturas
contador <- 0

# Simular la toma de lecturas de glucosa hasta alcanzar el nivel objetivo
while (nivel_glucosa > nivel_objetivo) {
  # Aumentar el contador
  contador <- contador + 1
  
  # Simular la toma de una nueva lectura de glucosa
  # Aquí usamos una función aleatoria para simular la variación en el nivel de glucosa
  nivel_glucosa <- nivel_glucosa - sample(1:10, 1)
  
  # Mostrar el nivel de glucosa actual y el número de lecturas tomadas
  cat("Lectura", contador, ": Nivel de glucosa =", nivel_glucosa, "mg/dL\n")
}

cat("El nivel de glucosa ha alcanzado o está por debajo del objetivo después de", contador, "lecturas.\n")

# ** For Loop -------------------------------------------------------------

# *** For loop sencillo  --------------------------------------------------
# Queremos asignar a cada paciente a una habitación disponible. Usaremos un for loop para hacer esta asignación.

# Número de habitaciones disponibles
num_habitaciones <- 5

# Crear una lista de pacientes
pacientes <- c("Paciente1", "Paciente2", "Paciente3", "Paciente4", "Paciente5", "Paciente6")

# Inicializar un vector para almacenar la asignación de habitaciones
asignacion <- vector("list", length(pacientes))

# Asignar habitaciones a los pacientes
for (i in 1:length(pacientes)) {
  # Calcular la habitación asignada utilizando el operador módulo
  habitacion <- ((i - 1) %% num_habitaciones) + 1
  
  # Guardar la asignación en el vector
  asignacion[[i]] <- paste(pacientes[i], "se asigna a la habitación", habitacion)
}

# Mostrar los resultados de la asignación
for (asignacion_paciente in asignacion) {
  cat(asignacion_paciente, "\n")
}

# *** For loop anidado ----------------------------------------------------
# cada paciente debe someterse a exámenes de radiografía en diferentes fechas. Usaremos for loops anidados para asignar fechas de examen a cada paciente.

# Crear una lista de pacientes
pacientes <- c("Paciente1", "Paciente2", "Paciente3")

# Crear un vector con las fechas de los exámenes
fechas_examen <- c("2024-09-01", "2024-09-15", "2024-10-01")

# Inicializar una lista para almacenar la programación de exámenes
programacion_examenes <- list()

# Loop para asignar fechas a pacientes
for (paciente in pacientes) {
  # Inicializar una lista para almacenar las fechas de examen para un paciente
  programacion_examenes[[paciente]] <- vector("list", length(fechas_examen))
  
  # Loop anidado para asignar fechas de examen a cada paciente
  for (fecha in fechas_examen) {
    # Guardar la fecha de examen en la lista correspondiente al paciente
    programacion_examenes[[paciente]][[fecha]] <- paste("Examen de radiografía programado para", fecha)
  }
}

# Mostrar la programación de exámenes para cada paciente
for (paciente in names(programacion_examenes)) {
  cat("\n", paciente, ":\n")
  for (examen in programacion_examenes[[paciente]]) {
    cat(" -", examen, "\n")
  }
}



# * Funciones Propias en R ------------------------------------------------
# Trabajo con secuencias genéticas


# ** Conteo de nucleótidos ------------------------------------------------
# definimos la cadena de DNA
seq_dna <- c("ATGTCACCACAAACAGAGACT")
seq_dna

# Crear una función `contar_nucleotidos()`, que nos permitirá contar el número de cada uno de los nucleótidos que tenemos en nuestra secuencia.
contar_nucleotidos <- function(secuencia_dna = seq_dna) {
  conteo_nucleotidos = unlist(strsplit(x = secuencia_dna, split = "", fixed = TRUE))
  print(table(conteo_nucleotidos))
}

# Comentar objetos dentro de funciones
conteo_nucleotidos

# Usamos la función
contar_nucleotidos(secuencia_dna = seq_dna)


# ** Cadena complementaria ------------------------------------------------
# Cada vez que un nucleótido de nuestra cadena sea `A`, en la cadena complementaria correspondiente, el nucleótido que le tocaría sería el `T`.
# Crear una función que realice esta acción a la que llamaremos `Complementaria()`.
Complementaria <- function(secuencia_dna = seq_dna){
  complementaria_adn = chartr("ATGC","TACG", secuencia_dna)
  complementaria_adn = paste(complementaria_adn, collapse = "")
  return(complementaria_adn)
}

# Usando la función
seq_dna
Complementaria(seq_dna)


# ** Transcripción --------------------------------------------------------
# Necesitamos *transcribir* la información desde la cadena de ADN a una cadena de ARN.
# Las correspondencias en este caso cambian y tenemos que la *Timina* es reemplazada por el *Uracilo*
Transcripcion <- function(secuencia_dna = seq_dna){
  seq_arn = chartr("T","U", secuencia_dna)
  seq_arn = paste(seq_arn, collapse = "")
  return(seq_arn)
}

# Usando la función
print(seq_dna)
Transcripcion(seq_dna)

# Importando la función
source("INPUT/FUNCTIONS/Transcripcion.R")
print(seq_dna)
Transcripcion(seq_dna)

# Hasta aquí Lunes 06/10/25 --> 101 y 102

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
View(Acc_Car)

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
library(rjson)

Acc_Car_Json <- fromJSON(file = "INPUT/DATA/accidentalidad-por-carreteras.json")

Acc_Car_Json
head(Acc_Car_Json)

# ** Uso de tidyjson ------------------------------------------------------
# devtools::install_github("colearendt/tidyjson")
#https://github.com/colearendt/tidyjson
library(tidyjson)

data("worldbank")

head(worldbank)
View(worldbank)

# Usamos `spread_all()` para formatear los datos
spread_all(worldbank)

worldbank %>% 
  spread_all() %>% 
  View()

# Aproximación Tidy para los accidentes en carretera
head(Acc_Car_Json)
spread_all(Acc_Car_Json)

Acc_Car_Json %>%
  spread_all() %>% 
  View()

# Guardamos el objeto
Acc_Car_TJson <- spread_all(Acc_Car_Json)

# comparando
Acc_Car_TJson
lobstr::obj_size(Acc_Car_TJson)

Acc_Car
lobstr::obj_size(Acc_Car)


# Revisando que no existan arrays --> sino: https://github.com/colearendt/tidyjson#examples
spread_all(Acc_Car_Json) %>% View()

Acc_Car_Json %>% 
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
# La función toJSON vive tanto en el paquete jsonlite como rjson

# rjson
x <- list( alpha = 1:5, beta = "Bravo", 
           gamma = list(a=1:3, b=NULL), 
           delta = c(TRUE, FALSE) )

x

JSON_x <- rjson::toJSON(x)
fromJSON(JSON_x)

write(x = JSON_x, file = "OUTPUT/DATA/JSON_x.json")


# Usando el conjunto de datos starwars
jsonstarwars <- rjson::toJSON(starwars)
cat(jsonstarwars)
fromJSON(jsonstarwars)

write(x = jsonstarwars, file = "OUTPUT/DATA/StarWars.json")


# * Exportar a xml --------------------------------------------------------
# file_url <- "https://www.w3schools.com/xml/simple.xml"  # ya estaba ejecutado
# Data <- read_xml(file_url)                              # ya estaba ejecutado
Data
write_xml(x = Data, file = "OUTPUT/DATA/Data.xml")


# INTRO DPLYR -------------------------------------------------------------
# paquete dplyr
library("dplyr")

#set de datos
data("starwars")
?starwars

# * Verbos de tablas únicas -----------------------------------------------
# operan sobre una única tabla de datos


# *** Filter --------------------------------------------------------------
# Filter modificará la primera dimensión de nuestros dataframes
# modifica las filas

# Filtrado de filas por columnas numéricas
# Aquellos personajes que pesan más de 100 KG
data(starwars)
starwars

dplyr::filter(.data = starwars, mass > 100)

# Aquellos personajes que pesan menos de 50 KG
filter(starwars, mass < 50)

# Aquellos que pesan entre 50 y 100 kg
dplyr::filter(.data = starwars, mass >= 50 & mass <= 100)

filter(starwars, between(mass, 50, 100))

# Filtra por variables categóricas
# Aquellos personajes con un color de piel "claro"
# todos los tipos de color de piel
starwars

levels(factor(starwars$skin_color))

table(starwars$skin_color)

filter(starwars, skin_color == "blue, grey")

# *** Slice ---------------------------------------------------------------
# Selección de filas según la ubicación

# seleccionar las primera fila
slice_head(.data = starwars)

# seleccionar la última fila
slice_tail(.data = starwars)

# seleccionar las primeras cinco (n) filas
slice_head(.data = starwars, n = 5)

# seleccionar las últimas cinco (n) filas
slice_tail(.data = starwars, n = 5)

# seleccionar las filas entre la 8 y la 12
slice(.data = starwars, 8:12)

# seleccionar (al azar) una determinada cantidad (n) de filas
slice_sample(.data = starwars, n = 4)
slice_sample(.data = starwars, n = 4)

# seleccionar (al azar) una determinada proporción (prop) de filas
slice_sample(.data = starwars, prop = 0.7)

# Selección de filas según otra variable

# Seleccionar al personaje más alto
slice_max(.data = starwars, order_by = height)

# Seleccionar a los 3(n) personajes más altos
slice_max(.data = starwars, order_by = height, n = 3)

# Seleccionar al personaje más pesado
slice_max(.data = starwars, order_by = mass)

# Seleccionar a los 3(n) personajes más pesados
slice_max(.data = starwars, order_by = mass, n = 3)


# *** Arrange -------------------------------------------------------------
# Ordena las filas de manera ascendente (por defecto)

# ordena los personajes de Starwars desde el más bajo al más alto
arrange(.data = starwars, height)

# ordena los personajes de Starwars desde el más alto al más bajo
arrange(.data = starwars, desc(height))

# ordena los personajes de Starwars por más de una variable
arrange(.data = starwars, desc(height), mass)


# *** Summarise -----------------------------------------------------------
# Reduce toda la dimensión 1, a una sola fila, dependiendo del valor que se haya pedido para una columna en particular (máximo, mínimo, promedio, etc.). Crea un nuevo tibble

# Altura promedio (y desviación estándar) de todos los personajes
summarise(.data = starwars, Alt_prom = mean(height, na.rm = TRUE), Alt_desv = sd(height, na.rm = TRUE))


# ** Columnas (dimensión 2) -----------------------------------------------

# *** Select --------------------------------------------------------------
# Permite seleccionar algunas columnas

# selecciona nombres específicos de columnas
select(.data = starwars, hair_color, skin_color, eye_color)

# selecciona un rango de columnas
select(.data = starwars, hair_color:birth_year)

# selecciona aquellas columnas que NO están en un rango
select(.data = starwars, !(hair_color:birth_year))

# selecciona aquellas columnas que coinciden con un criterio (terminan con el caracter "color")
select(.data = starwars, ends_with("color"))


# *** Rename --------------------------------------------------------------
# Permite renombrar columnas

# renombra una o más columnas seleccionadas a mano
rename(.data = starwars, altura = height)

rename(.data = starwars, altura = height, peso = mass, color_pelo = hair_color)

# renombra una o más columnas que cumplen un criterio
rename_with(.data = starwars, toupper, ends_with("color"))


# *** Mutate --------------------------------------------------------------
# Crea nuevas columnas a partir de columnas previas

# columna nueva con la interacción de factores
mutate(.data = df2, alfanum = interaction(Numeros, Letras, sep = ":"))
mutate(.data = df2, Saludo = "Hola")

# columna nueva con la altura en metros (no en centímetros)
mutate(.data = starwars, Altura_m = height / 100)

# columna nueva y selección de nueva columna de altura en metros (no en centímetros)
transmute(.data = starwars, Altura_m = height / 100)

# *** Relocate ------------------------------------------------------------
# Similar a select y sirve para mover columnas

# Mover el rango de columnas desde sex hasta homeworld, delante de height
starwars
relocate(.data = starwars, sex:homeworld, .before = height)

# *** Case_When -----------------------------------------------------------
# Permite recodificar valores de acuerdo a algún criterio de agrupación

mutate(.data = starwars, Altura = case_when(height > 200 ~ 'Altísimo'))

mutate(.data = starwars, Altura = case_when(height > 200 ~ 'Altísimo', .default = 'Normales'))

starwars %>%
  select(name:mass, gender, species) %>%
  mutate(type = case_when(
    height > 200 | mass > 200 ~ "large",
    species == "Droid" ~ "robot",
    .default = "other"
  ))

# ** Operaciones combinadas -----------------------------------------------
# Usaremos dos funciones %>% y group_by

# *** Group_by ------------------------------------------------------------
# Duplica el tibble pero agrega un atributo nuevo

# Promedio y desviación standar del set completo
summarise(.data = starwars, Alt_prom = mean(height, na.rm = TRUE), Alt_desv = sd(height, na.rm = TRUE))

# # agrupando por niveles de una variable categórica
# Promedio y desviación estándar para cada género
a1 <- group_by(.data = starwars, gender)

a1

attributes(a1)

summarise(.data = a1, Alt_prom = mean(height, na.rm = TRUE), Alt_desv = sd(height, na.rm = TRUE))

# agrupando por niveles de más de una variable categórica
# Promedio y desviación estándar para cada género y especie
a2 <- group_by(.data = starwars, gender, species)

a2

attributes(a2)

summarise(.data = a2, Alt_prom = mean(height, na.rm = TRUE), Alt_desv = sd(height, na.rm = TRUE))

mean(a2$height, na.rm=TRUE)

# *** Pipes ---------------------------------------------------------------
# Máximo poder a R
# Concatenamos funciones de una manera sencilla de leer (de arriba a abajo)

# Pipe con Select
starwars %>% 
  select(.data = ., name, species)



# Argumento data puede estar ausente, pero en un pipe se asume "(.)"
starwars %>% 
  select(name, species) %>% 
  filter(mass > 77)


# Pipe con filter
starwars %>% 
  dplyr::filter(.data = ., skin_color %in% c("light", "gold"), eye_color %in% c("hazel", "yellow"))

# Pipeline #1
starwars %>% 
  select(name, species) %>% 
  str()

# Pipeline #2
starwars %>% 
  select(name, species) %>% 
  View()

# Pipeline #3 
# Uso de Pipeline y groupby para calcular promedios de variables por grupos
starwars %>%
  group_by(species, sex) %>%
  select(height, mass) %>%
  summarise(
    height = mean(height, na.rm = TRUE),
    mass = mean(mass, na.rm = TRUE)
  )

# Pipeline #4
# Body Mass Index (BMI) 
starwars %>%
  mutate(
    height_m = height / 100,
    BMI = mass / (height_m^2)
  ) %>%
  select(BMI, everything()) %>% 
  slice_max(., order_by = BMI, n = 3)

# More on BMI
# https://www.calculator.net/bmi-calculator.html?ctype=metric&cage=43&csex=m&cheightfeet=5&cheightinch=10&cpound=160&cheightmeter=173&ckg=82&printit=0&x=76&y=13

# *** Operaciones por columnas -------------------------------------------
# Repetir la misma operación por columnas
library(tidyverse)
starwars

# Promedio de altura, peso y año nacimiento por especies

# Aproximación manual (no muy clever si son muchas)
starwars %>%
  group_by(species) %>%
  #filter(n() > 1) %>% # para evitar NA en standar deviation
  summarise(
    Av_height = mean(height, na.rm = TRUE),
    Av_mass = mean(mass, na.rm = TRUE),
    Av_birth_year = mean(birth_year, na.rm = TRUE)
  )

# Aproximación usando across. Se pueden usar las funciones de select

# Selección variables a mano
starwars %>%
  group_by(species) %>%
  #filter(n() > 1) %>%
  summarise(across(c(height, mass, birth_year), ~ mean(.x, na.rm = TRUE)))

# Selección variables por tipo
starwars %>%
  group_by(species) %>%
  #filter(n() > 1) %>%
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))

# ¿Cuántos sexos, géneros y orígenes hay para cada especie?
?starwars

starwars %>% 
  group_by(species) %>% 
  filter(n() > 5) %>% 
  summarise(across(c(sex, gender, homeworld), ~ length(unique(.x))))

# Altura, peso y año de nacimiento promedio según lugar de origen desde el promedio más viejo al más joven
starwars %>% 
  group_by(homeworld) %>% 
  #filter(n() > 1) %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>% 
  arrange(desc(birth_year)) 

# Para quitar la fila con el NA
library(tidyr)
starwars %>% 
  group_by(homeworld) %>% 
  filter(n() > 1) %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>% 
  arrange(desc(birth_year)) %>% 
  drop_na()

# Guardamos esta tabla en un objeto para el siguiente punto
Wide_Starwars <- 
  starwars %>% 
  group_by(homeworld) %>% 
  filter(n() > 1) %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>% 
  arrange(desc(birth_year)) %>% 
  drop_na()

Wide_Starwars


# ** Pivotar (Pivoting) -------------------------------------------------------------
# Transponer la estructura de nuestra tabla ordenada

# Pivot_longer (desde ancho a largo)
Wide_Starwars

pivot_longer(data = Wide_Starwars, names_to = "Variable", values_to = "Valores", cols = c(height:birth_year))

# Pipeline #1
Wide_Starwars %>% 
  pivot_longer(data = ., names_to = "Variable", values_to = "Valores", cols = c(height:birth_year))

# Pipeline #2
starwars %>% 
  group_by(homeworld) %>% 
  filter(n() > 1) %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>% 
  arrange(desc(birth_year)) %>% 
  drop_na() %>% 
  pivot_longer(data = ., names_to = "Variable", values_to = "Valores", cols = c(height:birth_year))

# Guardamos un objeto para siguiente sección
Long_Starwars <-
  starwars %>% 
  group_by(homeworld) %>% 
  filter(n() > 1) %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>% 
  arrange(desc(birth_year)) %>% 
  drop_na() %>% 
  pivot_longer(data = ., names_to = "Variable", values_to = "Valores", cols = c(height:birth_year))

Long_Starwars

# Pivot_wider (desde largo a ancho)
Long_Starwars

pivot_wider(data = Long_Starwars, names_from = "Variable", values_from = "Valores")

# Pipeline #1
Long_Starwars %>% 
  pivot_wider(data = ., names_from = "Variable", values_from = "Valores")

# También funciona sin comillas en los atributos aunque no es recomendable.
# Long_Starwars %>%
#   pivot_wider(data = ., names_from = Variable, values_from = Valores)

# ** Verbos de dos tablas -------------------------------------------------
#library(readr)


# *** Carga de datos ------------------------------------------------------
# Loading the "Galapagos_summary.csv" file
library(readr)
Mean_Galapagos <- read_csv(file = "INPUT/DATA/Galapagos_summary.csv", 
                           col_types = cols(
                             Island = readr::col_factor(levels = NULL),
                             Station = readr::col_factor(levels = NULL),
                             distance = readr::col_factor(levels = NULL),
                             Av_Temp = col_double(),
                             Av_Salinity = col_double(),
                             Av_Chla = col_double()
                           ))

Mean_Galapagos
levels(Mean_Galapagos$Island)
levels(Mean_Galapagos$Station)
levels(Mean_Galapagos$distance)

# Loading the "Species_Richness_PerSite.csv" file
Species <- read_csv("INPUT/DATA/Species_Richness_PerSite.csv", col_types = cols(
  ID = col_integer(),
  Island = readr::col_factor(levels = c("Pinzón", "Santa Cruz", "Santa Fé", "Seymour")),
  Latitude.South = col_double(),
  Longitude.West = col_double(),
  Station = readr::col_factor(levels = c("North", "West", "South", "East")),
  distance = readr::col_factor(levels = NULL),
  NewFactor = readr::col_factor(levels = NULL),
  SpeciesRichness = readr::col_integer()
))

Species
View(Species)

# *** Inspección de los datos ---------------------------------------------
# Vista general
summary(Mean_Galapagos)
summary(Species)

# Presunciones de la union
levels(Mean_Galapagos$Island)
levels(Species$Island)

# Si los niveles no son iguales, forzamos los niveles de una tabla a ser igual que los de otra
# Species <-
#   Species %>% 
#   mutate(Island = factor(Island, levels = c("Pinzón", "Santa Cruz","Santa Fé", "Seymour" )))

levels(Mean_Galapagos$Station)
levels(Species$Station)

levels(Mean_Galapagos$distance)
levels(Species$distance)


# *** Left_Join -----------------------------------------------------------

# Sin indicar las columnas que hacen de "pivot" --> natural Join
left_join(x = Mean_Galapagos, y = Species)

# Igual, pero correctamente escrito
left_join(x = Mean_Galapagos, y = Species, by = c("Island", "Station", "distance")) 

# Indicación parcial, ver que pasa con los no señalados
left_join(x = Mean_Galapagos, y = Species, by = c("Island"))


# *** full_join -----------------------------------------------------------
# Accidentalidad por Carreteras
# https://analisis.datosabiertos.jcyl.es/explore/dataset/accidentalidad-por-carreteras/export/?sort=ano
# Detalle en: https://datosabiertos.jcyl.es/web/jcyl/binarios/582/267/%C3%8Dndices_de_accidentalidad.pdf?blobheader=application%2Fpdf%3Bcharset%3DUTF-8&blobnocache=true
# Índice de Peligrosidad “IP” / Índice de Mortalidad “IM” / Índice de Accidentalidad Total “IAT” / Índice de Lesividad “IL” / Índice de Gravedad “IG”
# library(readr)
Acc_Car <- read_delim("INPUT/DATA/accidentalidad-por-carreteras.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE)

Acc_Car
str(Acc_Car)
levels(factor(Acc_Car$NOMBRE))

# Seleccionamos lo querealmente nos sirve
Acc_Car %>% 
  select(`AÑO`, T.RED, NOMBRE, LONG.:IG) 


# Anchura de carretras
# https://datosabiertos.jcyl.es/web/jcyl/set/es/urbanismo-infraestructuras/anchura-carreteras/1284967627462
# library(readr)
Ancho_Car <- read_delim("INPUT/DATA/anchura-de-carreteras.csv", 
                        delim = ";", escape_double = FALSE, trim_ws = TRUE)

Ancho_Car
str(Ancho_Car)
levels(factor(Ancho_Car$CARRETERA))

# Seleccionamos lo que realmente nos sirve
Ancho_Car %>% 
  select(PR:CARRETERA, LONGITUD:`ESTAC.\nAFORO`)

# Ejecutamos el full_join
Acc_Car %>% 
  select(`AÑO`, T.RED, NOMBRE, LONG.:IG) %>% 
  full_join(x = ., 
            y = Ancho_Car %>% 
              select(PR:CARRETERA, LONGITUD:`ESTAC.\nAFORO`),
            by = c("NOMBRE" = "CARRETERA"))


# Guardamos un objeto con el join creado
Accidentes_total <-  
  Acc_Car %>% 
  select(`AÑO`, T.RED, NOMBRE, LONG.:IG) %>% 
  full_join(x = ., 
            y = Ancho_Car %>% 
              select(PR:CARRETERA, LONGITUD:`ESTAC.\nAFORO`),
            by = c("NOMBRE" = "CARRETERA"))

Accidentes_total 

summary(Accidentes_total)

# Relación entre el Índice de Mortalidad y el ancho de la carretea?
library(ggplot2)

# muchos ceros en IM, mejor quitarlos
ggplot(data = Accidentes_total, mapping = aes(x = `ANCHURA\nASF\n(m.)`, y = IM)) +
  geom_point(na.rm = TRUE)

# Análisis sin ceros
#x11()
Accidentes_total %>% 
  filter(IM > 0) %>% 
  ggplot(data = ., mapping = aes(x = `ANCHURA\nASF\n(m.)`, y = IM)) +
  geom_point(na.rm = TRUE) +
  geom_smooth(na.rm = TRUE) +
  labs(x = "Anchura Carretera (m)", y = "Índice de Mortalidad (IM)", 
       subtitle = "Relación entre ancho de carretera y el I.M.") +
  theme_classic()

# ** Guardando / Exportando datos -----------------------------------------
# Body Mass Index (BMI) 
starwars %>%
  mutate(
    height_m = height / 100,
    BMI = mass / (height_m^2)
  ) %>%
  select(BMI, everything()) %>% 
  slice_max(., order_by = BMI, n = 3)

# Objeto  que contiene este cálculo

Mayores_BMI <- 
  starwars %>%
  mutate(
    height_m = height / 100,
    BMI = mass / (height_m^2)
  ) %>%
  select(BMI, everything()) %>% 
  slice_max(., order_by = BMI, n = 3)

Mayores_BMI

# Guardamos el tibble
write_csv(x = Mayores_BMI, file = "OUTPUT/DATA/Mayores_BMI.csv", col_names = TRUE)

# Introducción  ggplot2 ---------------------------------------------------
#library(ggplot2)
library(tidyverse)

?ggplot2


# * Gráfico básico ---------------------------------------------------------

# Cargamos los datos
data("mpg")

# reseña del set de datos
?mpg

str(mpg)

# ayuda de la función principal de ggplot2
?qplot
?ggplot

# Definición de las tres mínimas variables en un gráfico
ggplot(data = mpg, aes(x = displ, y = hwy))


# ** Gráfico de dispersión ------------------------------------------------
# Incluyendo la geometría
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point()

?geom_point

# Controlando el color -- Fijo
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(colour = "deeppink")

# Controlando el color -- Dependiente de otra variable
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = factor(cyl)))

# Qué tipo de colores se obtienen con una variable continua? 
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = cyl))

# HASTA AQUI Lunes 20 Noviembre #
# Agregamos una línea de ajuste
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# Podemos comparar diferentes modelos de ajustes
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(method = "loess", colour = "blue", se = TRUE) +
  geom_smooth(method = "lm", formula = y~poly(x,1), colour = "red", se = TRUE)

# Podemos ajustar modelos dependientes de cada nivel de la variable categórica
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = factor(cyl))) +
  geom_smooth(method = "lm", aes(colour = factor(cyl)))


# ** Gráfico de barras ----------------------------------------------------
data("diamonds")
str(diamonds)
?diamonds

# Gráfico sencillo con "conteo" de ítems (solo "x" variable)
ggplot(data = diamonds, aes(x = cut)) +
  geom_bar()

# Mismo gráfico, pero llevado a proporción (todas las áreas suman 1)
ggplot(data = diamonds, aes(x = cut, y = ..prop.., group = 1)) +
  geom_bar()

# Modificando el colour --> no es lo que esperas!
ggplot(data = diamonds, aes(x = cut)) +
  geom_bar(aes(colour = clarity))

# Modificando el "relleno" de las cajas
ggplot(data = diamonds, aes(x = cut)) +
  geom_bar(aes(fill = clarity), colour = "black")

# Para hacer comparaciones "intra-clase" de la variable de relleno
ggplot(data = diamonds, aes(x = cut)) +
  geom_bar(aes(fill = clarity), position = "fill")

# Para hacer comparaciones entre niveles del eje X considerando la tercera variable
ggplot(data = diamonds, aes(x = cut)) +
  geom_bar(aes(fill = clarity), position = "dodge")

# Usando 2 variables (no de la manera correcta, aún)
ggplot(data = diamonds, aes(x = cut, y = carat)) +
  geom_bar(stat = "identity")


# ** Gráficos de Coordenadas polares (Coxcomb) ----------------------------

# Preparación del gráfico
ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

# Agregando las transformaciones
# coord_flip
ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL) +
  coord_flip()


# coord_polar
ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL) +
  coord_polar()

# * Facetas  ---------------------------------------------------------
# Permiten dividir el gráfico según niveles de una variable discreta

# Manipulando color y forma dentro de los puntos --> no muy útil
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = factor(cyl), shape = drv))

# como la variable `drv` tiene solo 3 niveles, podemos dividir el gráfico de acorde a ellas
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = factor(cyl))) +
  facet_wrap(facets = vars(drv), nrow = 1)

# Podemos tener 5 variables en un gráfico!
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = factor(cyl))) +
  #facet_wrap(class ~ drv)
  facet_grid(class ~ drv, scales = "free", margins = TRUE) # Muestra la grilla con toda la combinación

# * Etiquetas --------------------------------------------------------
# Permiten mejorar los "nombres" de ejes, títulos, subtítulos, etc.

# Controlando cada etiqueta por sí sola (ejes)
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlab("Displacement (Litres)") +
  ylab("Yield (miles / gallon)")

# Controlando cada etiqueta por sí sola (ejes + títulos)
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlab("Displacement (Litres)") +
  ylab("Yield (miles / gallon)") +
  ggtitle(label = "Highway yield ", subtitle = "cars")


# Controlando todas las etiquetas en una sola función
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  labs(
    x = "Displacement (Litres)",
    y = "Yield (miles / gallon)",
    title = "Highway yield ",
    subtitle = "cars"
  )

# Controlando todas las etiquetas en una sola función (incluye títulos de leyendas)
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class, shape = factor(cyl))) +
  labs(
    x = "Displacement (Litres)",
    y = "Yield (miles / gallon)",
    title = "Highway yield",
    subtitle = "cars",
    colour = "Vehicle \n type",
    shape = "Cylinders \n (Number)"
  )


# ** Etiquetas dentro del gráfico ----------------------------------------
# Gráfico base
ggplot(mpg, aes(displ, hwy)) +
  geom_point(size = 0.5)

# Agregamos la tercera variable como "texto" dentro del gráfico
ggplot(mpg, aes(displ, hwy)) +
  geom_point(size = 0.5) +
  geom_text(aes(label = manufacturer))

# Evitamos la sobreposición (suave)
ggplot(mpg, aes(displ, hwy)) +
  geom_point(size = 0.3) +
  geom_text(aes(label = manufacturer), check_overlap = TRUE)

# Evitamos la sobreposición (fuerte) --> requiere ggrepel
library(ggrepel)

x11(width = 16, height = 8)
ggplot(mpg, aes(displ, hwy)) +
  geom_point(size = 0.4, colour = "red") +
  geom_text_repel(aes(label = manufacturer))


# * Límites de los ejes ----------------------------------------------
# Permiten mejorar la visualización haciendo "zoom" o "recortando" el gráfico

# Ajustando los límites en una sola función ("recortando")
ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  lims(x = c(20, 30), y = c(2, 4))

# Cuidado con recortar, porque hay capas que dependen de la cantidad de puntos
ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth()

# Si cortamos y solo dejamos la zona central (con pendiente negativa) ahora es cercana a cero
ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth() +
  lims(x = c(19, 24))

# Para evitar este efecto del "recorte" lo que hacemos es un zoom dentro del gráfico
ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth()

ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth() +
  coord_cartesian(xlim = c(19, 24), expand = TRUE)


# * Temas ------------------------------------------------------------
# Cambian la apariencia general del gráfico (todo lo que no esté relacionado con los datos)
ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth()

ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth() +
  theme_classic()

ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth() +
  theme_void()

ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth() +
  theme_classic()

ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth() +
  theme_minimal()

ggplot(mpg, aes(hwy, displ)) +
  geom_point() +
  stat_smooth() +
  theme_void()

?theme
# * Guardando los gráficos. ------------------------------------------
# Hasta ahora no hemos creado ningún objeto y es lo que deberemos hacer
Final_plot <-
  ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class, shape = factor(cyl))) +
  labs(
    x = "Displacement (Litres)",
    y = "Yield (miles / gallon)",
    title = "Highway yield",
    subtitle = "cars",
    colour = "Vehicle \n type",
    shape = "Cylinders \n (Number)"
  )

# Al imprimir el objeto (ejecutar su nombre) se "dibuja" el gráfico 
Final_plot
print(Final_plot)
x11(Final_plot)
# Usamos la siguiente instrucción para guardar el gráfico
ggsave(
  filename = "Car_yield_highway.jpeg",
  plot = Final_plot ,
  #path = paste(getwd(), "/OUTPUT/Figures", sep = ""), # ruta absoluta
  path = "OUTPUT/Figures", # ruta relativa
  scale = 0.5,
  width = 40,
  height = 20,
  units = "cm",
  dpi = 320
)

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
#install.packages("https://cran.r-project.org/src/contrib/Archive/SPARQL/SPARQL_1.16.tar.gz", repo=NULL, type="source")

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
install.packages("WikidataQueryServiceR")

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

# Referencias -------------------------------------------------------------
# https://adv-r.hadley.nz/index.html
# https://rstudio-education.github.io/hopr/
# https://r4ds.had.co.nz/
# https://dplyr.tidyverse.org/
# https://ggplot2.tidyverse.org/index.html