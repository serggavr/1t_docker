FROM postgres:latest
ENV POSTGRES_PASSWORD=secret
ENV POSTGRES_DB=database
COPY db/init.sql /docker-entrypoint-initdb.d/init.sql