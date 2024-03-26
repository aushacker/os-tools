#!/usr/bin/awk -f
#
# Component of all-pvcs. Converts storage size in k8s quantity
# format to numeric bytes.
# E.g. 6ki -> 6144
#
# aushacker
# March 2024
# 
BEGIN {
        FS = ","
        OFS = ","
}
# Match headings and append
$1 ~ /Namespace/ {
        print $0, "Bytes"
        next
}
# Convert SI units to byte counts
$5 ~ /k$/ {
        count = substr($5, 1, (length($5) - 1))
        print $0, count * 1000
}
$5 ~ /ki$/ {
        count = substr($5, 1, (length($5) - 2))
        print $0, count * 1024
}
$5 ~ /M$/ {
        count = substr($5, 1, (length($5) - 1))
        print $0, count * 1000000
}
$5 ~ /Mi$/ {
        count = substr($5, 1, (length($5) - 2))
        print $0, count * 1048576
}
$5 ~ /G$/ {
        count = substr($5, 1, (length($5) - 1))
        print $0, count * 1000000000
}
$5 ~ /Gi$/ {
        count = substr($5, 1, (length($5) - 2))
        print $0, count * 1073741824
}
