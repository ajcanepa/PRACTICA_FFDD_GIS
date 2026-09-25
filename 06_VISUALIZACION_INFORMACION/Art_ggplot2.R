#library(tidyverse)
# CIRCULAR ----------------------------------------------------------------
n = 100
#n = 100
#n = 500
t1 = 1:n
t0 = seq(from = 0, by = 102,length.out = n) %% n
tibble(x = cos((t1 - 1)*2*pi/n),y = sin((t1 - 1)*2*pi/n), 
       z = cos((t0 - 1)*2*pi/n), w = sin((t0 - 1)*2*pi/n)) %>% 
  ggplot(aes(x = x, y = y, xend = z, yend = w)) +
  geom_segment(alpha = .2) + coord_equal() + theme_void()


# ROSETA ------------------------------------------------------------------
# by = 1
# by = 0.5
# by = 0.1
seq(from = -10, to = 10, by = 0.1) %>%
  expand.grid(x = ., y = .) %>%
  ggplot(aes(x = (x + pi*sin(y)), y = (y + pi*sin(x)))) +
  geom_point(alpha = .1, shape = 20, size = 1, color = "black") +
  theme_void()


# CORAZON -----------------------------------------------------------------
# 1. Corazón en coordenadas cartesianas
#    Curva paramétrica:  x = 16 sin^3(t)
#                        y = 13 cos(t) - 5 cos(2t) - 2 cos(3t) - cos(4t)

corazon <- tibble(t = seq(0, 2 * pi, length.out = 500)) |>
  mutate(x = 16 * sin(t)^3,
         y = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t))

ggplot(corazon, aes(x, y)) +
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_vline(xintercept = 0, colour = "grey50") +
  geom_polygon(fill = "red3", alpha = 0.8) +
  coord_equal() +
  theme_minimal()

# 1b. Variante: el corazón "de la fórmula viral" (una sola función y = f(x))
#     y = |x|^(2/3) + 0.9 * sqrt(3.3 - x^2) * sin(a * pi * x)
#     Cuanto mayor es 'a', más denso se llena el corazón.
tibble(x = seq(-sqrt(3.3), sqrt(3.3), length.out = 3000)) |>
  mutate(y = abs(x)^(2/3) + 0.9 * sqrt(3.3 - x^2) * sin(20 * pi * x)) |>
  ggplot(aes(x, y)) +
  geom_line(colour = "red3") +
  coord_equal() +
  theme_minimal()


# GIRASOL -----------------------------------------------------------------
# 2. Girasol (filotaxis): cada semilla gira el "ángulo áureo"
#    radio = sqrt(i),  ángulo = i * pi * (3 - sqrt(5))  (~137.5 grados)
tibble(i = 1:1500) |>
  mutate(x = sqrt(i) * cos(i * pi * (3 - sqrt(5))),
         y = sqrt(i) * sin(i * pi * (3 - sqrt(5)))) |>
  ggplot(aes(x, y, colour = i, size = i)) +
  geom_point(show.legend = FALSE) +
  scale_colour_viridis_c(option = "inferno") +
  scale_size(range = c(0.3, 3)) +
  coord_equal() +
  theme_void() +
  theme(plot.background = element_rect(fill = "black"))


# ESPIRAL AUREA -----------------------------------------------------------
phi <- (1 + sqrt(5)) / 2   # número áureo

tibble(theta = seq(-2 * pi, 4 * pi, length.out = 2000)) |>
  mutate(r = phi^(2 * theta / pi),
         x = r * cos(theta),
         y = r * sin(theta)) |>
  ggplot(aes(x, y)) +
  geom_hline(yintercept = 0, colour = "grey50") +
  geom_vline(xintercept = 0, colour = "grey50") +
  geom_path(colour = "darkorange", linewidth = 1) +
  coord_equal() +
  theme_minimal()


# FLUID -------------------------------------------------------------------
# Suele tardar mucho en su forma original
# remotes::install_github("djnavarro/jasmines")
library(jasmines)

use_seed(1) %>%
  scene_discs(
    rings = 3, points = 200, size = 5
    # rings = 3, points = 5000, size = 5 # original
  ) %>%
  mutate(ind = 1:n()) %>%
  unfold_warp(
    iterations = 1,
    scale = .5, 
    output = "layer" 
  ) %>%
  unfold_tempest(
    iterations = 20,
    scale = .01
  ) %>%
  style_ribbon(
    palette = palette_named("vik"),
    colour = "ind",
    alpha = c(.1,.1),
    background = "white"
  )
