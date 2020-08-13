
library(naivebayes)
rm(list=ls())
load(file = "/Users/wangyunxuan/Downloads/caddata (1).RData")
df1 <- as.data.frame(lapply(cad.df, function(x) if(is.numeric(x)){
  scale(x, center=TRUE, scale=TRUE)
} else x))

set.seed(123)
test.idx <- sample.int(n = nrow(df1), size = floor(0.30*nrow(df1)), replace = F)

lda.model = naive_bayes(Cath~., data = df1[-test.idx,])
lda.pred = predict(lda.model, df1[test.idx,])


table(pred = lda.pred,true = df1[test.idx,]$Cath)
mean(lda.pred== df1[test.idx,]$Cath)
