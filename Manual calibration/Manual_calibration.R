library(shiny)
library(tidyverse)
library(deSolve)
library(cowplot)
library(ggplot2)

# data points
data <- data.frame(time = 1:14,
                   number_infected = c(3,8,26,76,225,298,258,233,189,128,68,29,14,4))

# time for simulation
times <- seq(from = 0, to = 20, by = 0.1)


SIR <- function(t, States, pars)
{
  with(as.list(c(pars)), {
    S <- States[1]
    I <- States[2]
    R <- States[3]
    
    N = S + I + R
    
    dS = - beta*S*I/N
    dI = beta*S*I/N - gamma*I
    dR = gamma*I
    
    list(c(dS, dI, dR))
  })
}



# Define UI for slider demo app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Manual calibration"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      sliderInput("beta", "Effective contact rate beta",
                  min = 0, max = 3,
                  value = 1.5, step = 0.02),
      
      # Input: Decimal interval with step value ----
      sliderInput("gamma", "Infectious period (days)",
                  min = 1, max = 5,
                  value = 3, step = 0.02)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      plotOutput("newcase")
      # verbatimTextOutput("text")
      
    )
  )
)

# Define server logic for slider examples ----
server <- function(input, output) {

  disease.model <- reactive({
    
    Init.state <- c(762, 1, 0)
    pars <- c(beta = input$beta , gamma = 1/input$gamma)
    
    results <- ode(Init.state, times, SIR, parms = pars, method = "bdf") %>%
      as.data.frame()
    
    colnames(results)[2:ncol(results)] <- c("S",  "I", "R")
    
    results
  })
  
  output$newcase <- renderPlot({
    ggplot(data = disease.model(), aes(x = time, y = I)) +
      geom_line() +
      geom_point(data = data, aes(x = time, y = number_infected), col = "red") +
      ylab("I") +
      theme_cowplot()
  })
}

# Create Shiny app ----
shinyApp(ui, server)