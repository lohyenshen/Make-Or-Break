
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(corrplot)
library(heatmaply)
library(corrgram)
library(caret)
library(Boruta)
library(InformationValue)
library(ggplot2)
library(plot.matrix)
library(brglm)
library(pheatmap)
library(plotly)  
library(knitr)

# #Read the divorce.csv file to be examined
# divorceDataSet <- read.csv("divorce.csv", header = TRUE, sep=';')
# 
# 
# #separate into positive and negative class, the divorce_positive & 
# #divorce_negative are used for data analysis 
# divorce_positive = divorceDataSet[divorceDataSet$Class==1, ]
# divorce_negative = divorceDataSet[divorceDataSet$Class==0, ]
# nrow(divorce_negative)
# nrow(divorce_positive)
# # View(divorce_negative)
# 
# 
# #check for mis-entered data
# nfeatures = ncol((divorceDataSet)) - 1
# maxValues = rep(0,nfeatures)
# for (i in 1 : nfeatures) {
#     maxValues[i] = max(divorceDataSet[i, ])
# }
# # maxValues
# 
# minValues = rep(0, nfeatures)
# for (i in 1 : nfeatures) {
#     minValues[i] = min(divorceDataSet[i,])
# }
# # minValues
# 
# decimals = rep(0, nfeatures)
# for (i in 1 : nfeatures) {
#     decimals[i] = max(divorceDataSet[i] %% 1)
# }
# # decimals
# 
# divorceDataSet$Class = as.factor(divorceDataSet$Class)
# 
# 
# #Examination of the  data
# divorceesNum <- length(divorce_positive$Class)
# NotdivorceesNum <- length(divorce_negative$Class)
# # print(list(divorceesNum, NotdivorceesNum))
# 
# #Visualizing the structure dataset before min max normalization
# # heatmaply(divorceDataSet, xlab = "Attributes", ylab = "Rows")
# 
# #Plot the number of divorceess and non-divorcees using bar chart
# 
# plotdata <- data.frame(
#     Count <- c(divorceesNum, NotdivorceesNum),
#     Group <- c("Divorcees", "Non-Divorcees")
# )
# 
# # ggplot(plotdata, aes(x = Group, y = Count)) + geom_col(fill = c(" blue", "yellow"), color = "black", width = 0.5)+
# #     labs(title = "Number of Divorcees and Non-Divorcees") + theme(plot.title = element_text(hjust = 0.5)) +
# #     geom_text(aes(label = Count), vjust = -0.5, size = 5)
# 
# 
# #Means of divorces vs non-divorces for each attribute
# par(mfrow = c(1, 1))
# means <- matrix(0, nrow = ncol(divorceDataSet) - 1, ncol = 2)
# colnames(means) = c("positive", "negative")
# 
# for(i in 1:(ncol(divorceDataSet) - 1)){
#     means[i, 1] = mean(divorce_positive[[i]])
#     means[i, 2] = mean(divorce_negative[[i]])
# }
# 
# 
# # plot(x = means[, 1], y = means[, 2],ylim = c(0,4), xlim = c(0,4), xlab = 'Mean for Divorcees', ylab = 'Mean for 
# # Non-Divorcees', 
# #      main = 'Attribute Means for Divorcees vs. Non-Divorcees') 
# # abline(a=0, b=1)
# 
# #difference in means for each attribute
# meanDifference <- means[, 1] -  means[, 2]
# # plot(meanDifference, main = "Difference in Attribute Means for Divorcees vs
# #Non-Divorcees", ylab = "Difference", xlab = "Attribute Number")
# 
# bigDifference <- which(meanDifference > 3)
# # bigDifference
# smallDifference <- which(meanDifference < 2)
# # smallDifference
# 
# #Feature selection part
# boruta <- Boruta(Class ~ ., data = divorceDataSet, doTrace = 2, maxRuns = 100)
# # print(boruta)
# 
# #Plot the initial result of feature selection
# # plot(boruta, las = 2, cex.axis = 0.5)
# 
# #Finalize the feature selection
# final.boruta <- TentativeRoughFix(boruta)
# # print(final.boruta)
# 
# #Plot the finalized feature selection result
# # plot(final.boruta, las = 2, cex.axis = 0.5)
# 
# #Extract the selected features
# selectedFeatures <- getSelectedAttributes(final.boruta)
# selectedFeatures <- as.vector(selectedFeatures)
# 
# #Select the top 5 most significant features
# selectedFeatures <- selectedFeatures[selectedFeatures %in% c("Atr9", "Atr11", "Atr26", "Atr18", "Atr40")]
# 
# 
# #Creating the traning and testing set
# sample <- sample(c(TRUE, FALSE),nrow(divorceDataSet), replace = TRUE, prob = c(0.7, 0.3))
# train <- divorceDataSet[sample, ]
# test <- divorceDataSet[!sample, ]
# 
# #Train the logistic regression model
# model <- brglm(Class~Atr9 + Atr11 + Atr26 + Atr18 + Atr40 , family = binomial, data = train)
# 
# # summary(model)
# 
# #Accesing model fit using McFadden's R Square metric, value is between 0 and 1, the higher the value better
# pscl::pR2(model)["McFadden"]
# 
# #Test the model using one testing set below
# couple <- data.frame(Atr9 = 4, Atr11 = 4, Atr26 = 1, Atr18 = 3, Atr40 = 2)
# predict(model, couple, type = "response")
# 
# #Test the model using whole testing set
# predicted <- predict(model, test, type = "response")
# predicted
# 
# #Find the optimal probability to use to maximize the accuracy of our model
# #Any probability higher than optimal cut off will be predicted to divorced, 
# #lower will be predicted to marriage
# optimal <- optimalCutoff(test$Class, predicted)[1]
# optimal
# 
# #Confusion Matrix to visualize the accuracy of our model
# confusionMatrix(test$Class, predicted)
# # View(confusionMatrix(test$Class, predicted))
# 
# #get the sensitivity rate of our model (true positive rate)
# sensitivity(test$Class, predicted)
# 
# #get the specificity rate of our model (true negative rate)
# specificity(test$Class, predicted)
# 
# #calculate total misclassification error rate
# misClassError(test$Class, predicted, threshold = optimal)
# 
# #Plot the ROC curve, the higher the better
# # plotROC(test$Class, predicted)
# 
# #Add row number as a column
# divorce1 = divorceDataSet
# rows <- sample(nrow(divorce1))
# divorce1.1 <- divorce1[rows, ]
# divorce1.1$Index = as.numeric(row.names(divorce1))
# 
# #Plot Attribute value vs Class
# # ggplot(divorce1.1, aes(x=Index, y=Atr9, col = Class))+geom_point()
# # ggplot(divorce1.1, aes(x=Index, y=Atr11, col = Class))+geom_point()
# # ggplot(divorce1.1, aes(x=Index, y=Atr26, col = Class))+geom_point()
# # ggplot(divorce1.1, aes(x=Index, y=Atr18, col = Class))+geom_point()
# # ggplot(divorce1.1, aes(x=Index, y=Atr40, col = Class))+geom_point()
# 
# divorceesNum <- sum(divorceDataSet$Class == 1)
# nondivorceesNum <- sum(divorceDataSet$Class == 0)
# 
# plotdata <- data.frame(
#     Count <- c(divorceesNum, nondivorceesNum),
#     Group <- c("Divorcees", "Non-Divorcees")
# )
# 
# # ggplot(plotdata, aes(x = Group, y = Count)) + geom_col(fill = c(" blue", "yellow"), color = "black", width = 0.5)+
# #     labs(title = "Number of Divorcees and Non-Divorcees") + theme(plot.title = element_text(hjust = 0.5)) +
# #     geom_text(aes(label = Count), vjust = -0.5, size = 5)
# 
# 
# col1 <- confusionMatrix(test$Class, predicted)[, 1]
# col2 <- confusionMatrix(test$Class, predicted)[, 2]
# par(mar=c(5.1, 5.1, 5.1, 5.1))
# # plot(as.matrix(confusionMatrix(test$Class, predicted)), main = 
# #          "Confusion Matrix", xlab = "Actual", ylab = "Predicted", 
# #      cex.lab = 2, col = heat.colors, key = NULL, cex.main = 2.5, digit = 0,  text.cell = list(cex = 2), fmt.cell = "%s", breaks = 2)
# 

























