#!/bin/bash
# Waits for SQL Server in the container to be ready, then creates the POC database.
# Run this once after `docker compose up -d`.

set -e

CONTAINER=sql-poc
SA_PASSWORD="LiquibasePOC!2026"

echo "Waiting for SQL Server to start..."
for i in {1..30}; do
  if docker exec "$CONTAINER" /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "SELECT 1" > /dev/null 2>&1; then
    echo "SQL Server is up."
    break
  fi
  sleep 2
done

echo "Creating LiquiBasePOC database..."
docker exec "$CONTAINER" /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "CREATE DATABASE LiquiBasePOC;"

echo "Done. Connect with:"
echo "  jdbc:sqlserver://localhost;databaseName=LiquiBasePOC;encrypt=true;trustServerCertificate=true"
echo "  username: sa"
echo "  password: $SA_PASSWORD"
