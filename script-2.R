library(tidyverse)

cut_prices <- diamonds |>
  group_by(cut) |>
  summarize(median_price = median(price), .groups = "drop")

diamonds_plot <- ggplot(
  cut_prices,
  aes(x = fct_reorder(cut, median_price), y = median_price, fill = median_price)
) +
  geom_col(width = 0.72, show.legend = FALSE) +
  geom_text(
    aes(label = scales::dollar(median_price)),
    vjust = -0.6,
    fontface = "bold",
    size = 4
  ) +
  scale_fill_viridis_c(option = "C", begin = 0.15, end = 0.9) +
  scale_y_continuous(
    labels = scales::dollar,
    expand = expansion(mult = c(0, 0.15))
  ) +
  labs(
    title = "A cut above?",
    subtitle = "Median diamond price varies across cut grades",
    x = "Cut",
    y = "Median price (USD)"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", size = 20),
    plot.subtitle = element_text(color = "grey35"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  )

ggsave("diamonds-2.png", plot = diamonds_plot, width = 9, height = 6, dpi = 300)
