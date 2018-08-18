# trace_genomics
Beginnings of an analysis of which microbes hurt crop health

## Factors leading to variation
![Image](https://raw.githubusercontent.com/ekalosak/trace_genomics/master/exploratory_p1.png)

As depicted in `exploratory_p1.png` shown above, the innate health of the field
has an immediate effect on the lettuce yield. Crop type does not appear to have
an effect. Further statistical testing is required to determine whether indeed
these observations are significant.

After fitting a decision tree to the yield-linked OTU abundances, the driving
factor rankings are:
1. Field Health
2. Allochromatium vinosum
...1. Test
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
directions and significance of the effects on yield attributable to each of
the subsequent factors, each of which is a microbial species.

## Yield prediction model
As an attempt at the holy grail of modern precision agronomics, I've build a
yield prediction model using a random forest.
