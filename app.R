#Importing libraries
library("rgbif")
library("bdvis")
library("tm")
library("SnowballC")
library("wordcloud")
library("rgbif")
library("bdvis")
library("shiny")
library("shinydashboard")
library("shinyWidgets")
library("XML")
#importing module..........................
source("module.r")


#Uncomment these lines to download dataset from GBIF..........
# key <- name_backbone(name = "Mammalia")$usageKey
# occ <-occ_search(taxonKey = key,country = 'US', limit = 10000, year = "2017,2018" ,return = "data")
# write.csv(occ, file = "occ.csv")
occ <- read.csv(file="occ.csv")

 
#This lines picks only wanted Columns from Dataset.
occ <- occ[c("class","family", "genus", "species", "specificEpithet", "stateProvince")]




#Shiny App starts from here............................
 ui <-  dashboardPage(
   
     title = "Visualizations for Biodiversity Data", skin = "purple",
     dashboardHeader(title = "Biodiversity Data Visualization"),



     dashboardSidebar(
       sidebarMenu(
         menuItem("Introduction", tabName = "introduction", icon = icon("home")),
         menuItem("Data", tabName = "data", icon = icon("table")),
         
         menuSubItem("Word cloud", tabName = "word")
         
       )
     ),
     
     
     dashboardBody(
       tabItems(
         tabItem(tabName = "introduction",
                 h1("*Visualizations for Biodiversity Data"), h3("Hard Test 2: To make a shiny app."),h4("This shiny application helps to visulaize Biodiversity data comming from GBIF."),h4("You can click on data Tab to see how data from GBIF look. "),h4("Click on word cloud to see data in the form of word cloud."), br(),h3("*BY: Rahul Chauhan")         ),
         tabItem(tabName = "data",
                 fluidRow(h1("Georeferenced records of Mammals"),
                          br(), h3("10,000 GBIF's occurrence records of Mammals in the U.S"), br(), br()),
                 fluidRow(tabPanel(title = "Mammals Geograph Data",status = "primary",solidHeader = T, dataTableOutput('table'), background = "aqua"))
         ),
         
         tabItem(tabName = "word",
                 #Here i have used shiny module that i made to create word cloud.....
                 #wordUI("AnyName")l
                 wordUI("1"),
                 
                 h1("Word Cloud"),
                 h4("Here i've used word cloud to visualize the frequency of different items. Use selection box to select different Categories. In word cloud, words with more frequency are larger than other.")
                 
                 )
         
       )
     )
   )


 # server
  server <- function(input, output){
   output$table = renderDataTable(occ)
   #Here i have called shiny module that i made to create word cloud.....
   #callModue(wordOutput, "same name that used in UI part")
   callModule(wordOutput, "1")
   
  }

  shinyApp(ui, server)
