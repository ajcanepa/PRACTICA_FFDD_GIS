# =============================================================================
#  16 figuras matemáticas con ggplot2 (solo tidyverse)
#  Receta común: tibble() -> mutate() con la fórmula -> ggplot()
# =============================================================================
library(tidyverse)
set.seed(2026)

# -----------------------------------------------------------------------------
# 1. Mariposa (curva de Fay)
#    Curiosidad: la publicó Temple H. Fay en 1989 en la revista
#    American Mathematical Monthly.
# -----------------------------------------------------------------------------
tibble(t = seq(0, 24 * pi, length.out = 10000)) |>
  mutate(k = exp(cos(t)) - 2 * cos(4 * t) - sin(t / 12)^5,
         x = sin(t) * k,
         y = cos(t) * k) |>
  ggplot(aes(x, y)) +
  geom_path(colour = "purple4", linewidth = 0.3) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 2. Curva de Lissajous: x = sin(a t + delta), y = sin(b t)
#    Curiosidad: Jules Lissajous las estudió en 1857 con espejos pegados a
#    diapasones. El logotipo de la televisión pública australiana (ABC) es
#    una curva de Lissajous.
# -----------------------------------------------------------------------------
a <- 3; b <- 4

tibble(t = seq(0, 2 * pi, length.out = 2000)) |>
  mutate(x = sin(a * t + pi / 2),
         y = sin(b * t)) |>
  ggplot(aes(x, y)) +
  geom_path(colour = "steelblue", linewidth = 1) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 3. Astroide: x = cos^3(t), y = sin^3(t)
#    Curiosidad: es la curva que "dibuja" una escalera que resbala por una
#    pared: la envolvente de todas sus posiciones es un astroide.
#    Aquí se ven esas escaleras (segmentos) junto con la curva.
# -----------------------------------------------------------------------------
escaleras <- tibble(t = seq(0, 2 * pi, length.out = 60)) |>
  mutate(x = cos(t), y = sin(t))

tibble(t = seq(0, 2 * pi, length.out = 1000)) |>
  mutate(x = cos(t)^3, y = sin(t)^3) |>
  ggplot(aes(x, y)) +
  geom_segment(data = escaleras, aes(x = x, y = 0, xend = 0, yend = y),
               colour = "grey70", linewidth = 0.3) +
  geom_path(colour = "firebrick", linewidth = 1.2) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 4. Lemniscata de Bernoulli (el "infinito")
#    Curiosidad: Jakob Bernoulli la describió en 1694 y la llamó lemniscus,
#    "cinta" en latín. Es el conjunto de puntos cuyo producto de distancias
#    a dos focos es constante.
# -----------------------------------------------------------------------------
tibble(t = seq(0, 2 * pi, length.out = 1000)) |>
  mutate(x = cos(t) / (1 + sin(t)^2),
         y = sin(t) * cos(t) / (1 + sin(t)^2)) |>
  ggplot(aes(x, y)) +
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_vline(xintercept = 0, colour = "grey50") +
  geom_path(colour = "darkgreen", linewidth = 1.2) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 5. Cardioide: x = 2cos(t) - cos(2t), y = 2sin(t) - sin(2t)
#    Curiosidad: el "cuerpo" principal del conjunto de Mandelbrot es
#    exactamente un cardioide. Los micrófonos "cardioides" deben su nombre a
#    que su patrón de captación tiene esta forma.
# -----------------------------------------------------------------------------
tibble(t = seq(0, 2 * pi, length.out = 1000)) |>
  mutate(x = 2 * cos(t) - cos(2 * t),
         y = 2 * sin(t) - sin(2 * t)) |>
  ggplot(aes(x, y)) +
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_vline(xintercept = 0, colour = "grey50") +
  geom_polygon(fill = "tomato", alpha = 0.7) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 6. Epicicloide: un círculo de radio r rueda por fuera de otro de radio R
#    Curiosidad: con R/r = 1 sale un cardioide y con R/r = 2 una nefroide,
#    que es la forma brillante que hace la luz en el fondo de una taza.
# -----------------------------------------------------------------------------
R <- 5; r <- 1   # R/r = número de "puntas"

tibble(t = seq(0, 2 * pi, length.out = 2000)) |>
  mutate(x = (R + r) * cos(t) - r * cos((R + r) / r * t),
         y = (R + r) * sin(t) - r * sin((R + r) / r * t)) |>
  ggplot(aes(x, y)) +
  geom_path(colour = "darkorange", linewidth = 1.2) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 7. Rosa polar: r = cos(k * theta)
