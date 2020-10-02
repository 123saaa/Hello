library(caret)
library(rsample)
library(klaR)

nb.features
load(file = "/Users/wangyunxuan/Downloads/caddata (3).RData")
df=as.data.frame(cad.df.balanced)
#head(df)
#which( colnames(df)=="Cath" )
#n<-ncol(df)
#c(1:54)
#c(1:42,44:54)
set.seed(123)


train <- train.df[,c(predictors(nb.features),"Cath")]
test  <- test.df[,c(predictors(nb.features),"Cath")]


control <- trainControl(method="repeatedcv", number=10)
train_model<-train(Cath ~., data = train, method="nb", ,trControl=control)
train_model$results
pred=predict(train_model,test)

mean(pred== test$Cath)

