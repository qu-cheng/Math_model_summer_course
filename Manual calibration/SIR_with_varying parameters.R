library(shiny)
library(tidyverse)
library(deSolve)
library(cowplot)
library(ggplot2)

# time for simulation
times <- seq(from = 0, to = 100, by = 1)


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
  titlePanel("SIR with varying parameters"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      sliderInput("beta", "beta",
                  min = 0, max = 1,
                  value = 0, step = 0.01),
      
      # Input: Decimal interval with step value ----
      sliderInput("gamma", "gamma",
                  min = 0, max = 1,
                  value = 1, step = 0.01)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      plotOutput("newcase")
      
    )
  )
)

# Define server logic for slider examples ----
server <- function(input, output) {
  
  disease.model <- reactive({
    
    Init.state <- c(99999, 1, 0)
    pars <- c(beta = input$beta , gamma = input$gamma)
    
    results <- ode(Init.state, times, SIR, parms = pars) %>%
      as.data.frame()
    
    colnames(results)[2:ncol(results)] <- c("S",  "I", "R")
    
    results %>% 
      select(time, S, I, R) %>%
      gather("state", "value", S:R) %>%
      mutate(state = factor(state, levels = c("S", "I", "R")))
      
  })
  
  output$newcase <- renderPlot({
    ggplot(data = disease.model(), aes(x = time, y = value, col = state)) +
      geom_line() +
      ylab("Number of individuals") +
      theme_cowplot()
  })
}

# Create Shiny app ----
shinyApp(ui, server)