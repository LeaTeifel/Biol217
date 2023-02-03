library(readxl)
df <- read_excel("csrA-WT_sorted.xlsx", 
                             sheet = "Sheet4")
View(df)
 #how to make heatmap
ggplot(df, aes(x = seq_type, y = name, fill = log2FC)) + geom_tile() + scale_fill_distiller(palette = "Pastel1") +
ylab('Name') + xlab('Sequence type') + 
  ggtitle("Heatmap") + theme(plot.title = element_text(hjust = 0.5))


ggplot(df, aes(x = seq_type, y = name, fill = log2FC)) + geom_tile() + scale_fill_gradient( low = "blue", high = "yellow") + theme_linedraw() +
ylab('Name') + xlab('Sequence type') + 
                ggtitle("Heatmap") + theme(plot.title = element_text(hjust = 0.5))

#heatmap with more Data

library(readxl)
da <- read_excel("csrA-WT_sorted.xlsx", 
                 sheet = "Sheet5")    

#to gather data

da1 <- tidyr::gather(da,key = 'identifier', value = 'log2_fold')

library(data.table)

View(da1)
ggplot(da, aes(x = seq_type, y = identifier, fill = log2FC)) + geom_tile() + scale_fill_gradient( low = "blue", high = "yellow") + theme_linedraw() +
  theme(axis.text.y=element_blank()) + 
          ylab('Name') + xlab('Sequence type') + 
  ggtitle("Big Heatmap:)") + theme(plot.title = element_text(hjust = 0.5))