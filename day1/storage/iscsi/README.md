# iSCSI Change in 4.18+

Aushacker
September 2025

## Overview

In OCP 4.18+ the iSCSI initiator name is not configured by default.

See https://docs.redhat.com/en/documentation/openshift_container_platform/4.18/html/release_notes/ocp-4-18-release-notes#ocp-4-18-rhcos-iscsi-initiator_release-notes

Apply one or both of these MachineConfigs to configure the iSCSI initiator name. Note, these are workarounds and may
strictly not be required.
