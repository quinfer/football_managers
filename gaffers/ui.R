fluidPage(
  theme = shinytheme("flatly"),
  # Application title
  fluidRow(
    headerPanel(title = "Manager turnover"
    )
    ),
  br(),
  fluidRow(
    column(
      width = 4,class = "text-center",
      wellPanel(h3("Timeline Parameters"),
                h3("Choice of Team"),
                br(),
                selectInput(inputId = "teams",
                           label = "Team Name",
                           choices =teams,selected = ""),
            )
      )),
    fluidRow(width=6,
           tabsetPanel(
             tabPanel("Timeline",br(),highchartOutput("timeline")),
             tabPanel("Manager Changes",br(),DT::dataTableOutput("table_mgrs")),
             tabPanel("Mactch outcomes",br(),DT::dataTableOutput("table_matchs"))
           )
    )
)
