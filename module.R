wordUI <- function(id){
  ns <- NS(id)
  tagList(
  selectInput(ns("select"),label = h3("Select Different Categories"), 
              choices = list("species" = "species", "genus" = "genus", "family" = "family", "specificEpithet" ="specificEpithet", "stateProvince" = "stateProvince")),
  plotOutput(ns("word"),width = "100%", height = "580px")
  
  )
}

wordOutput <- function(input, output, session){
  output$word = renderPlot({
    a<- input$select
    jeopQ <- read.csv('occ.csv', stringsAsFactors = FALSE)
    jeopQ <- jeopQ[a]
    x <- paste0(jeopQ,"$",a) 
    jeopCorpus <- Corpus(VectorSource(x))
    jeopCorpus <- tm_map(jeopCorpus, removePunctuation)
    jeopCorpus <- tm_map(jeopCorpus, stemDocument)
    wordcloud(jeopCorpus,rot.per=0.35, scale=c(10,.5),colors=brewer.pal(8,'Dark2'),random.color = TRUE, max.words = 10000, random.order = FALSE)
  })
}