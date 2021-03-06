sudo -u postgres psql -c "CREATE ROLE $PG_USER PASSWORD '$PG_PASSWORD' LOGIN"
sudo -u postgres createdb -O $PG_USER $PG_USER
sudo -u postgres psql -d $PG_USER -c 'CREATE EXTENSION IF NOT EXISTS "pgcrypto"'

sudo PGPASSWORD=$PG_PASSWORD psql -U $PG_USER -d $PG_USER -f ./db/001-setup.sql
sudo PGPASSWORD=$PG_PASSWORD psql -U $PG_USER -d $PG_USER -f ./db/002-addinstallations.sql -v installationName="'$1'" -v responderPhone="'$2'" -v fallbackPhone="'$3'"
sudo PGPASSWORD=$PG_PASSWORD psql -U $PG_USER -d $PG_USER -f ./db/003-setinstallationconstraints.sql
