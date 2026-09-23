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
# date: |
# | "`r paste0("5º Semestre / Curso ", format(Sys.Date(), "%Y"), "-", as.integer(format(Sys.Date(), "%Y")) + 1)`"
# output:
#   html_document:
#     df_print: paged
#     toc: yes
#     toc_float: yes
#   pdf_document:
#     toc: yes
# always_allow_html: true
# ---

# Objetos en R ------------------------------------------------------------

## Vectores --------------------------------------------------------------
x <- c(1,2,3)
x

y <- x
y

lobstr::obj_addr(x)
lobstr::obj_addr(y)

# Importancia de los nombres
# _abc <- 1
# 
# # Error: unexpected input in "_"

`_abc` <- 1

`_abc`

### Copy on modify ---------------------------------------------------------
a <- c(1,2,3)
b <- a

lobstr::obj_addr(a)
lobstr::obj_addr(b)

b[1] <- 99

lobstr::obj_addr(a)
lobstr::obj_addr(b)

a
b


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

### Coerción ----------------------------------------------------------------
# 1. Coerción implícita: R convierte "hacia arriba" en la jerarquía
# logical → integer → double → character

x <- c(1, "a", TRUE)
x
typeof(x)        # "character" -> todo se convirtió en texto: "1" "a" "TRUE"

y <- c(1, TRUE, FALSE)
y
typeof(y)        # "double" -> TRUE pasa a 1 y FALSE a 0

z <- c(1L, 2.5)
typeof(z)        # "double" -> el entero se "sube" a double

# 2. La coerción de lógicos a números es muy útil
respuestas <- c(TRUE, FALSE, TRUE, TRUE)
sum(respuestas)  # 3 -> cuántos TRUE hay
mean(respuestas) # 0.75 -> proporción de TRUE

# 3. Coerción explícita con las funciones as.*()
as.numeric(c("1", "2", "tres"))
# [1]  1  2 NA
# Warning: NAs introducidos por coerción

as.logical(c("TRUE", "T", "sí"))
# [1] TRUE TRUE   NA

# 4. ¡Cuidado! Las operaciones aritméticas NO convierten texto a número
"5" + 1
# Error: argumento no-numérico para operador binario

as.numeric("5") +1

# 5. La trampa clásica: las comparaciones SÍ aplican coerción
10 < "9"
# [1] TRUE  -> 10 se convierte en "10" y se compara como texto
#              ("1" va antes que "9" en orden alfabético)


### Vectorización -----------------------------------------------------------
# 1. Las operaciones se aplican a todos los elementos a la vez
x <- c(1, 4, 9, 16)

x * 2            # 2 8 18 32
sqrt(x)          # 1 2 3 4
x > 5            # FALSE FALSE TRUE TRUE
paste("Alumno", 1:3)   # "Alumno 1" "Alumno 2" "Alumno 3"

# 2. El mismo cálculo con un bucle (estilo de otros lenguajes)
resultado <- numeric(length(x))
for (i in seq_along(x)) {
  resultado[i] <- x[i] * 2
}

resultado        # 2 8 18 32 -> mismo resultado, mucho más código

## Velocidad ---
# 3. La diferencia de velocidad es enorme
n <- 1e6
numeros <- runif(n)

system.time({
  res_bucle <- numeric(n)
  for (i in 1:n) res_bucle[i] <- numeros[i]^2
})

system.time({
  res_vector <- numeros^2
})
# La versión vectorizada suele ser decenas de veces más rápida

## Condicionales ---
# 4. ¡Cuidado! if() NO está vectorizado: solo acepta una condición
edades <- c(15, 22, 17, 30)

if (edades >= 18) "Mayor" else "Menor"
# Error: the condition has length > 1

# La alternativa vectorizada es ifelse()
ifelse(edades >= 18, "Mayor", "Menor")
# "Menor" "Mayor" "Menor" "Mayor"

# 5. Nuestras propias funciones son vectorizadas si usan operaciones vectorizadas
precio_final <- function(precio, iva = 0.21) {
  precio * (1 + iva)
}

precio_final(c(10, 50, 100))   # 12.1 60.5 121 -> funciona con vectores

# Pero si usan if(), dejan de serlo
clasificar <- function(edad) {
  if (edad >= 18) "Mayor" else "Menor"
}

clasificar(20)                 # "Mayor"
clasificar(c(15, 20))          # Error: the condition has length > 1

# 6. Funciones vectorizadas muy útiles que evitan bucles
ventas <- c(100, 250, 80, 300)
cumsum(ventas)   # 100 350 430 730 -> suma acumulada
diff(ventas)     # 150 -170 220    -> diferencia entre consecutivos
rev(ventas)      # 300 80 250 100  -> invertir el orden


