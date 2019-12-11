#!/bin/sh

#----------------------------
#descarga los datos
#----------------------------
wget -O /data/proyecto_prog_ds/data/Artists.csv "https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artists.csv"
wget -O /data/proyecto_prog_ds/data/Artworks.csv "https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artworks.csv"

#----------------------------
#crea el rol moma
#----------------------------
sudo -i -u postgres psql -c "CREATE USER moma WITH PASSWORD '1';"
echo "usuario moma creado con password 1"

#----------------------------
#crea la base de datos
#----------------------------
sudo -i -u postgres psql -c "CREATE DATABASE moma WITH OWNER moma;"
echo "database moma creado"

#----------------------------
#crea un ambiente virtual
#----------------------------
chmod u+x virtualenv.sh
./virtualenv.sh

#----------------------------
#llama funciones
#----------------------------
python moma.py create-schemas
python moma.py create-raw-tables
python moma.py load-moma
python moma.py to-cleaned
