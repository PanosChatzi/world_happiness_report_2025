library(shiny)
library(ggrepel)
library(ggtext)
library(ggiraph)
library(ggplot2)

# Load data
happy_df <- readRDS("data/happiness_data.RDS")

# Define colours for regions
region_colors <- c(
  "Europe & Central Asia" = "#3a539b",
  "East Asia & Pacific" = "#8da0cb",
  "Latin America & Caribbean" = "#e66f63",
  "Middle East & North Africa" = "#e1a03a",
  "South Asia" = "#d9d9d9",
  "Sub-Saharan Africa" = "#7c7c7c"
)

# Server UI
ui <- fluidPage(
  titlePanel("World Happiness Report 2025"),
  girafeOutput("plot", width = "80%")
)

# Server logic
server <- function(input, output) {
  output$plot <- renderGirafe({
    g <- ggplot(data = happy_df,
                aes(x = gdp, 
                    y = ladder_score,
                    colour = region,
                    size = population)) +
      geom_point_interactive(
        alpha = 0.8, color = "black", stroke = 0.5, shape = 21, 
        aes(fill = region,
            tooltip = paste0("<b>", country_name, "</b><br>",
                             "Region: ", region, "<br>",
                             "Happiness Score: ", round(ladder_score, 2), "<br>",
                             "GDP per person: $", format(round(gdp), big.mark=","), "<br>",
                             "Population: ", format(population, big.mark=",")),
            data_id = country_name),
        hover_css = "fill:orange;stroke:black;r:8px;cursor:pointer;") +
      geom_text_repel(
        data = subset(happy_df, country_name %in% c("Finland", "Denmark", "Iceland", "Sweden", 
                                                     "Netherlands", "Greece")),
        aes(label = country_name),
        size = 3,
        point.padding = 0.25,
        box.padding = 0.3,
        color = "black"
      ) +
      scale_x_log10(labels = scales::comma) +
      scale_fill_manual(values = region_colors) +
      scale_size_continuous(range = c(1, 15)) +
      labs(title = "Happiness vs GDP",
           subtitle = "Life evaluation (10=happiest)",
           caption = "Sources: World Happiness Report, 2025; World Bank, 2023",
           x = "GDP ($), log scale",
           y = "") +
      guides(colour = "none", fill = "none", size = "none") +
      theme_minimal() +
      theme(
        axis.text = element_text(size = 10, color = "black"),
        plot.title = element_text(size = 14),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        plot.caption = element_text(hjust = 0),
        plot.margin = margin(10, 25, 10, 10)
      ) +
      scale_y_continuous(position = "right") +
      annotate(
        "text",
        x = 0, y = 6.2,
        label = "Circle size=population",
        hjust = 0, vjust = 0.5,
        size = 3.5
      )
    
    # Convert to girafe object
    girafe_plot <- girafe(ggobj = g, 
                          options = list(
                            opts_hover(css = "fill:orange;"),
                            opts_tooltip(css = "background-color:white;padding:5px;border-radius:3px;box-shadow:2px 2px 5px rgba(0,0,0,0.3);"),
                            opts_zoom(max = 5),
                            opts_selection(type = "single", css = "fill:red;stroke:black;")
                          ),
                          width_svg = 10,
                          height_svg = 7)
    girafe_plot
  })
}

# Run the app
shinyApp(ui = ui, server = server)