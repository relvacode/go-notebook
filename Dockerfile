ARG GOPHERNOTES_VERSION=master
ARG BASE_NOTEBOOK=jupyter/base-notebook:latest

FROM golang:latest as builder
ARG GOPHERNOTES_VERSION

WORKDIR /clone

RUN git clone --single-branch -b ${GOPHERNOTES_VERSION} https://github.com/gopherdata/gophernotes .
RUN go build -o gophernotes .


FROM ${BASE_NOTEBOOK}

COPY --from=builder /clone/gophernotes /bin/
COPY --from=builder /clone/kernel/kernel.json kernel/logo* /usr/local/share/jupyter/kernels/go/
