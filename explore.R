# Author: Eric Kalosa-Kenyon
#
# Explore the metadata and otu data

## Load external libraries
library(ggplot2)

## Source local libraries
source("load_data.R")

## Plot in a few ways to see what's going on

# http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization
p1 = ggplot(mdf, aes(x=Field_Health, y=Yield, fill=Current_Crop)) +
    geom_bar(stat = "identity") +
    labs(title="Yeild as a function of field health and crop",
         x="Field health", y="Yield")
ggsave("exploratory_p1.png", p1)

# NOTE: by p1, appears that there is a field-health effect. subtract that and
    # normalize yield by within-group variances i.e. control for field health
    # NOTE: might be good to see whether microbes drive "Field_Health"

# fh = mdf$Yield[mdf$Field_Health == "Healthy"]
# fn = mdf$Yield[mdf$Field_Health == "Not_Healthy"]
# mdf$Norm_Yield[mdf$Field_Health == "Healthy"] = (fh - mean(fh))/sd(fh)
# mdf$Norm_Yield[mdf$Field_Health == "Not_Healthy"] = (fn - mean(fn))/sd(fn)

## Prepare OTU data for join with normalized yield
library(data.table)
rownames(odf) = odf[,1]
odf = odf[,-1]
todf = transpose(odf)
colnames(todf) = rownames(odf)
rownames(todf) = colnames(odf)
todf$sample_id = rownames(todf)

## Create main dataframe
df = merge(x = mdf, y = todf, by = "sample_id")
rownames(df) = df$sample_id
df = df[,-c(1,2)] # drop sample_id and Sampling_Date
df = df[]

## Create predictive model
library(randomForest)
f = Yield ~ .

## TODO: create explanatory model
library(rpart)

m = rpart(
               formula = f,
               data = df,
               method = "anova"
               )

# printcp(m) gives following ranking of factors:
# Field_Health, Allochromatium vinosum, Amycolatopsis saalfeldensis,
#   Bacillus litoralis, Curtobacterium, Halomonas ilicicola, etc.

# TODO: clean text in following plot to species name
# plot(m); text(m, srt=90) # messy text

png("explanatory_quality_dt.png")
plotcp(m)
dev.off()

df$pred_yield = predict(m, df)
p2 = ggplot(df, aes(Yield, pred_yield)) +
    geom_point() +
    labs(title="Model performance", x="Actual yield", y="Predicted yield")
ggsave("prediction_accuracy.png", p2)

# TODO: check to see that sparsity of explanatory variables is enforced in rpart

# TODO: See if there are any obvious culprits (e.g. Fusarium)
# from https://en.wikipedia.org/wiki/List_of_lettuce_diseases:
# Fungal
#   Xanthomonas campestris pv. vitians
#   Erwinia carotovora
#   Pseudomonas marginalis
#   Rhizomonas spp.
#   R. suberifaciens
#   Pseudomonas cichorii
#
# Bacterial
#   Alternaria sonchi
#   Microdochium panattonianum = Marssonina panattoniana
#   Rhizoctonia solani
#   Thanatephorus cucumeris [teleomorph]
#   Cercospora longissima
#   Pythium spp.
#   Pythium ultimum
#   Rhizoctonia solani
#   Bremia lactucae
#   Plasmopara lactucae-radicis
#   Sclerotinia sclerotiorum
#   Sclerotinia minor
#   Botrytis cinerea
#   Botryotinia fuckeliana [teleomorph]
#   Phymatotrichopsis omnivora = Phymatotrichum omnivorum
#   Erysiphe cichoracearum
#   Puccinia dioicae = Puccinia extensicola var. hieraciata
#   Septoria lactucae
#   Sclerotium rolfsii
#   Athelia rolfsii [teleomorph]
#   Stemphylium botryosum
#   Pleospora tarda [teleomorph]
#   Pythium tracheiphilum

# TODO:
# Split into train and test and validate
# Build models, report validation scores
#   Lasso, neuralnet, randomforest, mars

# library(neuralnet)
# library(lmer)

# TODO: determine any representative microbiome profiles
# TODO: determine whether there are any highly correlated microbes to field
# health
