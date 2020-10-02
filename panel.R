library(shiny)

if (interactive()) {
  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        textInput("age","Age"),
        fileInput("file1", "Choose CSV File", accept = ".csv"),
      ),
      mainPanel(
        tableOutput("contents")
      )
    )
  )
  
  server <- function(input, output) {
    output$contents <- renderTable({
      file <- input$file1
      ext <- tools::file_ext(file$datapath)
      
      req(file)
      validate(need(ext == "JPG", "Please upload a csv file"))
      
      read.csv(file$datapath, header = input$header)
    })
  }
  
  shinyApp(ui, server)
}