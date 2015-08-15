
library(shiny)
library(markdown)


data("mtcars")

brand <- vector("character")
cars <- mtcars 
cars$name <- rownames(mtcars)
brand <- sapply(cars$name, function(n){ unique(strsplit(n," ")[[1]][1])})
names(brand) <- NULL


shinyUI(fluidPage(
        
  # Application title
  #titlePanel("My perfect car"),
  # How to use the application
  sidebarPanel(
          img(src="http://www.clipartbagus.com/wp-content/uploads/free-car-clipart-cars-car-clipart-automotive-cars-online-royalty-free-many-images-plrmyaah.png", align = "left", width = "120", height = "80"),
          #img(src = "./car.png", width = "100", height = "80", align = "left"),
          
          
          
          #imageOutput("image"),
          column(12,
                 includeHTML("include.html")
                 
                 )
  ),

  # Get the criteria for selecting the cars
  sidebarLayout(
    sidebarPanel(
      sliderInput("hp",
                  "Choose the HP:",
                  min = 52,
                  max = 335,
                  value = 142, 
                  step = 20),
      sliderInput("cyl", "Choose number of Cylinders:",
                  min = 4, 
                  max = 8,
                  value = 4,
                  step = 2),
      selectInput("carBrand", "Select the Brand", choices = c("All",brand), multiple = FALSE),
      radioButtons("mpg", label = ("mpg"),
                   choices = list("Important" = 1, "Don't care" = 2), 
                   selected = 2),
      actionButton("go", "Go!")
),

    # Show a plot of the generated distribution
    mainPanel(
           
         dataTableOutput(outputId="table")
          
    )
  )
))
