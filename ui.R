library(shiny)
library(shinyjs)
library(rhandsontable)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    tags$style(
        HTML(
            ".frac {
    display: inline-block;
                  position: relative;
                  vertical-align: middle;
                  letter-spacing: 0.001em;
                  text-align: center;
                  font-size: 15px;
                  margin-top: 0px;
                  margin-bottom: 0px;
                  font-family: inherit;
                  font-weight: 500;
                  line-height: 1.1;
                  color: inherit;
                  }
                  .frac > span {
                  display: block;
                  padding: 0.1em;
                  }
                  .frac span.bottom {
                  border-top: thin solid black;
                  }
                  .frac span.symbol {
                  display: none;
                  } "
        )
    ),
    useShinyjs(),
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "CSS/font-awesome.min.css"),
        tags$link(rel = "stylesheet", type = "text/css", href = "CSS/EDU-style.css"),
        tags$script(src = "Scripts/script.js")
    ),
    titlePanel("Rounding to the nearest whole number"),
    div(class = "row",
        div(class = "col-sm-9", h4("rounding number to the nearst unit", style = "font-weight : bold")),
        div(
            class = "col-sm-3",
            actionButton("show", "View Tutorial", class = "pull-right btn-view-tutorial")
            )
        ),
    div(class = "flexbox sidebarLayout",
        sidebarLayout(
            sidebarPanel(
                div(class="steps-tabs",
                    tabsetPanel(id="tabs",
                                tabPanel("Learn",
                                         # h5("Choose A Number", align = "center", style = "color : orange")
                                         fluidRow(numericInput(inputId = "num1", label = "Choose A Number", value = 2, min = 0), align = "center", style = "color : orange")
                                ),
                                tabPanel("Quiz",
                                         fluidRow(numericInput(inputId = "num2", label = "Answer:", value = 1, min = 0), align = "center", style = "color : orange"),
                                         div(class = "col-xs-4", actionButton("submit", class =
                                                                                  "orangeBtn", "SUMBIT ANSWER")),
                                         div(class = "col-xs-3"),
                                         div(class = "col-xs-4", actionButton("show", class =
                                                                                  "orangeBtn", "SHOW ANSWER")),
                                         
                                )
                    )
                )
            ),
            mainPanel(
                
                div(id = "page1",
                    plotOutput("plt1", height = 150, width = 900),
                    sliderInput(inputId = "s1", label = "", min = 0, max = 1, step = 0.1, value = 0.1 , width = 900),
                    uiOutput("info1")
                    ),
                div(id = "page2", 
                    plotOutput("plt2", height = 150, width = 900),
                    br(),
                    br(),
                    br(),
                    div(class = "col-sm-5"),
                    div(class = "col-xs-4", actionButton("new", class =
                                                             "orangeBtn", "NEW QUESTION")),
                    br(),
                    br(),
                    br(),
                    
                    uiOutput("info2")
                    )
                # width = 6
            )
        )
        )
    
))
