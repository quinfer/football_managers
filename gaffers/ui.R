fluidPage(
  theme = shinytheme("flatly"),
  # Application title
  fluidRow(
    headerPanel(
      tags$div(
        h1("Football Manager Journeys", style="display: inline",align="center"),
        h3("by",a("Quinference",href="https://www.quinference.com/"),style="display: inline"))),
    p("The following displays manager timelines for a specified manager or team.  
      The data is source from ",
    a("Soccer Base",hef="https://www.soccerbase.com/"),
    ".  The data includes information on ",
    length(managers)," managers at",length(teams),
    " teams (including international sides). The data runs from",paste0(first," to ",last),
    "This information is being using in managerial turnover project with my learning colleague", 
        a("Ronan Gallagher.",
          href="https://www.business-school.ed.ac.uk/staff/ronan-gallagher")
    )
    ),
  br(),
  fluidRow(
    column(
      width = 4,class = "text-center",
      wellPanel(h3("Timeline Parameters"),
                br(),
              #   radioButtons(
              # inputId = "type",
              # label = "Timeline Plot Focus",
              # choices = c("Plot Team" = "Team",
              #             "Plot Manager" = "Manager"),
              # inline = TRUE,selected = "Manager"),
              # br(),
              # conditionalPanel(
              #   'input.type == "Manager"',
                h3("Choice of Manager"),br(),
            selectizeInput(inputId = "managers",
                           label="Manager Name",
                           choices =NULL),
            # conditionalPanel(
            #   'input.type == "Team"',
              h3("Choice of Team"),br(),
              selectizeInput(inputId = "teams",
                           label = "Team Name",
                           choices =NULL),
            )
      ),
    column(width = 8,
           tabsetPanel(
             tabPanel("Plot",br(),highchartOutput("timeline", height = 600)),
             tabPanel("Table",br(),DT::dataTableOutput("table"))
           )
    )
  )
)