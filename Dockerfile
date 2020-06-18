FROM node:12
ENTRYPOINT ["/app/script.sh"]
COPY script.sh /app/