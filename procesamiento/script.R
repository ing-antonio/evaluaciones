#install.packages("here")
#install.packages("readr")
#install.packages("dplyr")
#install.packages("plotly")

library(here)
library(readr)
library(dplyr)
library(plotly)

ruta_datos <- here("datos", "carpetas_graficas.csv")
datos <- read_csv(ruta_datos)

t <- list(
  family = "arial",
  size = 9,
  color = toRGB("blue"
  ))

p <- datos %>%
  plot_ly(
    x = ~total_delitos_primera,
    y = ~total_delitos_segunda,
    type = 'scatter',
    mode = 'markers',
    marker = list(size = 15, color = ~total_delitos_segunda, colors = c("#00FF00", "#FFFB00", "#FF0000")),
    text = ~nombre_sec,
    textfont = t,
    textposition = "top center",
    hovertemplate = ~paste(
      "<b><span style='color:#9e2241; font-weight: 800 !important; '>",nombre_sec,"</span></b><br>",
      "<b><span style='font-weight: 800 !important; '>Alcaldía:</span></b>",alcaldia,"<br>",
      "<b><span style='font-weight: 800 !important; '>Primera Evaluación:</span></b>",total_delitos_primera,"<br>",
      "<b><span style='font-weight: 800 !important; '>Segunda Evaluación:</span></b>",total_delitos_segunda,"<br>",
      "<b><span style='font-weight: 800 !important; '>Variación Porcentual:</span></b>",variacion_porcentual,"%<br>",
      "<extra></extra>"
    )
  ) %>%
  layout(
    title = "Diagrama de Dispersión de Carpetas Procesadas por Sector",
    xaxis = list(title = "Total de carpetas (segunda evaluación)"),
    yaxis = list(title = "Total de carpetas (primera evaluación)"),
    hoverlabel = list(bgcolor = "white", font = list(color = "black"))
  )

ruta_salida_html <- here("salidas", "diagrama_dispersion.html")
htmlwidgets::saveWidget(p, file = ruta_salida_html)

cat("Gráfico guardado en:", ruta_salida_html, "\n")

