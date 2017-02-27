# Major taxonomic groups in the GBIF Backbone
The GBIF Backbone contains [2,818,534 distinct, accepted species](http://www.gbif.org/species/search?q=&dataset_key=d7dddbf4-2cf0-4f39-9b2a-bb099caae36c&rank=SPECIES&status=ACCEPTED&status=DOUBTFUL) across all kingdoms. 
The major taxonomic groups in the GBIF Backbone Taxonomy exceeding 3% of all accepted species are shown in the following donut:

![](https://docs.google.com/spreadsheets/d/1AO9540DDHrw4YJcxAfORStqSCujcZUcOKD7gckSrvA0/pubchart?oid=43934897&format=image)

# Major taxonomic groups in GBIF Occurrences
The GBIF occurrence index contains over [712 million records](http://www.gbif.org/occurrence). 
When matched to the GBIF backbone these represent 1,226,520 distinct, accepted species - aproximately half of the backbone species. 
The distribution of the major taxonomic groups exceeding 3%, i.e 36.777 species, is shown in the next donut chart:

![](https://docs.google.com/spreadsheets/d/1AO9540DDHrw4YJcxAfORStqSCujcZUcOKD7gckSrvA0/pubchart?oid=388205109&format=image)

# Metrics source
The species counts have been calculated using a [hive query](occ-groups.hive.sql) (occurrence species) and a [python script](overview.py) (backbone species).
The charts are done in a [google spreadsheet](https://docs.google.com/spreadsheets/d/1AO9540DDHrw4YJcxAfORStqSCujcZUcOKD7gckSrvA0/pubhtml).