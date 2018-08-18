# Author: Eric Kalosa-Kenyon
#
# Explore the metadata and otu data

## Load external libraries
library(ggplot2)

## Source local libraries
source("load_data.R")

## TODO: Plot in a few ways to see what's going on

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
# library(randomForest)
# library(lmer)

# TODO: determine any representative microbiome profiles
