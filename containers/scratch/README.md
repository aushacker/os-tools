# Scratch Container Example

September 2025

Hello world in an OCI container built from scratch.

## Go

```bash
go build .
podman build -t scratch .
```

## C

```bash
sudo dnf install -y glibc-static

gcc -static hello.c -o hello

podman build -t scratch .
```