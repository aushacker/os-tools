#!/usr/bin/awk -f
BEGIN {
        FS = ","
        OFS = ","
}
function extractData(ldata) {
        split(ldata, c, ",")
        if (section=="cpu") {
                pod[c[1]] = c[1]
                pod_cpu[c[1]] = c[2]
        }
        if (section=="mem") {
                pod[c[1]] = c[1]
                pod_mem[c[1]] = c[2]
        }
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
