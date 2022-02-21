## app.R ##
library(shinydashboard)
library(shiny)
library(DT)

ui <- dashboardPage(
  dashboardHeader(title = "Manager turnover"),
  dashboardSidebar(
    sidebarMenu(id = 'sidebarid',
               selectInput("managers", "Manager:",choices=managers),
  )
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    column(width = 8,
           tabsetPanel(
             tabPanel("Timeline",br(),highchartOutput("timeline", height = 600)),
             tabPanel("Manager Changes",br(),DT::dataTableOutput("table_mgrs")),
             tabPanel("Match outcomes",br(),DT::dataTableOutput("table_matchs"))
    )
  )
)
)

server <- function(input, output,session,server) {
  
  selected_dat<- reactive({
    prem_mgrs %>%
        filter(grepl(pattern=input$teams,Club)) %>%
        mutate(event=Manager,
               start=Start,
               end=Finish,
               group=Club)
  })
  
  output$timeline <- renderHighchart({
    dat<-selected_dat()
    hc_vistime(dat, col.event = "event", col.group = "group")
  })
  
  output$table_mgrs <- DT::renderDataTable({
    prem_mgrs %>%
      DT::datatable(
        rownames = FALSE,
        extensions = "Buttons",
        options = list(
          dom= "Btp",
          buttons = list("excel", "csv"),
          ordering = FALSE,
          scrollX = TRUE
        ))
  })
  output$table_matchs <- DT::renderDataTable({
    prem %>%
      DT::datatable(
        rownames = FALSE,
        extensions = "Buttons",
        options = list(
          dom= "Btp",
          buttons = list("excel", "csv"),
          ordering = FALSE,
          scrollX = TRUE
        ))
  })
  
}

shinyApp(ui, server)