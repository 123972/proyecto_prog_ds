# Programación para Ciencia de Datos 2019
## Proyecto final

### Integrantes
* Javier Valencia Goujon  
* Ángel Rafael   
* Diego Villa Lizárraga  
* Juan Pablo Herrera Musi

##Instalación
1. Abrir la máquina virtual de vagrant  
2. Navegar hasta la carpeta datos (dentro de la máquina virtual)  
`cd ../../data`
3. Clonar el repositorio
`git clone https://github.com/Pilo1961/proyecto_prog_ds`
4. Posicionarse en la carpeta raíz del repositorio
`cd proyecto_prog_ds`  
5. Ejecutar el archivo pipeline
`sh pipeline.sh`


### Inicializar una máquina virtual

### Clonar el repositorio

### Generar de la base de datos


### Conectarse a la base



### Crear tablas








## Descripción del trabajo  
Para el proyecto se genera una base de datos de postgreSQL usando los datos de Museum of Modern Art sobre aritstas y obras. Los datos originales están disponibles en el [repsotorio del MoMa](https://www.google.comhttps://github.com/MuseumofModernArt/collection).  
El trabajo consiste en un pipeline en el que, teniendo los datos en la ubicación indicada, se genera una base de datos, se cargan todos los registros de la base y se proponen los esquemas `raw`, `cleaned` y `semantic` para las tablas.
En el esquema `raw` se cargan los datos de las tablas a postgreSQL. Los datos de alimentan a la base en columnas tipo texto, no se hace ningún cambio.  
Teneiendo los datos en la base de datos se hace una limieza para dejar llevarlos a su forma `cleaned`. Este proceso consta de seleccionar las columnas relevantes para el análisis, imputar los datos en las columnas que requerien limpieza para su procesamiento.  
Finalmente, el esquema `semantic` propone las columnas finales antes........   

## Datos
El Museo de Arte Moderno (MoMA) lleva coleccionando obras de arte desde 1929. Cuenta con un registro de 81,866 obras de 26,377 artistas. El museo hizo pública la información para promover la investigación en el tema. LA información está disponible por medio del [repsotorio](https://www.google.comhttps://github.com/MuseumofModernArt/collection)  como 2 archivos `.csv`, uno para `artistas` y el otro para las `obras`.

### Esquema raw
Los datos se cargan a la base de datos `moma` tal cual se tienen en el archivo `.csv` de origen. Se generan dos tablas, una correspondiente al archivo de origen que contiene la información de los artistas y la otra correspondiente a las obras. A todas las columnas se les indica el tipo de dato `varchar`.   
En el esquema contamos 2 tablas:

Artists con 15,854 artistas.
* ConstituentID - Identificador único del artista.  
* DisplayName - Nombre del artista.
* ArtistBio - Incluye país de nacimiento, fecha de nacimiento y fehca de muerte. El país está dividido por `,` y las fechas por `-`. Hay algunos datos faltantes y aglunas observaciones sin información.  
* Nationality - Nacionalidad del artista.  
* Gender - Gernero del artista.  
* BeginDate - Fecha de nacimeinto.  
* EndDate - Fecha de muerte.  
* Wiki QID -  Identificador de artista en Wikipedia.
* ULAN - Identificador del artista de la unión Getty.  

Artworks con 138,125 observaciones.  
* Title - Título de la obra.  
* Artist - Nombre del artista o artistas, si hay mas de uno se separa por `,`.
* ConstituentID - Identificador de la tabla artistas. Si hay más de un artista se separa con `,`.
* ArtistBio - Incluye país de nacimiento, fecha de nacimiento y fecha de muerte. El país está dividido por `,` y las fechas por `-`. Hay algunos datos faltantes y aglúnas observaciones sin información.  
* Nationality - Nacionalidad del artista.   
* BeginDate - Fecha de (los) nacimeinto(s).  
* EndDate - Fecha de muerte de los artistas.  
* Gender - Gernero de los artistas.
* Medium - Técnica de la obra.
* Dimensions - Dimensiones de la obra.
* CreditLine - Procedencia de los fondos para adquirir la obra.
* AccesionNumber -
* Classification - Tipo de obra.
* Department - Tema de obra.
* DateAcquiered - Fecha de adquisisción.
* Cataloged - Indicador de si la obra está catalogada o no.
* ObjectID - Identificador del objeto.
* URL - Página de internet con información de la obra.
* ThumbnailURL - Página de internet con imagen de la obra.
*	Circumference (cm) - Medida de circunferencia en centímetros para obras circulares, nulo en otros casos.
*	Depth (cm)	- Profundidad de la obra en centímetros. Si no aplica se marca como nulo.
* Diameter (cm) - Diámetro de la obra en centímetros. Si no aplica se marca como nulo.
* Height (cm)	 - Altura de la obra en centimetros. Si no aplica se marca como nulo.
* Length (cm) - Largo de la obra en centímetros. Si no aplica se marca como nulo.
* Weight (kg) - Peso de la obra en kilogramos. Si no aplica se marca como nulo.
*	Width (cm) - Ancho de la obra en centímetros. Si no aplica se marca como nulo.
*	Seat Height (cm) - Altura del asiento de la obra en centímetros. Si no aplica se marca como nulo.
*	Duration (sec.) - Duración de la obra en segundos. Si no aplica se marca como nulo.

### Esquema cleaned
En esta fase se utiliza el script `to-cleaned.sql` para limpiar las tablas del esquema `raw`. Se revisan todas las columnas y se toman acciones de acuerdo a la información que contiene cada una de ellas.

Las tablas que se generan en el proceso de limpieza se describen a continuación:

Artists con 15,854 artistas.
* artist - Cambio de nombre de ConstituentID. Se asigna el tipo `int`.
* name
* nationality
* gender
* birth_year - Año de nacimiento del artista. Se asigna el tipo `int`.  
* death_year - Año de muerte del artista. Se asigna el tipo `int`.
* Wiki QID
* ULAN - Se asigna el tipo `int`.  

Se remueve la columna `ArtistBio` por tener información repetida en otras columnas de forma desordenada.
En las columnas que no tienen comentarios solamente se cambió el nombre de la columna.

La tabla `Artworks` queda de la siguiente manera.
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


Se quitan la columnas `Artist`, `ArtistBio`, `Nationality`, `BeginDate`, `EndDate`, `Gender`, `Dimensions` por tener información que corresponde a la tabla de artistas.
En las columnas que no tienen comentarios solamente se cambió el nombre de la columna.  
En la columna artist se enlistan todos los artistas que contribuyeron a una obra. Se hace por medio del número de artista separado de `,`. Como parte de la limpieza de la tabla se separa esa información en observaciones independientes, se genera una observación por artista.



### Esquema semantic


## Instalación
