#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Make OR Break"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("Atr9", "1. I enjoy traveling with my wife/husband.", 
                        min = 0, max = 4, value = 2, step = 1),
            
            
            sliderInput("Atr11", "2. I think that one day in the future, 
                        when I look back, I see that my wife/husband and I are 
                        in harmony with each other.", 
                        min = 0, max = 4, value = 2, step = 1),
            
            
            sliderInput("Atr18", "3. My wife/husband and I have similar 
                        ideas about how marriage should be.", 
                        min = 0, max = 4, value = 2, step = 1),
           
            sliderInput("Atr26", "4. I know my wife’s/husband's basic concerns.", 
                        min = 0, max = 4, value = 2, step = 1),
           
            
            sliderInput("Atr40", "5. We’re just starting a fight 
                        before I know what’s going on.", 
                        min = 0, max = 4, value = 2, step = 1),
            
            helpText("Note: 0 means strongly disagree. 4 means strongly agree"),
            
            submitButton("Submit"),
            
            p("Submit your choices and see your result!")
        ),
        

        mainPanel(
           tabsetPanel(type = "tab",
                       tabPanel("Summary", 
                                h3("Summary of Divorce Dataset"),
                                verbatimTextOutput("summary")
                                ),
                       
                       tabPanel("Structure", 
                                h3("Structure of Divorce Dataset"),
                                verbatimTextOutput("structure")
                                ),
                       
                       tabPanel("Exploratory Data Analysis", 
                                h3("Heat Map"),
                                plotOutput('heatmap'),
                                
                       
                                h3('Number of Divorcees & Number of Non-Divorcees'),
                                plotOutput("bar"),
                                
                                h3("Mean of divorce"),
                                plotOutput("divorcemean"),
                                
                                h3("Difference in Mean for each attribute"),
                                plotOutput("mymean")
                                ),
                       
                       tabPanel("Feature Selection",
                                h3('Initial Feature Selection', align='center'), 
                                plotOutput('initialFeatureSelection'),
                                
                                h3('Finalized Feature Selection', align='center'), 
                                plotOutput('finalizedFeatureSelection'),
                                
                                h3('Attribute value vs Class', align='center'),
                                h4('Attribute 9' , align='center'), plotOutput('Atr9'), 
                                h4('Attribute 11', align='center'), plotOutput('Atr11'),
                                h4('Attribute 26', align='center'), plotOutput('Atr26'),
                                h4('Attribute 18', align='center'), plotOutput('Atr18'),
                                h4('Attribute 40', align='center'), plotOutput('Atr40')
                                ),
                       
                       tabPanel("Prediction Model", 
                                h3('Prediction'),
                                h4("Your divorce rate is: "), 
                                verbatimTextOutput("probability"),
                                verbatimTextOutput("result"),
                                h3("Model Accuracy"),
                                
                                
                                h3("Confusion Matrix"), verbatimTextOutput("confusionmatrix"), 
                                h3("The sensitivity rate of our model (true positive rate)"), verbatimTextOutput("sensitivity"),
                                h3("The specificity rate of our model (true negative rate)"), verbatimTextOutput("specificity"),
                                h3("Total misclassification error rate"), verbatimTextOutput("mer"),
                                h3("The ROC curve"), plotOutput("roc"),
                                h3("The Confusion Matrix plot"), plotOutput("cmplot")
                                )
                       )
        )
    )
))

