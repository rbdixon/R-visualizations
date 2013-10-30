# http://stackoverflow.com/questions/15826831/r-adding-a-datatable-to-a-ggplot-graph-using-viewports-scaling-the-grob
library(ggplot2)
library(reshape2)
library(grid)

# Create plot

df <- structure(list(City = structure(c(2L, 3L, 1L), .Label = c("Minneapolis", "Phoenix", "Raleigh"), class = "factor"), 
                     January = c(52.1, 40.5, 12.2),
                     February = c(55.1, 42.2, 16.5),
                     March = c(59.7, 49.2, 28.3),
                     April = c(67.7, 59.5, 45.1),
                     May = c(76.3, 67.4, 57.1),
                     June = c(84.6, 74.4, 66.9),
                     July = c(91.2, 77.5, 71.9),
                     August = c(89.1, 76.5, 70.2),
                     September = c(83.8, 70.6, 60),
                     October = c(72.2, 60.2, 50), 
                     November = c(59.8, 50, 32.4),
                     December = c(52.5, 41.2, 18.6)),
                .Names = c("City", "January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"), 
                class = "data.frame",
                row.names = c(NA, -3L))

dfm <- melt(df, variable = "month")

levels(dfm$month) <- month.abb
p <- ggplot(dfm, aes(month, value, group = City,
                     colour = City))
p1 <- p + geom_line(size = 1) + theme(legend.position = "top") + xlab("")

# Create data table
none <- element_blank()
data_table <- ggplot(dfm, aes(x = month, y = factor(City),
                              label = format(value, nsmall = 1), colour = City)) +
  geom_text(size = 3.5) +
  scale_y_discrete(labels = abbreviate) + theme_bw()  +
  theme(panel.grid.major = none, legend.position = "none",
        panel.border = none, axis.text.x = none,
        axis.ticks = none) + theme(plot.margin = unit(c(-0.5, 1, 0, 0.5), "lines")) + xlab(NULL) + ylab(NULL)

# Combine the two with viewport:
Layout <- grid.layout(nrow = 2, ncol = 1, heights = unit(c(2, 0.25), c("null", "null")))
grid.show.layout(Layout)
vplayout <- function(...) {
  grid.newpage()
  pushViewport(viewport(layout = Layout))
}

subplot <- function(x, y) viewport(layout.pos.row = x,
                                   layout.pos.col = y)

mmplot <- function(a, b) {
  vplayout()
  print(a, vp = subplot(1, 1))
  print(b, vp = subplot(2, 1))
}

png('plot_with_data_table.png', width=640, height=480)
mmplot(p1, data_table)
dev.off()