# =============================================================================
#  Carácter vs. factor en R: efecto en tablas y gráficos
# =============================================================================
library(ggplot2)
library(patchwork)   # solo para poner los gráficos lado a lado

set.seed(123)

# -----------------------------------------------------------------------------
# 0. Datos: nivel de satisfacción (variable ORDINAL)
#    Ojo: nadie respondió "Muy alto", pero es una categoría posible.
# -----------------------------------------------------------------------------
respuestas <- sample(c("Bajo", "Medio", "Alto"), size = 60, replace = TRUE,
                     prob = c(0.2, 0.5, 0.3))

sat_chr <- respuestas                                   # vector carácter
sat_fct <- factor(respuestas,                           # factor con niveles
                  levels = c("Bajo", "Medio", "Alto", "Muy alto"))

# -----------------------------------------------------------------------------
# 1. ¿Qué es cada cosa por dentro?
# -----------------------------------------------------------------------------
str(sat_chr)          # chr  "Medio" "Alto" ...
str(sat_fct)          # Factor w/ 4 levels "Bajo","Medio",..: 2 3 ...
levels(sat_chr)       # NULL -> un carácter no tiene niveles
levels(sat_fct)       # "Bajo" "Medio" "Alto" "Muy alto"
head(as.integer(sat_fct))   # un factor son enteros + etiquetas

# -----------------------------------------------------------------------------
# 2. TABLA: orden y categorías vacías
# -----------------------------------------------------------------------------
tab_chr <- table(sat_chr)   # orden alfabético, "Muy alto" no existe
tab_fct <- table(sat_fct)   # orden de los niveles, "Muy alto" = 0

tab_chr
tab_fct

# Tabla comparativa lado a lado
n <- max(length(tab_chr), length(tab_fct))
rellenar <- function(x, n) c(x, rep(NA, n - length(x)))

comparacion <- data.frame(
  posicion   = seq_len(n),
  caracter   = rellenar(names(tab_chr), n),
  n_caracter = rellenar(as.vector(tab_chr), n),
  factor     = rellenar(names(tab_fct), n),
  n_factor   = rellenar(as.vector(tab_fct), n)
)
print(comparacion, row.names = FALSE)

# -----------------------------------------------------------------------------
# 3. GRÁFICO: ggplot convierte el carácter a factor... pero ALFABÉTICO
# -----------------------------------------------------------------------------
df <- data.frame(sat_chr, sat_fct)   # R >= 4.0: sat_chr se queda como carácter

p_chr <- ggplot(df, aes(x = sat_chr)) +
  geom_bar(fill = "grey60") +
  labs(title = "Vector carácter",
       subtitle = "Orden alfabético; 'Muy alto' no aparece",
       x = NULL, y = "Frecuencia") +
  theme_minimal()

p_fct <- ggplot(df, aes(x = sat_fct)) +
  geom_bar(fill = "steelblue") +
  scale_x_discrete(drop = FALSE) +     # mantiene niveles sin datos
  labs(title = "Factor con niveles",
       subtitle = "Orden lógico; el nivel vacío se muestra",
       x = NULL, y = "Frecuencia") +
  theme_minimal()

p_chr + p_fct

# -----------------------------------------------------------------------------
# 4. EXTRA: numérico vs. factor (el caso donde ggplot NO convierte nada)
#    Un número en 'colour' se trata como variable continua.
# -----------------------------------------------------------------------------
ventas <- data.frame(
  anio      = rep(2021:2023, each = 4),
  trimestre = rep(1:4, times = 3),
  ventas    = c(10, 12, 15, 14,  11, 14, 17, 16,  13, 16, 20, 19)
)

p_num <- ggplot(ventas, aes(trimestre, ventas, colour = anio)) +
  geom_line() + geom_point(size = 2) +
  labs(title = "anio numérico",
       subtitle = "Escala continua y una sola línea en zigzag") +
  theme_minimal()

p_fac <- ggplot(ventas, aes(trimestre, ventas, colour = factor(anio))) +
  geom_line() + geom_point(size = 2) +
  labs(title = "anio como factor",
       subtitle = "Colores discretos y una línea por año",
       colour = "anio") +
  theme_minimal()

p_num + p_fac

# -----------------------------------------------------------------------------
# 5. Trampa clásica: convertir un factor "numérico" a número
# -----------------------------------------------------------------------------
f <- factor(c("10", "20", "5"))
as.numeric(f)                  # 1 2 3  -> ¡códigos internos, no valores!
as.numeric(as.character(f))    # 10 20 5 -> correcto
