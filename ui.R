#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(knitr)

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
           tabsetPanel(type = "tabs",
                       
                       tabPanel('Documentation',
                                h3('Introduction'),
                                'Welcome to Make OR Break R Shiny applications developed by Loh Yen Shen, Chin Shan Hong, Teh Kai Keat and Khor Hew J. 
In our application, we developed a simple interface for users to navigate easily.',
                                h3('User Input'),
                                "In our application, we used 5 *slider input* widgets for the users to input their value for each question. 
The value for each slider input is limited between 0 to 4.
The questions are  based on the features we have selected using Boruta package (for more details, please view Feature Selection tabset). There is a *submit button* widget below the questions for users to submit their inputs.
Please remember to click the submit button in order to see your divorce probability. 
We also included *tabsetPanel* widget to display our findings and results for our project.",
                                h3('Result and Findings'),
                                'To see your divorce probability, please click the Prediction Model tabPanel.
If you wish to see the summary, structure, exploratory data analysis and feature selection of our dataset, please click the tabpanel accordingly.',
                                h3('Summary & Structure'),
                                'The "Summary of divorce dataset" provides the Mininum, 1st Quartile, Median, Mean, 3rd Quartile and the Maximum values for each attribute.',
                                'The "Structure of Divorce Dataset" provides the number of observations, number of variables(attributes) and data type for each attribute.',
                                h3('Exploratory Data Analysis'),
                                'In this tabset, you will be able to view a few visualization plots. ', 
                                '
The 1st plot is a Heat Map of all our attributes in our dataset.',
                                '
The 2nd plot is a Bar Chart that shows the number of divorcees and non-divorcees in our dataset.',
                                'The 3rd plot is a Scatter Plot which shows attribute means for the divorcees against non-divorcees.',
                                'The 4th plot is a Scatter Plot which shows the difference in attribute means for the divorcees against non-divorcees.',
                                h3('Feature Selection'),
                                'In this tabset, you will be able to view the Initial & Finalized Feature Selection.
We have selected the top 5 most significant factors affecting divorce rate based on the box plot for each attribute in our dataset.',
                                h5('Question 1 corresponds to attribute 9.'),
                                h5('Question 2 corresponds to attribute 11.'),
                                h5('Question 3 corresponds to attribute 26.'),
                                h5('Question 4 corresponds to attribute 18.'),
                                h5('Question 5 corresponds to attribute 40.'),
                                'To prove how well-separated the data are, we have plotted each attribute vs. the distribution of the classes they belong to.',
                                
                                h3('Prediction Model'),
                                h5('The 1st part is Prediction.'),
                                h5('	You can answer the questions asked accordingly, submit them and view your divorce rate.'),
                                h5('The 2nd part is Confusion Matrix. '),
                                h5('	The accuracy of our logistic regression model is represented in the form of confusion matrix.'),
                                h5('The 3rd & 4th part are the Sensitivity Rate and Specificity Rate respectively. '),
                                h5('The 5th part is Total Misclassification Error Rate.'),
                                h5('The 6th part is Receiver Operating Characteristic(ROC) curve.')
                                ),
                        
                       tabPanel("Summary & Structure",
                                h3("Summary of Divorce Dataset"),
                                verbatimTextOutput("summary"),
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