shinyServer(function(input, output) {
    # divorceRate <- reactive({
    #     couple <- data.frame(Atr9 = input$Atr9, Atr11 = input$Atr11, Atr26 = 
    #                              input$Atr26, Atr18 = input$Atr18, Atr40 = input$Atr40)
    #     
    #     divorceRate <- predict(model, couple, type = "response")
    #     divorceRate <- 1 - divorceRate
    #     names(divorceRate) <- NULL   
    #     divorceRate
    # })
    # 
    # output$probability <- renderPrint({
    #     divorceRate()
    # })
    # 
    # output$result <- renderText({
    #     if(divorceRate() < 0.5){
    #         "You and your spouse will live happily ever after"
    #     }
    #     else{
    #         "You and your spouse will divorce"
    #     }
    # })
    # 
    # 
    # output$structure <- renderPrint({
    #     str(divorceDataSet)
    # })
    # 
    # output$summary <- renderPrint({
    #     summary(divorceDataSet)
    # })
    # 
    # output$bar <- renderPlot({
    #     divorceesNum   <- sum(divorceDataSet$Class == 1)
    #     nondivorceesNum <- sum(divorceDataSet$Class == 0)
    #     
    #     plotdata <- data.frame(
    #         Count <- c(divorceesNum, nondivorceesNum),
    #         Group <- c("Divorcees", "Non-Divorcees")
    #     )
    #     
    #     ggplot(plotdata, aes(x = Group, y = Count)) + geom_col(fill = c(" blue", "yellow"), color = "black", width = 0.5)+
    #         labs(title = "Number of Divorcees and Non-Divorcees") + theme(plot.title = element_text(hjust = 0.5)) +
    #         geom_text(aes(label = Count), vjust = -0.5, size = 5)
    # })
    # 
    # 
    # # KK
    # output$divorcemean <- renderPlot({
    #     plot(x = means[, 1], y = means[, 2],ylim = c(0,4), xlim = c(0,4), 
    #     xlab = 'Mean for Non-Divorcees', 
    #     ylab = 'Mean for Divorcees', 
    #          main = 'Attribute Means for Divorcees vs. Non-Divorcees') 
    #     abline(a=0, b=1)
    # })
    # 
    # output$mymean <- renderPlot({
    #     plot(meanDifference, main = "Difference in Attribute Means for Divorcees vs
    # Non-Divorcees", ylab = "Difference", xlab = "Attribute Number")
    # })
    # 
    # output$heatmap <- renderPlot({
    #     ggheatmap(divorceDataSet)
    # })
    # 
    # # SW
    # output$initialFeatureSelection <- renderPlot({
    #     plot(boruta, las = 2, cex.axis = 0.5)
    # })
    # 
    # output$finalizedFeatureSelection <- renderPlot({
    #     plot(final.boruta, las = 2, cex.axis = 0.5)
    # })
    # 
    # output$Atr9 <- renderPlot({
    #     ggplot(divorce1.1, aes(x=Index, y=Atr9, col = Class))+geom_point()
    # })
    # 
    # output$Atr11 <- renderPlot({
    #     ggplot(divorce1.1, aes(x=Index, y=Atr11, col = Class))+geom_point()
    # })
    # 
    # output$Atr26 <- renderPlot({
    #     ggplot(divorce1.1, aes(x=Index, y=Atr26, col = Class))+geom_point()
    # })
    # 
    # output$Atr18 <- renderPlot({
    #     ggplot(divorce1.1, aes(x=Index, y=Atr18, col = Class))+geom_point()
    # })
    # 
    # output$Atr40 <- renderPlot({
    #     ggplot(divorce1.1, aes(x=Index, y=Atr40, col = Class))+geom_point()
    # })
    # 
    # 
    # # HJ
    # output$confusionmatrix <- renderPrint({
    #     confusionMatrix(test$Class, predicted)
    # })
    # 
    # output$sensitivity <- renderPrint({
    #     sensitivity(test$Class, predicted)
    # })
    # 
    # output$specificity <- renderPrint({
    #     specificity(test$Class, predicted)
    # })
    # 
    # output$mer <- renderPrint({
    #     misClassError(test$Class, predicted, threshold = optimal)
    # })
    # 
    # output$roc <- renderPlot({
    #     plotROC(test$Class, predicted)
    # })
    # 
    # output$cmplot <- renderPlot({
    #     col1 <- confusionMatrix(test$Class, predicted)[, 1]
    #     col2 <- confusionMatrix(test$Class, predicted)[, 2]
    #     par(mar=c(5.1, 5.1, 5.1, 5.1))
    #     plot(as.matrix(confusionMatrix(test$Class, predicted)), main = 
    #              "Confusion Matrix", xlab = "Actual", ylab = "Predicted", 
    #          cex.lab = 2, col = heat.colors, key = NULL, cex.main = 2.5, digit = 0,  text.cell = list(cex = 2), fmt.cell = "%s", breaks = 2)
    # })
    # 
    # output$markdown <- renderUI({
    #     HTML(markdown::markdownToHTML(knit('a.Rmd', quiet = TRUE)))
    # })
})
