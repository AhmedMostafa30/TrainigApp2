#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(plotrix)
library(DT)
library(rhandsontable)
library(plotly)
library(shinyWidgets)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  observeEvent(input$show, {
    showModal(modalDialog(
      title = tagList(
        span("Video Tutorial"),
        modalButton("")
      ),
      div(class="modalContent",
          div(class="video-Content margin-bottom-20",
              tags$video(src = "videos/movie.mp4", type = "video/mp4", controls = "controls")
              #HTML('<iframe width="100%" height="400" src="//www.youtube.com/embed/6F5_jbBmeJU" frameborder="0" allowfullscreen></iframe>')
          ),
          div(class="steps",
              p("STEPS"),
              tags$ol(class="stepsList",
                      tags$li("X")
                      
              )
          )
      ),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  v <- reactiveValues(d = 0, f = 0, shbl = 0)
  rangen = seq(0 , 1, by = 0.1)
  
  observe({
    if (input$tabs == "Learn"){
      show(id = "page1")
      hide(id = "page2")
    }
    else {
      hide(id = "page1")
      show(id = "page2")
    }
    # output$info2 <- renderUI({
    #   p()
    # })
  })
  observeEvent(c(input$s1, input$num1),{
    output$plt1<-renderPlot({
      xaxf = input$num1
      xaxs = xaxf + 1  # xaxf -> x-axis first and xaxs -> x-axis second are the range of x-axis on the plot
      p = input$num1 + input$s1 #the point that should be plotted
      plot(x = p, y = 0, ylab = "", xlab = "", yaxt = "n", steps = 0.1, pch = 25, cex = 1.6, xlim = xaxf:xaxs, col = "orange", bg = "#FFA500")
    })
  })
  observeEvent(input$new,{
    v$shbl = 0
    v$d = sample(0:10, 1)
    v$f = sample(rangen, 1)
    output$info2 <- renderUI({
      p()
    })
  })
  output$plt2<-renderPlot({
    rkm = v$d + v$f
    xaxf = v$d
    xaxs = xaxf + 1
    plot(x = rkm, y = 0, ylab = "", xlab = "", yaxt = "n", steps = 0.1, pch = 25, cex = 1.6, xlim = xaxf:xaxs, col = "orange", bg = "#FFA500")
  })
  output$info1 <- renderUI({
    rkm = input$num1
    if (input$s1 >= 0.5) rkm = rkm + 1
    div(class="text-center ",div(class="info_msg",
                                 span(class="fa fa-info-circle"),
                                 div(class="msg_content",p("Rounding to the nearest whole number = ", rkm))))
  })
  
  observeEvent(input$Show, {
    v$shbl = 1
    output$info2 <- renderUI({
      ans = v$d
      print(ans)
      if (v$f >= 0.5) ans = ans + 1
      # div(class="text-center ",div(class="info_msg",
      #                              span(class="fa fa-info-circle"),
      #                              div(class="msg_content",p("Rounding to the nearest whole number = ", ans))))
      sendSweetAlert(
        session = session,
        title = "Tutorial",
        text = p("Rounding to the nearest whole number = ", ans),
        type = "info"
      )
    })
  })

  observeEvent(input$submit, {
    output$info2 <- renderUI({
      rkm = input$num2
      ans = v$d
      if (is.na(rkm)) {
        #print("haha")
        # return(div(class="text-center ",div(class="err_msg",
        #                              span(class="fa fa-exclamation-triangle"),
        #                              div(class="msg_content", 
        #                                  p("please enter an answer")))))
        return(sendSweetAlert(
          session = session,
          title = "ERROR",
          text = "Please enter the answer",
          type = "error"
        ))
      }
      if (v$f >= 0.5) ans = v$d + 1
      div("col-xs-9")
      if (v$shbl == 1) {
        # div(class="text-center ",div(class="err_msg",
        #                              span(class="fa fa-exclamation-triangle"),
        #                              div(class="msg_content", 
        #                                  p("Please generate new question")))) 
        sendSweetAlert(
          session = session,
          title = "ERROR",
          text = p("Please generate new question"),
          type = "error"
        )
      }
      else if (rkm == ans){
        # div(class="text-center ",div(class="correct_msg",
        #                              span(class="fa fa-check"),
        #                              div(class="msg_content", 
        #                                  p("WELL DONE"))))
        sendSweetAlert(
          session = session,
          title = "SUCCESS",
          text = "The Answer is Right",
          type = "success"
        )
      }else {
        # div(class="text-center ",div(class="err_msg",
        #                              span(class="fa fa-exclamation-triangle"),
        #                              div(class="msg_content", 
        #                                  p("WRONG ANSWER")))) 
        sendSweetAlert(
          session = session,
          title = "WRONG ANSWER",
          text = "Your answer is wrong",
          type = "error"
        )
        
      }
    })
  })
  
})
