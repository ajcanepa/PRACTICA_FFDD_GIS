# ---
# title:    |
#  | Fuentes de datos biomédicas
#  | y web semántica #8235
#  | Gº Ingeniería de la Salud
# 
# author:    |
#  | **Antonio Canepa, Ph.D.**
#  | *[email](mailto:ajcanepa@ubu.es)* /
# 
# date: "5º Semestre / Curso 2023-2024"
# output:
#   html_document:
#     df_print: paged
#     toc: yes
#     toc_float: yes
#   pdf_document:
#     toc: yes
# always_allow_html: true
# ---


# POO ---------------------------------------------------------------------
## S3 --------------------------------------------------------------------

# Definir un objeto S3 para un paciente
crear_paciente <- function(nombre, edad, presion_sistolica, presion_diastolica) {
  paciente <- list(
    nombre = nombre,
    edad = edad,
    presion_sistolica = presion_sistolica,
    presion_diastolica = presion_diastolica
  )
  class(paciente) <- "paciente"
  return(paciente)
}

# Método para mostrar la información del paciente
print.paciente <- function(paciente) {
  cat("Paciente:", paciente$nombre, "\n")
  cat("Edad:", paciente$edad, "\n")
  cat("Presión arterial:", paciente$presion_sistolica, "/", paciente$presion_diastolica, "mmHg\n")
}


# Crear y mostrar un paciente
paciente1 <- crear_paciente("Juan Pérez", 45, 120, 80)
print(paciente1)


## S4 --------------------------------------------------------------------

# Definir una clase S4 para un paciente
setClass(
  "Paciente",
  slots = list(
    nombre = "character",
    edad = "numeric",
    presion_sistolica = "numeric",
    presion_diastolica = "numeric"
  )
)


# Constructor de la clase Paciente
Paciente <- function(nombre, edad, presion_sistolica, presion_diastolica) {
  new("Paciente", nombre = nombre, edad = edad, presion_sistolica = presion_sistolica, presion_diastolica = presion_diastolica)
}

# Método para mostrar la información del paciente
setMethod("show", "Paciente", function(object) {
  cat("Paciente:", object@nombre, "\n")
  cat("Edad:", object@edad, "\n")
  cat("Presión arterial:", object@presion_sistolica, "/", object@presion_diastolica, "mmHg\n")
})


# Crear y mostrar un paciente
paciente2 <- Paciente("Ana Gómez", 30, 110, 70)
show(paciente2)


## R6 --------------------------------------------------------------------
library(R6)
# Definir una clase R6 para un dispositivo de monitoreo de presión arterial
MonitorPresion <- R6Class(
  "MonitorPresion",
  public = list(
    nombre = NULL,
    edad = NULL,
    presion_sistolica = NULL,
    presion_diastolica = NULL,
  initialize = function(nombre, edad) {
      self$nombre <- nombre
      self$edad <- edad
      self$presion_sistolica <- 0
      self$presion_diastolica <- 0
    },
  tomar_medicion = function(sistolica, diastolica) {
      self$presion_sistolica <- sistolica
      self$presion_diastolica <- diastolica
    },
  mostrar_info = function() {
      cat("Paciente:", self$nombre, "\n")
      cat("Edad:", self$edad, "\n")
      cat("Presión arterial:", self$presion_sistolica, "/", self$presion_diastolica, "mmHg\n")
    }
  )
)

# Crear un monitor y tomar una medición
monitor <- MonitorPresion$new("Carlos Díaz", 55)
monitor$tomar_medicion(130, 85)
monitor$mostrar_info()



## S7 --------------------------------------------------------------------
# Instalar y cargar el paquete S7 si aún no lo tienes instalado
# install.packages("S7")
library(S7)

# Definir la clase S7 para un paciente
Paciente <- new_class(
  "Paciente",
  properties = list(
    nombre = class_character,
    edad = class_numeric,
    presion_sistolica = class_numeric,
    presion_diastolica = class_numeric
  ),
  constructor = function(nombre, edad, presion_sistolica, presion_diastolica) {
    # Validación y creación del objeto
    new_object(
      Paciente,
      nombre = nombre,
      edad = edad,
      presion_sistolica = presion_sistolica,
      presion_diastolica = presion_diastolica
    )
  }
)

