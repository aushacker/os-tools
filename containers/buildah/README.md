# UBI 8 Micro Builder
Aushacker </br>
December 2023

## Notes

```
podman build -t microbuildah -f Containerfile-buildah

podman run -it --rm --name micro --cap-add=cap_setgid --cap-add=cap_setuid -e PACKAGES='bind-utils httpd' microbuildah
```
