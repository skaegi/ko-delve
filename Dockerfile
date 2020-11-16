FROM golang:1.15 AS builder
ARG DLV_VERSION=v1.5.0
RUN git clone --branch ${DLV_VERSION} --depth=1  https://github.com/go-delve/delve /go/src/github.com/go-delve/delve && \
    go install -ldflags '-linkmode "external" -extldflags "-fno-PIC -static"' -buildmode pie -tags 'osusergo netgo static_build' github.com/go-delve/delve/cmd/dlv

FROM alpine:latest
COPY --from=builder /go/bin/dlv /usr/bin/
ENTRYPOINT ["/usr/bin/dlv"]