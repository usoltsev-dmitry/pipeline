FROM golang:latest AS compiling_stage
RUN mkdir -p /pipeline_repo/src
WORKDIR /pipeline_repo/src
ADD main.go .
ADD go.mod .
RUN go install .
 
FROM alpine:latest
LABEL version="1.0.0"
LABEL maintainer="Usoltsev Dmitry<solstev@gmail.com>"
WORKDIR /root/
COPY --from=compiling_stage /pipeline_repo/bin .
ENTRYPOINT /pipeline_repo/bin 
