# World Happiness Report 2025

Inspired by an article in **The Economist**, this project visualizes the association between wealth and happiness using data from the World Happiness Report and the World Bank. [The Interactive GDP and Happiness Report](https://panoschatzi.github.io/world_happiness_report_2025/exports/happiness_gdp_interactive.html) allows users to explore how GDP relates to life satisfaction scores across different countries and regions of the world.

## Features

- Interactive scatter plot showing the relationship between GDP per capita and happiness scores
- Annotations for Greece and the top 5 happiest countries (Finland, Denmark, Iceland, Sweden, and Netherlands)
- Linear trend line showing the overall relationship
- Hover tooltips displaying detailed information for each country
- Data points sized by country population
- Color-coded by region
- Zoom functionality for detailed exploration

## Shiny App

You can access the interactive visualization at:
[https://panoschatz.shinyapps.io/World_Happiness_Report_2025/](https://panoschatz.shinyapps.io/World_Happiness_Report_2025/)

## Data Sources

- World Happiness Report 2025
- World Bank population data (2023)
- World Bank GDP data (2023)

## Technologies Used

- R
- Shiny
- ggplot2
- ggiraph
- Power Query (for data preparation)

## Installation & Usage

1. Clone this repository
2. Ensure you have R and the required packages installed:
   ```R
   install.packages(c("shiny", "ggplot2", "ggiraph", "readxl", "janitor", "ggrepel", "ggtext"))
   ```
3. Place your `happiness_gdp_pop.xlsx` or `.RDS` file in the project directory
4. Run the Shiny app:
   ```R
   shiny::runApp()
   ```

## Data Preparation

The data was prepared by:
1. Downloading raw data from the World Happiness Report and World Bank
2. Using Power Query to clean, transform, and join datasets
3. Exporting the combined dataset to the Excel file used by the application

## License

This project is licensed under the MIT License.

## Acknowledgments

- [The Economist](https://www.economist.com/graphic-detail/2025/03/20/lessons-from-the-happiest-countries-in-the-world) for the original inspiration
- World Happiness Report for the data and research
