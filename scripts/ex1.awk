#!/usr/bin/awk -f
/^$/ {
        next
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
function myreport() {
        for (podname in pod) {
                if (podname!="") {
                        print namespace, podname, pod_cpu[podname], pod_mem[podname]
                }
        }
        delete pod
        delete pod_cpu
        delete pod_mem
}
BEGIN {
        OFS = ","
        section = ""
        print "namespace,pod name,average cpu,average memory"
}
$2 ~ /Namespace:/ {
        if (section!="") {
                myreport()
        }

        section = "ns"
        # awk is missing regex group collection, hack the namespace string up
        # rpt2/namespace.json
        split($3, a, "/")
        split(a[2], b, ".")
        namespace = b[1]
        next
}
$2 ~ /cpu/ {
        section = "cpu"
        next
}
section=="cpu" {
        extractData($1)
        next
}
$2 ~ /memory/ {
        section = "mem"
        next
}
section=="mem" {
        extractData($1)
        next
}
END {
        myreport()
}
