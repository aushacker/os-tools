#!/bin/bash

container=$(buildah from registry.access.redhat.com/ubi9/ubi-micro)
export container

cat <<- 'EOF' > buildah-script.sh
	#!/bin/bash
	mnt=$(buildah mount $container)
	buildah copy $container ./web-service-gin /bin
	buildah config --cmd "" --entrypoint '["web-service-gin"]' --port 8080 --user 1000 $container
EOF

chmod u+x buildah-script.sh
buildah unshare ./buildah-script.sh
buildah commit $container web-service-gin

rm buildah-script.sh
