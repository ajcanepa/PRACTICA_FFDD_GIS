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