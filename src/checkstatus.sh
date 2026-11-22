
#!/bin/sh

echo "Waiting for PostgreSQL database..."

until pg_isready -h postgres -p 5432 -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
    echo "PostgreSQL is not ready. Checking again in 2 seconds..."
    sleep 2
done

echo "PostgreSQL database is ready!"
