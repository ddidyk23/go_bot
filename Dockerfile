FROM --platform=$BUILDPLATFORM quay.io/projectquay/golang:1.25 as builder

WORKDIR /go/src/app
COPY . .

ARG TARGETARCH

RUN go get

RUN make build TARGETARCH=$TARGETARCH


FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/go_bot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./go_bot", "start"]