fluidPage(
  theme = shinytheme("flatly"),
  # Application title
  fluidRow(
    headerPanel(
      tags$div(
        h1("Rethinking prediction project", style="display: inline",align="center"),
        h2("Topic 3 Football outcomes and managers turnover"),
    p("The manager timelines for a specified manager or team.  
      The data is source from League of Managers Association and soccer base website.")
    )
    )
    ),
  br(),
  fluidRow(
    column(
      width = 4,class = "text-center",
      wellPanel(h3("Timeline Parameters"),
                br(),
                radioButtons(
              inputId = "type",
              label = "Timeline Plot Focus",
              choices = c("Plot Team" = "Team",
                          "Plot Manager" = "Manager"),
              inline = TRUE,selected = "Manager"),
              br(),
              conditionalPanel(
                'input.type == "Manager"',
                h3("Choice of Manager"),
                br(),
            selectizeInput(inputId = "managers",
                           label="Manager Name",
                           choices =NULL),
            conditionalPanel(
              'input.type == "Team"',
              h3("Choice of Team"),
              br(),
              selectizeInput(inputId = "teams",
                           label = "Team Name",
                           choices =NULL),
            )
      ))),
    column(width = 8,
           tabsetPanel(
             tabPanel("Timeline",br(),highchartOutput("timeline", height = 600)),
             tabPanel("Manager Changes",br(),DT::dataTableOutput("table_mgrs")),
             tabPanel("Mactch outcomes",br(),DT::dataTableOutput("table_matchs"))
           )
    )
  )
)