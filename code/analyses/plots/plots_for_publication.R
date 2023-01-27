# dependencies 
library(readr)
library(metafor)

# get data
setwd("~/git/independence-of-irap-trial-types/code/analyses/plots/")
#fit_1 <- read_rds("fit_1.rds")
data_es_1 <- read_csv("../../../data/processed/data_effect_sizes.csv")
load("fit.Rdata")


# caterpillar plot

pdf(NULL)
dev.control(displaylist = "enable")

metafor::forest(data_es_1$yi, 
                data_es_1$vi,
                #xlim = c(-0.5, 1.5), # adjust horizontal plot region limits
                transf = transf.ztor,
                xlab = expression(paste("Pearson's ", italic("r"))),
                at = c(-1, -0.50, 0, 0.5, 1),
                #at = c(-1, -0.75, -0.50, -0.25, 0, 0.25, 0.5, 0.75, 1),
                #at = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0),
                order = "obs", # order by size of yi
                slab = NA, 
                annotate = FALSE, # remove study labels and annotations
                efac = 0, # remove vertical bars at end of CIs
                pch = 19, # changing point symbol to filled circle
                col = "gray40", # change color of points/CIs
                psize = 2, # increase point size
                cex.lab = 1, cex.axis = 1, # increase size of x-axis title/labels
                lty = c("solid", "blank")) # remove horizontal line at top of plot
points(sort(transf.ztor(data_es_1$yi)), 
       nrow(data_es_1):1, pch = 19, cex = 0.5) # draw points one more time to make them easier to see
addpoly(fit, mlab = "", cex = 1, addcred = TRUE) # add summary polygon at bottom and text
#text(0, -1, "RE Model", pos = 4, offset = 0, cex = 1)

p1 <- recordPlot()
invisible(dev.off())

pdf("p_caterpillar.pdf",
    width = 9, 
    height = 6)
p1
dev.off()


