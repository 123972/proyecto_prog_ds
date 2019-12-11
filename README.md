# Programación para Ciencia de Datos 2019
## Proyecto final

### Integrantes
* Javier Valencia Goujon  - 123227
* Ángel Rafael Ortega Ramirez - 123972
* Diego Villa Lizárraga - 191343
* Juan Pablo Herrera Musi -108353

## Descripción del trabajo  
Para el proyecto se genera una base de datos de postgreSQL usando los datos de Museum of Modern Art sobre aritstas y obras. Los datos originales están disponibles en el [repsotorio del MoMa](https://www.google.comhttps://github.com/MuseumofModernArt/collection).  
El trabajo consiste en un pipeline en el que, teniendo los datos en la ubicación indicada, se genera una base de datos, se cargan todos los registros de la base y se proponen los esquemas `raw`, `cleaned` y `semantic` para las tablas.
En el esquema `raw` se cargan los datos de las tablas a postgreSQL. Los datos de alimentan a la base en columnas tipo texto, no se hace ningún cambio.  
Teneiendo los datos en la base de datos se hace una limieza para dejar llevarlos a su forma `cleaned`. Este proceso consta de seleccionar las columnas relevantes para el análisis, imputar los datos en las columnas que requerien limpieza para su procesamiento.  
Finalmente, el esquema `semantic` propone las columnas finales antes........   

## Instalación
1. Abrir la máquina virtual de vagrant destinada al curso.
2. Navegar hasta la carpeta datos (dentro de la máquina virtual)  
```
cd ../../data
```

3. Clonar el repositorio
```
git clone https://github.com/Pilo1961/proyecto_prog_ds
```
4. Posicionarse en la carpeta raíz del repositorio
```
cd proyecto_prog_ds
```
Nota: Si no tiene permisos dados por el administrador de la máquina virtual tendrá que clonar el repositorio desde la máquina local en la carpeta compartida entre la máquina local y la virtual y volver a la ejecución en el directorio indicado dentro de la máquina virtual.
5. Ejecutar el archivo pipeline
```
sh pipeline.sh
 ```

El pipeline ejecuta la siguiente secuencia:
* Descarga los datos.
* Crea el usuario y la base de datos.
* Crea un ambiente virtual e instala las dependencias necesarias.
* Corre los scripts de SQL que generan:  
  * Los esquemas,
  * Las tablas,
  * Carga los datos,
  * Genera las tablas de cada esquema.

## Conexión
Una vez instalada la base de datos el usuario se puede conectar usando el usuario postgres:
```
sudo su postgreSQL
```
Desde ese usuario llamamos al cliente a conectarse a la base que se acaba de crear.
```
psql -h 0.0.0.0 -U moma -d moma -W
 ```
Este comando requerirá escribir el password dentro de la terminal. La contraseña requerida para el usuario es `1`. Una vez conectados a la base de datos utilizando el cliente `psql` podremos navegar utilizando los funciones de `SQL` para hacer consultas sobre las tablas, los esquemas y los regitros.

## Datos
El Museo de Arte Moderno ([MoMA](https://www.moma.org/)) lleva coleccionando obras de arte desde 1929. Cuenta con un registro de 81,866 obras de 26,377 artistas. El museo hizo pública la información [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3558822.svg)](https://doi.org/10.5281/zenodo.3558822) para promover la investigación en el tema. La información está disponible por medio del [repsotorio](https://www.google.comhttps://github.com/MuseumofModernArt/collection)  como 2 archivos `.csv`, uno para `artistas` y el otro para las `obras`.

### Esquema raw
En este esquema los datos se cargan a la base de datos MoMA tal cual se tienen en el archivo `.csv` de origen. Se generan dos tablas, una correspondiente al archivo de origen que contiene la información de los artistas y la otra correspondiente a las obras. A todas las columnas se les indica el tipo de dato `varchar`.   
En el esquema contamos 2 tablas:

Artists con 15,790 artistas.
* ConstituentID - Identificador único del artista.  
* DisplayName - Nombre del artista.
* ArtistBio - Incluye país de nacimiento, fecha de nacimiento y fecha de muerte. El país está dividido por `,` y las fechas por `-`. Hay algunos datos faltantes y aglunas observaciones sin información.  
* Nationality - Nacionalidad del artista.  
* Gender - Gernero del artista.  
* BeginDate - Fecha de nacimeinto.  
* EndDate - Fecha de muerte.  
* Wiki QID -  Identificador de artista en Wikipedia.
* ULAN - Identificador del artista de la unión Getty.  

Artworks con 138,025 observaciones.  
* Title - Título de la obra.  
* Artist - Nombre del artista o artistas, si hay mas de uno se separa por `,`.
* ConstituentID - Identificador de la tabla artistas. Si hay más de un artista se separa con `,`.
* ArtistBio - Incluye país de nacimiento, fecha de nacimiento y fecha de muerte. El país está dividido por `,` y las fechas por `-`. Hay algunos datos faltantes y aglunas observaciones sin información.  
* Nationality - Nacionalidad del artista.   
* BeginDate - Fecha de (los) nacimeinto(s).  
* EndDate - Fecha de muerte de los artistas.  
* Gender - Genero de los artistas.
* Medium - Técnica de la obra.
* Dimensions - Dimensiones de la obra.
* CreditLine - Procedencia de los fondos para adquirir la obra.
* AccesionNumber -
* Classification - Tipo de obra.
* Department - Tema de obra.
* DateAcquiered - Fecha de adquisición.
* Cataloged - Indicador de si la obra está catalogada o no.
* ObjectID - Identificador del objeto.
* URL - Página de internet con información de la obra.
* ThumbnailURL - Página de internet con imagen de la obra.
*	Circumference (cm) - Medida de circunferencia en centímetros para obras circulares, nulo en otros casos.
*	Depth (cm)	- Profundidad de la obra en centímetros. Si no aplica se marca como nulo.
* Diameter (cm) - Diámetro de la obra en centímetros. Si no aplica se marca como nulo.
* Height (cm)	 - Altura de la obra en centímetros. Si no aplica se marca como nulo.
* Length (cm) - Largo de la obra en centímetros. Si no aplica se marca como nulo.
* Weight (kg) - Peso de la obra en kilogramos. Si no aplica se marca como nulo.
*	Width (cm) - Ancho de la obra en centímetros. Si no aplica se marca como nulo.
*	Seat Height (cm) - Altura del asiento de la obra en centímetros. Si no aplica se marca como nulo.
*	Duration (sec.) - Duración de la obra en segundos. Si no aplica se marca como nulo.

### Esquema cleaned
En esta fase se utiliza el script `to-cleaned.sql` para limpiar las tablas del esquema `raw`. Se revisan todas las columnas y se toman acciones de acuerdo a la información que contiene cada una de ellas.

En la tabla Artists se elimina la colima `Artist_Bio` que contiene información que tenemos en otras columnas.

La tabla Artists queda con 15,790 artistas.
* artist - Cambio de nombre de ConstituentID. Se asigna el tipo `int`.
* name
* nationality
* gender
* birth_year - Año de nacimiento del artista. Se asigna el tipo `int`.  
* death_year - Año de muerte del artista. Se asigna el tipo `int`.
* Wiki QID
* ULAN - Se asigna el tipo `int`.  

Para la tabla Artworks
Se remueve la columna `ArtistBio` por tener información repetida en otras columnas de forma desordenada.
En la tabla `Artworks` se realizan los siguientes cambios:  
* Se eliminan las columnas `Artist`, `ArtistBio`, `Nationality`, `BeginDate`, `EndDate`, `Gender`, `Dimensions` de la tabla `Artworks` por considerarse información repetida en ambas tablas y pertenecer a información de artistas.  
* En la columna artist de la tabla `raw` se enlistan todos los artistas que contribuyeron a una obra (puede ser mas de uno). Como parte de la limpieza de la tabla se separa esa información en observaciones independientes, se genera una observación por artista por obra.
* La columna `date_acquired` se limpia y se pone en formato fecha.
* La columna catalogued se usa con tipos de datos `booleano`. Se imputa `1` para `yes` y `0` para `no`
* La columna `date` se toma como `int` y se conserva solamente el año.

La tabla `Artworks` queda con 152,392 registros con las siguiente columnas.
* title - Título de la obra.  
* artist - Se renombra la columna ConstituentID y se le asigna el tipo `int`.
* medium  
* creditline
* accesion_id
* classification
* department
* date_acquired
* cataloged - Se define como tipo booleano y se imputan los valores 0 y 1 para sustituir "N" y "Y" respectivamente.
* artwork - Se renombra la columna `ObjectID` y se asigna el timpo `int`.
* url
* thumbnailurl
*	circumference_cm
*	depth_cm
* diameter_cm
* height_cm
* length_cm
* weight_cm
*	width_cm
*	seat_height_cm
*	duration_sec

En las columnas que no tienen comentarios solamente cambió el nombre de la columna.  

Las dos tablas se unen por medio de la columna artist, en ambos casos la columna es un identificador único para el artista y liga a las dos tablas. Para cada entrada en la tabla Artists hay uno o más en la tabla Artworks.

### Esquema semantic
