FROM postgres:latest
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=testdb
COPY initdata/init.sql /docker-entrypoint-initdb.d/init.sql