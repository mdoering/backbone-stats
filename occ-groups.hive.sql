create table markus.occ_species as select count(distinct specieskey) as species, count(distinct taxonkey) as names, kingdom, phylum, class, order_, family, genus, kingdomkey, phylumkey, classkey, orderkey, familykey, genuskey 
 from prod_a.occurrence_hdfs 
 group by kingdom, phylum, class, order_, family, genus, kingdomkey, phylumkey, classkey, orderkey, familykey, genuskey;

set cutoff=select sum(species)*0.03 from markus.occ_species;
set cutoff=36800;

drop table markus.large_groups;
create table markus.large_groups as 
 SELECT 'kingdom' as rank, kingdom as name, kingdomkey as taxon_key, null as parent_key, sum(species) as species_cnt, sum(names) as names_cnt 
  from markus.occ_species 
  where kingdomkey is not null
  group by kingdom, kingdomkey

UNION ALL 
 SELECT 'phylum' as rank, phylum as name, phylumkey as taxon_key, kingdomkey as parent_key, sum(species) as species_cnt, sum(names) as names_cnt 
  from markus.occ_species 
  where phylumkey is not null
  group by phylum, phylumkey, kingdomkey
  having sum(species) > 36800

UNION ALL 
 SELECT 'class' as rank, class as name, classkey as taxon_key, phylumkey as parent_key, sum(species) as species_cnt, sum(names) as names_cnt 
  from markus.occ_species 
  where classkey is not null
  group by class, classkey, phylumkey
  having sum(species) > 36800

UNION ALL 
 SELECT 'order' as rank, order_ as name, orderkey as taxon_key, classkey as parent_key, sum(species) as species_cnt, sum(names) as names_cnt 
  from markus.occ_species 
  where orderkey is not null
  group by order_, orderkey, classkey
  having sum(species) > 36800

UNION ALL 
 SELECT 'family' as rank, family as name, familykey as taxon_key, orderkey as parent_key, sum(species) as species_cnt, sum(names) as names_cnt 
  from markus.occ_species 
  where familykey is not null
  group by family, familykey, orderkey
  having sum(species) > 36800

UNION ALL 
 SELECT 'genus' as rank, genus as name, genuskey as taxon_key, familykey as parent_key, sum(species) as species_cnt, sum(names) as names_cnt 
  from markus.occ_species 
  where genuskey is not null
  group by genus, genuskey, familykey
  having sum(species) > 36800
