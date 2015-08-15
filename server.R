
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr);library(reshape2)
#library(png)

data <- mtcars
data$car <- rownames(mtcars)

shinyServer(function(input, output) {
        
        output$mpg <- renderPrint({input$mpg})
        output$cyl <- renderText({input$cyl})
        output$hp <- renderText({input$hp})
        output$carBrand <- renderText({input$carBrand})
#         output$image <- renderImage({
#                 return(list(src ="car.png", 
#                 contentType = "image/png"))
#         })
        
        
        #output$go <- renderPrint({input$go})
       
       output$table <- renderDataTable({
                       if(input$go == 1){
                               if(input$carBrand != "All"){
                               
                                       data <- data[grepl(input$carBrand, data$car),] 
                               }
                               data <- subset(data, cyl <= input$cyl & hp <= input$hp, select= c("car","mpg","hp" ,"cyl"))
                               if(input$mpg == 1){ 
                                       return (data <- arrange(data, mpg))
                               } else {return (data)}
                               
                               
                       }
        })
        
        
})
