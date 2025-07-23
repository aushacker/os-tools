#!/bin/bash
#
# Extract Pod info from a cluster.
#

# All non openshift Pods
for n in $(oc get projects --no-headers -o custom-columns=NAME:.metadata.name | grep -v "openshift-*"); do oc get po -n $n -o json; done > /tmp/pods.json

# Extract Helm chart names and versions
jq -r '.items[] | select(length > 0) | {ns: .metadata.namespace, name: .metadata.name, app: .metadata.labels.app, chart: .metadata.labels.chart} | select(.app!=null and .chart!=null) | [.ns, .name, .app, .chart] | @csv' /tmp/pods.json > /tmp/chart-versions.csv

# Remove unwanted values from pod name and version and dedupe (awk)
python3 chart1.py | awk '!seen[$0]++' > chart-versions.csv
