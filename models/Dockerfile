FROM postgres:15-alpine
ENV POSTGRES_DB=postgres
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=password
COPY init.sql /docker-entrypoint-initdb.d/