### Reciclado ---------------------------------------------------------------
# 1. El caso más habitual: un escalar se recicla sobre todo el vector
precios <- c(10, 20, 30, 40)
precios * 1.21   # El 1.21 se aplica a cada elemento (IVA)

# 2. Vectores de distinta longitud (múltiplos)
c(1, 2, 3, 4, 5, 6) + c(10, 20)
# [1] 11 22 13 24 15 26
# R hace internamente: c(1,2,3,4,5,6) + c(10,20,10,20,10,20)

# 3. Si la longitud no es múltiplo, funciona igualmente, pero avisa
c(1, 2, 3, 4, 5) + c(10, 20)
# [1] 11 22 13 24 15
# Warning: longitud de objeto mayor no es múltiplo de la longitud de uno menor

# 4. El reciclado también actúa en la indexación lógica
x <- 1:10
x[c(TRUE, FALSE)]  # Selecciona las posiciones impares
# [1] 1 3 5 7 9


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

# 4. ¡Cuidado! if() NO está vectorizado: solo acepta una condición
edades <- c(15, 22, 17, 30)

if (edades >= 18) "Mayor" else "Menor"
# Error: the condition has length > 1

# La alternativa vectorizada es ifelse()
ifelse(edades >= 18, "Mayor", "Menor")
# "Menor" "Mayor" "Menor" "Mayor"


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

### Lazy Evaluation ---------------------------------------------------------
# 1. Definimos una función que solo usa el primer argumento

saludar <- function(nombre, operacion_secreta) {
  print(paste("¡Hola,", nombre, "!"))
}

# 2. Probamos la función pasando un error en el segundo argumento
saludar("Carlos", 10 / 0)          # Funciona (R maneja Inf, pero no da error)
saludar("Ana", objeto_que_no_existe) # ¡También funciona!


# Modificamos la función para que use el segundo argumento
saludar_realmente <- function(nombre, operacion_secreta) {
  print(paste("¡Hola,", nombre, "!"))
  print(operacion_secreta) # Aquí obligamos a R a evaluar el argumento
}

# Esto ahora sí romperá el código:
saludar_realmente("Ana", objeto_que_no_existe)
# Error: objeto 'objeto_que_no_existe' no encontrado


## Valores asuentes NA --------------------------------------------------
# Si operas con NA, el resultado también es NA.
# El NA se "contagia" a casi cualquier operación.

## Propagación de NA -------------------------------------------------------
# 1. Casi cualquier operación con NA devuelve NA
NA + 1           # NA
NA * 0           # NA
NA > 5           # NA
NA == NA         # NA -> ¿dos valores desconocidos son iguales? No se sabe

# 2. Las funciones de resumen también se "contagian"
notas <- c(7, NA, 9, 5)

mean(notas)                 # NA
sum(notas)                  # NA
mean(notas, na.rm = TRUE)   # 7 -> ignoramos los NA de forma explícita
max(notas, na.rm = TRUE)    # 9

# 3. ¡Error típico! No se puede buscar un NA con ==
notas == NA                 # NA NA NA NA -> no sirve para nada
is.na(notas)                # FALSE TRUE FALSE FALSE -> esta es la forma correcta
sum(is.na(notas))           # 1 -> cuántos NA hay (¡coerción de lógicos!)

# 4. Excepciones: cuando el resultado no depende del valor desconocido
NA & FALSE       # FALSE -> sea lo que sea NA, el resultado es FALSE
NA | TRUE        # TRUE  -> sea lo que sea NA, el resultado es TRUE
NA ^ 0           # 1     -> cualquier número elevado a 0 es 1

# 5. Trampa al filtrar: los NA se cuelan en el resultado
notas[notas > 6]
# [1]  7 NA  9   -> aparece un NA que no esperábamos

notas[notas > 6 & !is.na(notas)]   # 7 9 -> filtrado correcto
notas[which(notas > 6)]            # 7 9 -> which() descarta los NA

# 6. Algunas funciones ocultan los NA por defecto
grupos <- c("A", "B", NA, "A")
table(grupos)                  # No muestra el NA
table(grupos, useNA = "ifany") # Ahora sí aparece

# 7. No confundir NA, NaN y NULL
0 / 0              # NaN -> "no es un número" (resultado indefinido)
is.na(NaN)         # TRUE  -> NaN también cuenta como NA
is.nan(NA)         # FALSE -> pero un NA no es un NaN
length(NA)         # 1 -> NA ocupa una posición (un dato que falta)
length(NULL)       # 0 -> NULL es la ausencia total de objeto
c(1, NULL, 3)      # 1 3 -> NULL desaparece al combinar


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
