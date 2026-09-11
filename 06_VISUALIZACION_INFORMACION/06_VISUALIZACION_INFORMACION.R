# Introducción  ggplot2 ---------------------------------------------------
#library(ggplot2)
library(tidyverse)

#?ggplot2

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
  geom_smooth(
    method = "lm",
    formula = y ~ poly(x, 1),
    colour = "red",
    se = TRUE
  )

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
  plot = Final_plot,
  #path = paste(getwd(), "/OUTPUT/Figures", sep = ""), # ruta absoluta
  path = "OUTPUT/Figures", # ruta relativa
  scale = 0.5,
  width = 40,
  height = 20,
  units = "cm",
  dpi = 320
)
