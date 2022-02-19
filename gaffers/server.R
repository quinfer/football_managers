# Define server logic for timeline
server <- function(input, output,session,server) {
  
updateSelectizeInput(session,'managers',choices=managers,server=TRUE,selected = "Alex Ferguson")
updateSelectizeInput(session,'teams',choices=teams,server=TRUE, selected = "Man Utd")
#   observe({
#   updateSelectizeInput(session,'teams',choices=teams,server=TRUE
#                        , options = list(render = I(
#     '{
#     option: function(item, escape) {
#       // your own code to generate HTML here for each option item
#       return "<div>" + escape(item.value) + "</div>";
#     }
#   }'
#   )))
#   updateSelectizeInput(session,'managers',choices=managers,server=TRUE
#                        , options = list(render = I(
#                          '{
#     option: function(item, escape) {
#       // your own code to generate HTML here for each option item
#       return "<div>" + escape(item.value) + "</div>";
#     }
#   }'
#                        )))
# })
  selected_dat<- reactive({
    if (input$type == 'Team') {
      mgrs %>%
        filter(grepl(pattern=input$teams,TEAM)) %>%
        mutate(event=Manager,
               start=from,
               end=to,
               group=TEAM)
    } else {
      mgrs %>%
        filter(grepl(pattern =input$managers,Manager)) %>%
        mutate(event=TEAM,
               start=from,
               end=to,
               group=Manager)
    }
  })
  
  output$timeline <- renderHighchart({
    dat<-selected_dat()
    hc_vistime(dat, col.event = "event", col.group = "group")
  })

  output$table <- DT::renderDataTable({
    out <- selected_dat() %>%
      select(Manager,TEAM,FROM,TO,WON,DRAWN,LOST)
    out <- as_tibble(out)
    
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