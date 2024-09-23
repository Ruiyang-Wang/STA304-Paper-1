# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Load the dataset
analysis_data <- read.csv("data/analysis_data/analysis_data.csv")

# Convert the dataset to long format for easier plotting
analysis_data_long <- analysis_data %>%
  pivot_longer(
    cols = January:December, # Using full month names
    names_to = "Month",
    values_to = "Cases"
  )

# Order the months correctly
analysis_data_long$Month <- factor(analysis_data_long$Month, 
                                   levels = c("January", "February", "March", "April", "May", "June", 
                                              "July", "August", "September", "October", "November", "December"))

# Function to plot a single disease trend with labels on bars
plot_disease_trend <- function(disease_name) {
  # Filter for the specific disease
  disease_data <- analysis_data_long %>%
    filter(Disease == disease_name)
  
  # Generate bar graph for the specified disease
  ggplot(disease_data, aes(x = Month, y = Cases, fill = Disease)) +
    geom_bar(stat = "identity", fill = "steelblue") +  # Using a consistent color for simplicity
    geom_text(aes(label = Cases), vjust = -0.5, size = 3) +  # Adding labels on top of bars
    theme_minimal() +
    labs(title = paste("Monthly Trend of", disease_name, "in 2023"),
         x = "Month",
         y = "Number of Cases") +
    theme(axis.text.y = element_blank(), # Remove y-axis labels
          axis.ticks.y = element_blank(), # Remove y-axis ticks
          axis.title.y = element_blank(), # Remove y-axis title
          axis.text.x = element_text(angle = 45, hjust = 1))
}

# Generate separate graphs for each disease with labels on bars
plot_disease_trend("HIV")
plot_disease_trend("Salmonellosis")
plot_disease_trend("Influenza - sporadic")
