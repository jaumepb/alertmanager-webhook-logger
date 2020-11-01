ARG ALPINE_VERSION

FROM alpine:${ALPINE_VERSION}

RUN apk add -U --no-progress --no-cache --purge git go \
     # Create directory to hold LOGGS.
 && mkdir /logs \
 && chmod a+rw /logs

WORKDIR /tmp
RUN go get -u github.com/tomtom-international/alertmanager-webhook-logger
RUN cd /tmp/go/src/github.com/tomtom-international/alertmanager-webhook-logger
RUN go build
RUN mv /tmp/go/src/github.com/tomtom-international/alertmanager-webhook-logger/alertmanager-webhook-logger /usr/local/bin/
RUN rm -rf /tmp/go/

WORKDIR /logs

ENTRYPOINT ["/usr/local/bin/alertmanager-webhook-logger"]
CMD ["-h"]
