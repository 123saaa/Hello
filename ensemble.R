library(caret)
library(ranger)
library(SuperLearner)
load(file = "Models/RF.RData")
load(file = "Models/NB.RData")
load(file = "Models/LR.RData")

bagging_results<-resamples(list(nb=NB_model,rf=RF_model,lr=LR_model))
summary(bagging_results)
set.seed(150)
#listWrappers()
if(is.factor(colnames(train.df)=="Cath")){as.numeric(colnames(train.df)=="Cath")}
colnames(train.df)=="Cath"
#which(colnames(train.df)=="Cath")
model <- SuperLearner(y=train.df[,43],
                      x=train.df[,1:42],
                      family=binomial(),
                      SL.library=list("SL.bayesglm" ,
                                      "SL.svm",
                                      "SL.ranger"))

fdata=cbind(RF_model,NB_model,LR_model,target=train.df$Cath)
names(fdata)=c("rf","nb","lr","target")
correlation<-cor(fdata[-4])
logistic<-glm(target~.,data=fdata,family = "binomial")
summary(logistic)$coefficient
x<-data.frame(summary(logistic)$coefficient)

#
x$variables=row.names(x)
x=x[c("variables","Estimate")][-1,]

x$weight=abs(x$weight)
x$weight=x$Estimate/sum(x$Estimate)
fdata$EnsemblePres=(x$weight[1]*fdata$rf)+(x$weight[2]*fdata$nb)+(x$weight[3]*fdata$lr)


