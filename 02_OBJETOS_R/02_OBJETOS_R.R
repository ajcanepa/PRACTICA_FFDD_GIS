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

df1
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
# df2 es un tibble
str(df2$Numeros)

str(df1$Nu)
str(df2$Nu)



# Listas ------------------------------------------------------------------
# Análogos heterogéneos de los vectores
# función `list()`

l1 <- list(
  Enteros = 1:3, 
  Letra = "a", 
  Logico = c(TRUE, FALSE, TRUE), 
  Numeros = c(2.3, 5.9)
)

l1

typeof(l1)
str(l1)

# Lazy-evaluation en listas
lobstr::obj_size(mtcars)

l2 <- list(mtcars, mtcars, mtcars, mtcars)
lobstr::obj_size(l2)


# ** Combinación de listas ------------------------------------------------
# Listas --> vectores recursivos
l4 <- list(list(1,2), c(3,4))
l4

l5 <- c(list(1,2), c(3,4))
l5


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
l1[[3]][3]
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