#    Curiosidad: las estudió Guido Grandi hacia 1725. Si k es impar la rosa
#    tiene k pétalos; si k es par tiene 2k.
# -----------------------------------------------------------------------------
k <- 4

tibble(theta = seq(0, 2 * pi, length.out = 2000)) |>
  mutate(r = cos(k * theta),
         x = r * cos(theta),
         y = r * sin(theta)) |>
  ggplot(aes(x, y)) +
  geom_polygon(fill = "hotpink", colour = "deeppink4", alpha = 0.6) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 8. Espiral de Arquímedes: r = theta
#    Curiosidad: Arquímedes la describió en "Sobre las espirales"
#    (~225 a. C.). Con ella se puede trisecar un ángulo, algo imposible
#    solo con regla y compás.
# -----------------------------------------------------------------------------
tibble(theta = seq(0, 6 * pi, length.out = 2000)) |>
  mutate(x = theta * cos(theta),
         y = theta * sin(theta)) |>
  ggplot(aes(x, y)) +
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_vline(xintercept = 0, colour = "grey50") +
  geom_path(colour = "navy", linewidth = 1) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 9. Espiral de Fermat: r = ±sqrt(theta)
#    Curiosidad: el modelo de Vogel (1979) del girasol coloca cada semilla
#    sobre una espiral de Fermat girando el ángulo áureo (~137,5 grados).
# -----------------------------------------------------------------------------
tibble(theta = seq(0, 10 * pi, length.out = 2000)) |>
  mutate(r = sqrt(theta)) |>
  (\(d) bind_rows(positiva = d, negativa = mutate(d, r = -r), .id = "rama"))() |>
  mutate(x = r * cos(theta), y = r * sin(theta)) |>
  ggplot(aes(x, y, colour = rama)) +
  geom_path(linewidth = 1, show.legend = FALSE) +
  scale_colour_manual(values = c("black", "goldenrod")) +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 10. Onda amortiguada: y = e^(-0.2x) * sin(2x)
#     Curiosidad: es la solución del oscilador armónico amortiguado, el mismo
#     modelo que describe los amortiguadores de un coche o un circuito RLC.
#     Las líneas discontinuas (±e^(-0.2x)) son su "envolvente".
# -----------------------------------------------------------------------------
tibble(x = seq(0, 20, length.out = 1000)) |>
  mutate(y = exp(-0.2 * x) * sin(2 * x)) |>
  ggplot(aes(x, y)) +
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_line(aes(y = exp(-0.2 * x)), linetype = "dashed", colour = "grey40") +
  geom_line(aes(y = -exp(-0.2 * x)), linetype = "dashed", colour = "grey40") +
  geom_line(colour = "darkcyan", linewidth = 1) +
  theme_minimal()

# -----------------------------------------------------------------------------
# 11. Curva de Batman (funciones a trozos)
#     Curiosidad: se hizo viral en internet en 2011 y se atribuye a
#     J. Matthew Register. Está hecha solo con elipses, rectas y parábolas.
# -----------------------------------------------------------------------------
x <- seq(-7, 7, length.out = 2000)

arriba <- tibble(x) |>
  mutate(y = case_when(
    abs(x) > 3    ~ 3 * sqrt(1 - (x / 7)^2),
    abs(x) > 1    ~ 6 * sqrt(10) / 7 + 1.5 - 0.5 * abs(x) -
                    6 * sqrt(10) / 14 * sqrt(pmax(0, 4 - (abs(x) - 1)^2)),
    abs(x) > 0.75 ~ 9 - 8 * abs(x),
    abs(x) > 0.5  ~ 3 * abs(x) + 0.75,
    TRUE          ~ 2.25))

abajo <- tibble(x = rev(x)) |>
  mutate(y = case_when(
    abs(x) > 4 ~ -3 * sqrt(1 - (x / 7)^2),
    TRUE       ~ abs(x / 2) - (3 * sqrt(33) - 7) / 112 * x^2 - 3 +
                 sqrt(pmax(0, 1 - (abs(abs(x) - 2) - 1)^2))))

bind_rows(arriba, abajo) |>
  ggplot(aes(x, y)) +
  geom_polygon(fill = "black") +
  coord_equal() +
  theme_void() +
  theme(plot.background = element_rect(fill = "gold", colour = NA))

