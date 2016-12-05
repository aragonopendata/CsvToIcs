# CsvToIcs

Aplicacion basica para transformar un CSV a un ICS usada para crear el dataset ubicado en 
> http://opendata.aragon.es/catalogo/calendario-de-festivos-en-comunidad-de-aragon-2017

Es una aplicacion muy basica que solo podria traducir los CSV con un formato determinado, pero se esta trabajando para poder transformar cualquier CSV a ICS en un futuro y permitir que no tengamos que tocar el codigo para poder leer dierentes CSV.
 
## Requisitos

Para hacer funcionar esta aplicacion necesitamos tener instalado dart en nuestro sistema, puede encontrar como hacerlo aqui:
>https://www.dartlang.org/install

## Como funciona

Para ejecutar el programa tendremos que ejecutar el comando
> pub global activate --source path <ruta del proyecto\>

con esto tendremos accesible el ejecutable desde la linea de comandos, ahora solo nos hace falta usar
> CsvToIcs

el cual generara los ICS con los datos que le pasemos en el main.