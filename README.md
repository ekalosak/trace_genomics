# trace_genomics
Using yield and microbial abundance data, I explore what drives lettuce yield.

## Factors leading to variation
![Image](https://raw.githubusercontent.com/ekalosak/trace_genomics/master/exploratory_p1.png)

As depicted in `exploratory_p1.png` shown above, the innate health of the field
has an immediate effect on the lettuce yield. Crop type does not appear to have
an effect. Further statistical testing is required to determine whether indeed
these observations are significant.

### Model quality
![Image](https://raw.githubusercontent.com/ekalosak/trace_genomics/master/explanatory_quality_dt.png)

The complexity parameter appears to stabilize after 5 factors are included. With
more compute power, a deeper fit may provide a more extensive list of
potentially important species.

### Exracting factors from the model

After fitting a decision tree to the yield-linked OTU abundances, the driving
factor rankings are:
1. Field Health
2. Allochromatium vinosum
3. Amycolatopsis saalfeldensis
4. Bacillus litoralis
5. Curtobacterium
6. Halomonas ilicicola
7. Pseudomonas oryzae
8. Pseudomonas putida
9. Rhytidhysteron rufulum

As expected, the quality of the field is the main driver of yield. Whether the
observed field quality is itself driven by particular microbial compositions
requires further research. Additional analysis is required to determine the
directions of and significance of the subsequent microbial species effects on
yield.

### Future model improvements
1. Fit deep FF fully-connected autoencoder and extract niches/features from
   encoding nodes
2. Fit deeper decision tree
3. Fit random forest for higher predictive accuracy and lower variance
4. Perform statistical tests on features extracted from machine learning models
5. Test model overfit via holdout sets

## Literature on potential driving species

### Allochromatium vinosum
1. [phototropic sulfur bacterium, oxidizer](https://doi.org/10.1111/j.1365-2958.2006.05408.x)

### Pseudomonas oryzae
1. [slime producing pathogen](http://dx.doi.org/10.20546/ijcmas.2017.603.117)

## Yield prediction model
As an attempt at the holy grail of modern precision agronomics, I've build a
yield prediction model using a regression tree with an ANOVA split criterion.
The model is regretably simple, but it appears to perform moderately well, even
with a small number (10) of features.

![Image](https://raw.githubusercontent.com/ekalosak/trace_genomics/master/prediction_accuracy.png)
