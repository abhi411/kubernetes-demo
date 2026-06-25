FROM postgres:15-alpine
ENV POSTGRES_DB=demo
COPY init.sql /docker-entrypoint-initdb.d/
