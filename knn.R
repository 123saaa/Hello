rm(list=ls())
library(kknn)
load(file = "/Users/wangyunxuan/Downloads/caddata (1).RData")
df1 <- as.data.frame(lapply(cad.df, function(x) if(is.numeric(x)){
  scale(x, center=TRUE, scale=TRUE)
} else x))
n<-nrow(df1)
set.seed(123)
test.idx <- sample(1:n, size = floor(n*0.5))

pr = kknn(Cath~.,  df1[-test.idx,], df1[test.idx,],k = 30)
#lda.pred = predict(lda.model, df1[test.idx,])
pred <- lda.model$Cath
tb<-table(pred,df1[test.idx,])
table(pred = lda.pred,true = df1[test.idx,]$Cath)
mean(lda.pred== df1[test.idx,]$Cath)
