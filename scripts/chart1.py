#
# Found it easier to use Python regexes to remove unwanted details from pod name and version columns.
#
import re
import csv

with open("/tmp/chart-versions.csv") as csvfile:
    versions = csv.reader(csvfile)
    podNameRe = re.compile("(?P<name>.*?)(?P<rs>-[a-f0-9]{9,10})?(?P<id>-[a-z0-9]{5})?")
    for row in versions:
        # remove unwanted values like ReplicaSet id and random pod id
        m = podNameRe.fullmatch(row[1])
        podName = m.group('name')

        # Remove chart name from version
        versionRe = "(?P<app>" + row[2] + "-)?(?P<version>.*?)"
        m2 = re.fullmatch(versionRe, row[3])
        version = m2.group('version')

        # Cleaned up CSV
        print('{0},{1},{2},{3}'.format(row[0], podName, row[2], version))