# Definir un método para mostrar la información del paciente
Paciente_show <- function(object) {
  cat("Paciente:", object$nombre, "\n")
  cat("Edad:", object$edad, "\n")
  cat("Presión arterial:", object$presion_sistolica, "/", object$presion_diastolica, "mmHg\n")
}


# Registrar el método 'show' para la clase 'Paciente'
methods::setMethod("show", "Paciente", Paciente_show)

# Crear y mostrar un paciente
paciente3 <- Paciente("Laura Méndez", 40, 115, 75)
paciente3

paciente3@presion_sistolica



# Objetos en R ------------------------------------------------------------


## Vectores --------------------------------------------------------------
x <- c(1,2,3)
x

y <- x
y

lobstr::obj_addr(x)
lobstr::obj_addr(y)

# _abc <- 1
# 
# # Error: unexpected input in "_"

`_abc` <- 1

`_abc`


# Combinar (c) números te permitirá crear vectores numéricos (integer)
x <- c(1,2,3,4,5,6,7)
print(x)

x

is.vector(x)

typeof(x)

x

is.vector(x)

typeof(x)

int <- c(-1L, 2L, 4L)
int

typeof(int)

int <- c(-1L, 2L, 4L)
int

typeof(int)

x

length(x)

x

class(x)

# i) Tercer elemento 
x[3]

# ii) Desde el primero al cuarto elemento
x[1:4]

# Al combinar (c) caracters, obtendrás un "character vector" ó "string"
y <- c("1","2","3","4","5","6","7")
print(y)

# Obteniendo su longitud
length(y)

# Obteniendo su clase
class(y)



## Matrices / Arrays -----------------------------------------------------


# Para crear una matriz podemos usar la siguiente función.
Matrix <- matrix(c(1,2,3,4,5,6,7,10,20,30,40,50,60,70), nrow = 7, ncol = 2, byrow = FALSE)

# Imprime en la consola el resultado
print(Matrix)

# nos permite conocer las dimensiones (filas, columnas) del objeto
dim(Matrix)

# Nos permite conocer la clase de nuestro objeto
class(Matrix)

Matrix

# Primera fila de todas las columnas
Matrix[1, ]

Matrix

# Primera columna
Matrix[, 1]

Matrix

# Primera y segunda fila de todas las columnas
Matrix[1:2, ]



## Data Frames -----------------------------------------------------------

# Para crear un dataframe podemos usar la siguiente función.
DF <- data.frame(Year = c(20,40,60,50), Name = c("Pedro", "María", "Tomás", "Nieves"))
print(DF)

DF

# Obtenemos las dimensiones y la clase de nuestro objeto.
dim(DF)
class(DF)

# Accediendo a la primera columna por posición
DF[,1]

# Accediendo a la primera columna por nombre
DF$Year

DF

# Seleccionamos de la columna "Year" aquellas filas en las que la columna "Name" corresponden a "Pedro".
DF$Year[DF$Name == "Pedro"]



## Listas ----------------------------------------------------------------

# Creamos una lista con la función list, usando todos los objetos anteriormente creados
List <- list(Var_x = x, Var_y = y, Matrix = Matrix, DF = DF)

print(List)

str(List)

# Seleccionamos el tercer elemento de `x` dentro de la `List`
str(List$DF)
List$Matrix[c(3, 5, 6, 7), 2]

# Indexamos a María
List$DF$Name[2]

# Seleccionamos los años y nombres de "Tomás" y "Nieves" desde nuestro dataframe `DF` dentro de la `List`
List$DF[3:4, 1:2]



# Operaciones en R --------------------------------------------------------

## Algebraicas -----------------------------------------------------------

# Creamos dos vectores numéricos x e y
x <- c(1:10)
y <- sin(x)

x
y



mean(x)
mean(y)

# Rango valores de x
min(x)
max(x)

# Rango valores de y
min(y)
max(y)

x 

y

x + y

# Reciclado
x <- c(1:9)
x
y

x + y



# Creamos el vector `z` que será un **character vector**
z <- c(rep("Pablo", 6), "Juan", "Diego", rep("Joseph", 4))
z

