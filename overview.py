import json
import urllib2


API = "http://api.gbif-uat.org/v1/species/"
CUTOFF_PERCENT = 0.03
CHILD_LIMIT=100

groups = []
total=0
cutoff=0

class Usage:
    """A name usage with metrics"""
    key = -1
    rank = ""
    name = ""
    species = -1

    def __init__(self, usageJson=None, key=None, name=None, species=None):
        if key and not usageJson:
            usageJson = json.load(urllib2.urlopen('{}{}'.format(API, key)))
        if usageJson:
            self.key = usageJson['key']
            self.rank = usageJson['rank']
            self.name = usageJson['scientificName']
            self.species = json.load(urllib2.urlopen('{}{}/metrics'.format(API, self.key)))['numSpecies']
        else:
            self.name  = name
            self.species = species

    def __str__(self):
        return '{}:{} {}({})'.format(self.key, self.rank, self.name, self.species)

    def children(self):
        return [Usage(c) for c in json.load(urllib2.urlopen('{}{}/children?limit={}'.format(API, self.key, CHILD_LIMIT)))['results']]

    def data(self):
        return '{}\t{}'.format(self.name, self.species)


def walk(u):
    print('Walking {}'.format(u))
    # make sure accepted and above cutoff
    descended=False
    subgroupSize = 0
    if (u.species > cutoff):
        for c in u.children():
            if c.species > cutoff:
                descended=True
                subgroupSize += walk(c)
    if not descended:
        print('Adding {}'.format(u))
        groups.append(u)
        return u.species
    else:
        # add "Other" entry in case we had subranks
        groups.append(Usage(name="Other "+u.name, species=u.species-subgroupSize))
        return u.species

# add root kingdoms
kingdoms=[Usage(key=kid) for kid in range(1,8)]

# update total & cutoff
total = sum([k.species for k in kingdoms])
cutoff = total * CUTOFF_PERCENT
print('TOTAL={}, CUTOFF={}'.format(total, cutoff))

# now walk each kingdom
for k in kingdoms:
    walk(k)

for g in groups:
    print(g.data())

