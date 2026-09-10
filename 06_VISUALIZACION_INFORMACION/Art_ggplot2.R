#library(tidyverse)
# CIRCULAR ----------------------------------------------------------------
n = 10
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
