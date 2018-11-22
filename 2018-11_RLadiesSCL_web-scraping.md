# Taller sobre web scraping


Como no tenemos posibilidad de ofrecer acceso a internet para este taller, es necesario que descargues los paquetes y los datos que utilizaremos con antelación. En caso de que estudies/trabajes en una institución que tenga red "eduroam", entonces no deberías tener problemas para conectarte.


## Paquetes necesarios

``` r
install.packages("tidyverse")
install.packages("rvest")
install.packages("janitor")
``` 

## Guardar los datos en tu computador

El único momento en que utilizaremos internet en el taller es para leer la información del html de las páginas que "escrapearemos". Si crees que no podrás conectarte, entonces es necesario que guardes esa información como un archivo local en tu computador. Para ello, sigue los siguientes pasos.

### 1. Crea un proyecto nuevo

En el menú File > New Project > New Directory. Crea la carpeta en un lugar que te sea fácil encontrar durante el taller. 

### 2. Lee y guarda localmente los datos

Una vez que el proyecto esté creado, crea un nuevo _script_: File > New File > R Script. Luego, ejecuta el siguiente código. Requiere que ya esté instalado el paquete `rvest`.

```r
library(rvest)

## EJERCICIO 1: asesorías externas diputados

# leer los datos:

asesorias_html <- read_html("https://www.camara.cl/camara/transparencia_asesorias.aspx") 

#guardar los datos en un archivo:

write_html(asesorias_html, "asesorias")

## EJERCICIO 2: reuniones lobby senadores

# leer los datos:

reuniones_html <- read_html("http://www.senado.cl/appsenado/index.php?mo=lobby&ac=GetReuniones")

#guardar los datos en un archivo

write_html(asesorias_html, "reuniones")
```

Listo. En la carpeta de tu proyecto deberías ver estos dos objetos que recién creaste. 
¡Nos vemos en el taller!