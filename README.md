# R_Project: Zomato Analysis Project

## Overview

This project involves the analysis of `Zomato` restaurant data using `R Shiny` and `Power BI`. The provided R Shiny code generates an interactive web application to visualize and explore the dataset. Leveraging the `shiny`, `dplyr`, and `plotly` packages, the app offers an engaging user interface for exploring relationships between different variables. The application offers various visualizations such as bar charts, 3D scatter plots, clustered bar charts, heatmaps, line charts, scatter plots, and an RGL 3D plot.

## Dependencies

Make sure you have the following R packages installed before running the application:

- shiny
- dplyr
- plotly
- shinythemes
- rgl
- rpart
- shinyjs

You can install these packages using the following commands:

```R
install.packages(c("shiny", "dplyr", "plotly", "shinythemes", "rgl", "rpart", "shinyjs"))
```


## Data Source

The project uses Zomato restaurant data, which is loaded from a CSV file. Ensure that the CSV file (`data.csv`) is available at the specified location in the code. The data is cleaned and processed to prepare it for visualization.

```R
# Load Zomato data
zomato_data <- read.csv("E:/R/data.csv", stringsAsFactors = FALSE)

# Data Cleaning
# ... (data cleaning steps)
```

## User Interface (UI)

The Shiny web application has a user-friendly interface with the following features:

- X-Axis, Y-Axis, and Z-Axis dropdowns for selecting data attributes.
- Numeric input fields for specifying city_id, average_cost_for_two, price_range, aggregate_rating, votes, and photo_count.
- Predict button to perform predictions using a random forest model.
- Tabs for different types of visualizations, including bar charts, 3D scatter plots, clustered bar charts, heatmaps, line charts, scatter plots, and an RGL 3D plot.

## Server

The server code contains functions to render various types of plots based on user inputs. Additionally, it includes an event handler for the "Predict" button, which utilizes a pre-trained random forest model (`model`) to make predictions based on user input.

## How to Run

To run the Zomato Analysis Shiny application, execute the following code in R:

```R
shiny::runApp("path_to_directory_containing_code")
```

Replace "path_to_directory_containing_code" with the actual path to the directory where the code is saved.

## Predictions

The application allows users to input values for city_id, average_cost_for_two, price_range, aggregate_rating, votes, and photo_count and click the "Predict" button to obtain predictions for aggregate rating. Note that a pre-trained random forest model (`model`) is required for this functionality.

Ensure that the "ml.r" file containing the model training code is sourced before running the Shiny application:

```R
source("E:/R/ml.r")
```

## Screen Shots
![Screenshot 2023-12-09 110415](https://github.com/Mehul1611/R_Project/assets/111687116/42ec1f63-2000-4d81-af3d-c3e77ca08433)
![Screenshot 2023-12-09 110426](https://github.com/Mehul1611/R_Project/assets/111687116/a4d2c567-4462-4707-9e4a-9375cc84dbb1)
![Screenshot 2023-12-09 110437](https://github.com/Mehul1611/R_Project/assets/111687116/686c6711-eba5-49c6-9c2e-ee1330930d64)
![Screenshot 2023-12-09 110507](https://github.com/Mehul1611/R_Project/assets/111687116/0500fc3e-5e4c-4bf2-91b9-7f44e58187cd)
![Screenshot 2023-12-09 110521](https://github.com/Mehul1611/R_Project/assets/111687116/cd909390-8cd5-47b8-a488-4c071e6e751b)
![Screenshot 2023-12-09 110444](https://github.com/Mehul1611/R_Project/assets/111687116/cc78f2be-8d7a-4dfe-b4c2-02292364789e)
![Screenshot 2023-12-09 110451](https://github.com/Mehul1611/R_Project/assets/111687116/a00c9e7f-14a6-4880-90a8-7618ddd2504a)
![Screenshot 2023-12-09 111946](https://github.com/Mehul1611/R_Project/assets/111687116/b9aaa7a9-778f-4ce4-910a-02130775cd43)

## Disclaimer

This project is provided as a demonstration and may require customization based on your specific needs. The accuracy of predictions depends on the quality and representativeness of the training data used to create the random forest model.


## Contributors
-[Mehul Sharma](https://github.com/Mehul1611)
-[Madhav Somani](https://github.com/Somanimadhav)

