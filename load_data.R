# Author: Eric Kalosa-Kenyon
#
# Explore the metadata and otu data
# The data is 160 samples, 10 categorical/ordinal X, 1 integer Y

### BEGIN CODE
## Define constants
mdfn = "data_challenge-metadata.csv"
ohfn = "data_challenge-otu_hits.csv"

## Load data
mddf = read.csv(mdfn)
# odf = read.csv(ohfn)

# dim(mddf) = 160 11, 160 samples by 11 variables
# dim(odf) = 8154 161, 8154 OTU by 1 Taxon. ID and 160 samples

## Setup dataframes
mddf$sample_id = as.factor(mddf$sample_id)
mddf$soil_depth = as.factor(mddf$soil_depth)
mddf$land_performance = as.factor(mddf$land_performance)
mddf$current_crop = as.factor(mddf$current_crop)
mddf$production_type = as.factor(mddf$production_type)
mddf$sampling_date = as.POSIXct(
                                mddf$sampling_date,
                                tz = "",
                                format = "%d/%m/%Y"
                                )
cn = colnames(mddf)
colnames(mddf)[length(cn)] = "yield" # yield...boxes.of.24.heads.of.... is unweildy

# NOTE: odf colnames are samples, rows are representative percentages of each
#   OTU i.e. sum(odf[,i]) == 100 for all i > 1 (i==1 is taxon ID)
# NOTE: No absolute dosage information can be derived hereby

# NOTE: any(is.na(odf)) == False so no need to clean odf
# NOTE: Better to not fill NA in mddf: too few representatives for potential
# classes e.g. low soil depth => EBLUP is unstable even with REML

# FUNCTION trim whitespace
# Thanks "f3lix" at
# https://stackoverflow.com/questions/2261079/how-to-trim-leading-and-trailing-whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

# FUNCTION split the subfield_name up
sp = function(x){
    # Thanks "juba" at
    # https://stackoverflow.com/questions/15573887/split-string-with-regex
    # with modifications

    # split.pos <- gregexpr('[0-9]+',x)[[1]]
    split.pos <- gregexpr(' ',x)[[1]]
    split.length <- attr(split.pos, "match.length")
    split.start <- sort(c(1, split.pos, split.pos+split.length))
    split.end <- c(split.start[-1]-1, nchar(x))
    substrs = substring(x, split.start, split.end)
    return(substrs)
}

# Extract the field label and the health quality
c1 = c()
c2 = c()
for(sn in mddf$subfield_name){
    r = trim(sp(sn))
    c1 = c(c1, r[3])
    c2 = c(c2, r[5])
}
mddf$field_health = as.factor(c2)
mddf$field_label = as.factor(c1)

# clean rows (i.e. drop NA) for mddf
# NOTE: previous_crop and planting_date have too few obsv to be useful
#   extraction_date might be useful... but for now drop it
#   the rest have a single level and therefore add no predictive/explan. value
drop_cols = c(
              which(colnames(mddf) == "previous_crop"),
              which(colnames(mddf) == "planting_date"),
              which(colnames(mddf) == "extraction_date"),
              which(colnames(mddf) == "subfield_name"),
              which(colnames(mddf) == "land_performance"),
              which(colnames(mddf) == "production_type"),
              which(colnames(mddf) == "soil_depth")
              )
mdf = mddf[, -drop_cols]

# drop the rows that aren't "healthy" or "not healthy"
# the "e" in the field name is in field_label column
mdf = droplevels(
    mdf[ -which((mdf$field_health != "healthy" &
                mdf$field_health != "not" ) |
                is.na(mdf$field_health)), ]
    )

# # Thanks "Aaron" at
# # https://stackoverflow.com/questions/19410108/cleaning-up-factor-levels-collapsing-multiple-levels-labels
# levels(mdf$field_health) <- list(
#         Healthy=c("healthy", "e healthy", "w healthy"),
#         NotHealthy=c("not healthy", "e not healthy", "w not healthy")
#         )

levels(mdf$current_crop) = list(
                                Romaine=c("lettuce_romaine"),
                                Iceberg=c("lettuce_iceburg")
                                )

levels(mdf$field_health) = list(
                                Healthy=c("healthy"),
                                Not_Healthy=c("not")
                                )

colnames(mdf) = c("sample_id", "Sampling_Date", "Current_Crop", "Yield",
                  "Field_Health", "Field_Label")