# Creamos el vector `z` que será un **character vector**
z <- c(rep("Pablo", 6), "Juan", "Diego", rep("Joseph", 4))
z

# Para contar el número de elementos iguales dentro del vector
table(z)


## Condicionales ---------------------------------------------------------

# if (condición) {
#   # Código a ejecutar si la condición es verdadera
# }

# if (condición) {
#   # Código a ejecutar si la condición es verdadera
# } else {
#   # Código a ejecutar si la condición es falsa
# }
# 

presion_arterial <- 145

if (presion_arterial > 140) {
  categoria <- "Alta"
} else {
  categoria <- "Normal"
}

print(categoria)  # Resultado: "Alta"


# ifelse(condición, valor_si_verdadero, valor_si_falso)

colesterol <- c(180, 230, 160, 250)
clasificacion <- ifelse(colesterol > 200, "Alto", "Normal")

print(clasificacion)  # Resultado: "Normal" "Alto" "Normal" "Alto"


## Iteraciones -----------------------------------------------------------


### tapply ---------------------------------------------------------------

# tapply(vector, factor, función)

presion_sistolica <- c(120, 130, 110, 140, 135, 150)
edad_grupo <- c("Joven", "Adulto", "Joven", "Adulto", "Adulto", "Adulto")

media_presion <- tapply(presion_sistolica, edad_grupo, mean)

print(media_presion)


### while ----------------------------------------------------------------

# while (condición) {
#   # Código a ejecutar mientras la condición sea verdadera
# }

presion <- 210
objetivo <- 120
dias <- 0

while (presion > objetivo) {
  presion <- presion - 5
  dias <- dias + 1
}

print(dias)  # Resultado: 12 (Número de días necesarios para alcanzar el objetivo)


### for ------------------------------------------------------------------
# for (variable in secuencia) {
#   # Código a ejecutar en cada iteración
# }

alturas <- c(1.70, 1.75, 1.60)
pesos <- c(65, 75, 50)
imc <- numeric(length(alturas))

for (i in 1:length(alturas)) {
  imc[i] <- pesos[i] / alturas[i]^2
}

print(imc)  # Resultado: 22.49, 24.49, 19.53

## Funciones -------------------------------------------------------------

sumar <- function(x,y){
  x + y
}

sumar

sumar(7,15)

sumar(c(2, 3, 4), 4)



calcular <- function(x, y, type) {
  if (type == "sumar") {
    x + y
  } else if (type == "restar") {
    x - y
  } else if (type == "multiplicar") {
    x * y
  } else if (type == "dividir") {
    x / y
  } else {
    stop("Tipo de operación desconocida")
  }
}

calcular(x = 8, y = 4, type = "sumar")

calcular(x = 8, y = 4, type = "dividir")

calcular(x = 8, y = 4, type = "ecualizar")


calcular <- function(x, y, type = "sumar") {
  if (type == "sumar") {
    x + y
  } else if (type == "restar") {
    x - y
  } else if (type == "multiplicar") {
    x * y
  } else if (type == "dividir") {
    x / y
  } else {
    stop("Tipo de operación desconocida")
  }
}

calcular(x = 8, y = 4)

calcular(x = 8, y = 4, type = "dormir")


## Cargar una función ---------------------------------------------------
# https://investigacion.ubu.es/investigadores/35040/detalle
source("TEMA1_POO/calcular.R")
source("TEMA1_POO/Referencia_APA.R")
Referencia_APA("https://doi.org/10.3390/INFO15040223", BIBTEX = TRUE)


# Importacion de Datos --------------------------------------------------


## Desde paquetes --------------------------------------------------------

# Cargamos el paquete que contiene los datos (ggplot2)
library(ggplot2)

# La función data permite la carga de los datos
data(mpg)
mpg


## Desde ficheros propios ------------------------------------------------


library(readr)
Agua_consumo_humano <- read_delim(file = "INPUT/DATA/calidad-de-las-aguas-de-consumo-humano.csv",
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

Agua_consumo_humano

library(readr)


## Desde URL -------------------------------------------------------------
Agua_consumo_humano <- read_delim(file = "https://datosabiertos.jcyl.es/web/jcyl/risp/es/salud/calidad-aguas-consumo/1284839789043.csv",
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

Agua_consumo_humano
