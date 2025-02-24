FROM postgres:latest

RUN apt-get update && apt-get install -y cron gzip openssl

COPY backup.sh /usr/local/bin/backup.sh
RUN chmod 755 /usr/local/bin/backup.sh

ENTRYPOINT ["/usr/local/bin/backup.sh"]