# -----------------------------------------------------------------------------
# 12. Triángulo de Sierpinski ("juego del caos")
#     Regla: elige un vértice al azar y muévete a mitad de camino hacia él.
#     Curiosidad: tiene área cero y dimensión fractal log(3)/log(2) ≈ 1,585:
#     es "más" que una línea pero "menos" que una superficie.
# -----------------------------------------------------------------------------
n  <- 20000
vx <- c(0, 1, 0.5); vy <- c(0, 0, sqrt(3) / 2)   # vértices
v  <- sample(1:3, n, replace = TRUE)
px <- py <- numeric(n)
for (i in 2:n) {
  px[i] <- (px[i - 1] + vx[v[i]]) / 2
  py[i] <- (py[i - 1] + vy[v[i]]) / 2
}

tibble(x = px, y = py, vertice = factor(v)) |>
  ggplot(aes(x, y, colour = vertice)) +
  geom_point(size = 0.1, show.legend = FALSE) +
  coord_equal() +
  theme_void()

# -----------------------------------------------------------------------------
# 13. Helecho de Barnsley
#     Curiosidad: Michael Barnsley lo presentó en "Fractals Everywhere"
#     (1988). Con solo 4 transformaciones reproduce el helecho real
#     Asplenium adiantum-nigrum.
# -----------------------------------------------------------------------------
n  <- 50000
px <- py <- numeric(n)
regla <- sample(1:4, n, replace = TRUE, prob = c(0.01, 0.85, 0.07, 0.07))
for (i in 2:n) {
  x0 <- px[i - 1]; y0 <- py[i - 1]
  nuevo <- switch(regla[i],
    c(0, 0.16 * y0),                                     # tallo
    c(0.85 * x0 + 0.04 * y0, -0.04 * x0 + 0.85 * y0 + 1.6),  # hojas menores
    c(0.20 * x0 - 0.26 * y0,  0.23 * x0 + 0.22 * y0 + 1.6),  # hoja izquierda
    c(-0.15 * x0 + 0.28 * y0, 0.26 * x0 + 0.24 * y0 + 0.44)) # hoja derecha
  px[i] <- nuevo[1]; py[i] <- nuevo[2]
}

tibble(x = px, y = py) |>
  ggplot(aes(x, y)) +
  geom_point(size = 0.05, colour = "forestgreen") +
  coord_equal() +
  theme_void()

# -----------------------------------------------------------------------------
# 14. Tablas de multiplicar en un círculo
#     Se ponen N puntos en un círculo y se une el punto i con el (m * i) mod N.
#     Curiosidad: con m = 2 aparece un cardioide y con m = 3 una nefroide.
#     Lo popularizó el canal Mathologer (2015).
# -----------------------------------------------------------------------------
N <- 200; m <- 2

tibble(i = 0:(N - 1)) |>
  mutate(j = (m * i) %% N,
         x = cos(2 * pi * i / N), y = sin(2 * pi * i / N),
         xend = cos(2 * pi * j / N), yend = sin(2 * pi * j / N)) |>
  ggplot() +
  geom_segment(aes(x, y, xend = xend, yend = yend, colour = i),
               linewidth = 0.3, show.legend = FALSE) +
  scale_colour_viridis_c() +
  coord_equal() +
  theme_void()

# -----------------------------------------------------------------------------
# 15. Estrella de hilo ("string art")
#     Se une el punto (i, 0) con (0, n - i) en los cuatro cuadrantes.
#     Curiosidad: solo con rectas aparece una curva, que es un arco de
#     parábola. Mary Everest Boole usaba esta técnica en el siglo XIX para
#     enseñar geometría a los niños.
# -----------------------------------------------------------------------------
n <- 20

crossing(i = 0:n, sx = c(-1, 1), sy = c(-1, 1)) |>
  ggplot() +
  geom_segment(aes(x = sx * i, y = 0, xend = 0, yend = sy * (n - i)),
               colour = "mediumvioletred", linewidth = 0.4) +
  labs(x = "x", y = "y") +
  coord_equal() +
  theme_minimal()

# -----------------------------------------------------------------------------
# 16. Paseo aleatorio en 2D
#     Curiosidad: Karl Pearson acuñó el término "random walk" en 1905.
#     George Pólya demostró (1921) que en 2D el paseo vuelve al origen con
#     probabilidad 1, pero en 3D no ("un borracho siempre vuelve a casa;
#     un pájaro borracho puede perderse para siempre").
# -----------------------------------------------------------------------------
tibble(paso = 1:5000,
       x = cumsum(rnorm(5000)),
       y = cumsum(rnorm(5000))) |>
  ggplot(aes(x, y, colour = paso)) +
  geom_path(linewidth = 0.4, show.legend = FALSE) +
  scale_colour_viridis_c(option = "inferno") +
  coord_equal() +
  theme_void() +
  theme(plot.background = element_rect(fill = "black"))
