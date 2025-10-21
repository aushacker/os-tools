# Slow Network Configuration

aushacker
June 2024

With oc-mirror 4.15 some problems were encountered when repeating
the mirror-to-disk process on a workstation with a slow internet connection.

The symptoms were that the oc-mirror command would run for 5 minutes or so
and then fail with a 401 authentication error.

Breaking the imageset-config.yaml seems to solve the problem.
