#Example 1
#Alexandra Cabrera



library(shiny,warn.conflicts = FALSE)
library(tidyverse,warn.conflicts = FALSE)

dat<-read.csv("cces_sample_coursera.csv",sep =",")
dat<- dat %>% select(c("pid7","ideo5"))
dat<-drop_na(dat)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel(""),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("id5",
                        "Select Five Point Ideology (1=Very liberal, 5=Very conservative)",
                        min = 1,
                        max = 5,
                        value = 3)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        y<-input$id5
        
        sub1 <- subset(dat,  dat$ideo5==input$id5)
        ggplot(sub1, aes(x=pid7,y = ideo5)) +
            geom_bar(stat = "identity")+
            labs( x = "7 Point Party ID, 1 Very D, 7 Very R",y = "Count")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
