#!/usr/bin/Rscript


bus = readRDS('BUSBRA_pdata_w_attr.rds')
bus1 <- bus[, c(4, 13:100)]
bus1$Pathology <- c(0,1)[as.factor(bus1$Pathology)]
fmodel <- glm(Pathology ~ ., family = 'binomial', data=bus1)
pvals <- summary(fmodel)$coefficients
sig_attr <- names(which(pvals[,4]<0.05))
bus$Pathology <- c(0,1)[as.factor(bus$Pathology)]
bus1 <- bus[, c('ID', 'Pathology', sig_attr)]
bus1 <- bus1[, -3]
write.csv(bus1, file = 'BUSBRA_4_ml.csv', quote=FALSE, row.names=FALSE)
