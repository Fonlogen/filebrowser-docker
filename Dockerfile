FROM alpine:3

LABEL maintainer="hurlenko" \
    org.label-schema.name="filebrowser" \
    org.label-schema.description="Web File Browser which can be used as a middleware or standalone app" \
    org.label-schema.url="https://github.com/hurlenko/filebrowser-docker" \
    org.label-schema.license="MIT" \
    org.label-schema.vcs-url="https://github.com/hurlenko/filebrowser-docker" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vendor="hurlenko" \
    org.label-schema.schema-version="1.0"

# Installa curl e scarica filebrowser direttamente (senza get.sh)
RUN apk add --no-cache curl \
    && curl -fsSL https://github.com/filebrowser/filebrowser/releases/latest/download/linux-amd64-filebrowser -o /filebrowser \
    && chmod +x /filebrowser \
    && apk del curl  # Rimuove curl per ridurre l'immagine finale

RUN mkdir -p -m 777 /config \
    && mkdir -p -m 777 /data

EXPOSE 4500

ENTRYPOINT ["/filebrowser"]
CMD ["--root=/data", "--address=0.0.0.0", "--database=/config/filebrowser.db"]
