#!/bin/sh


#----------------------------
#crea un ambiente virtual
#----------------------------
pyenv virtualenv 3.7.3 moma
echo 'moma-ve' > .python-version

pip install --upgrade pip
#----------------------------
#instala poetry
#----------------------------
pip install poetry


#----------------------------
#llama al toml
#----------------------------
poetry install
#poetry install --extras
pip install psycopg2
pip install click
pip install dynaconf
