# Define server logic for timeline
server <- function(input, output,session,server) {
  
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
    if (!is.na(input$teams)) {
      prem_mgrs %>%
        filter(grepl(pattern=input$teams,Club)) %>%
        mutate(event=Manager,
               start=Start,
               end=Finish,
               group=Club)
    } else {
      prem_mgrs %>%
        filter(grepl(pattern =input$managers,Manager)) %>%
        mutate(event=Manager,
               start=Start,
               end=Finish,
               group=Club)
    }
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