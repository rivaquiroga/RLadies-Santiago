# Taller: primeros pasos en R
[Viernes 6 de abril de 2018]

A continuación encontrarás las indicaciones para instalar los programas y descargar los archivos necesarios para este taller.

## Instalación de R y RStudio

En este taller utilizaremos R a través del IDE RStudio. ¿Qué es un IDE? IDE es el acrónimo de *Integrated Development Environment*, es decir, un *Entorno de Desarrollo Integrado*. Esto quiere decir que RStudio es una aplicació que nos entrega herramientas para hacer más fácil el desarrollo de proyectos usando R.  

Para poder instalar R y RStudio, sigue los siguientes pasos:

- Descarga R desde https://cran.r-project.org/. Debes elegir la opción que corresponda según tu sistema operativo.
- Instala R en tu computador, tal como lo haces con cualquier programa. 
- Una vez que R ha quedado correctamente instalado, descarga RStudio desde https://www.rstudio.com/products/rstudio/download/. Elige la primera opción, es decir, "RStudio Desktop Open Source License" (gratuita). 
- Instala RStudio en tu computador, tal como lo haces con cualquier programa. 

Si quedó todo bien instalado, cuando abras RStudio deberías ver algo así:

![](https://github.com/rivaquiroga/RLadies-Santiago/blob/master/images/rstudio.png)

## Instalación de los paquetes de R que usaremos

Cuando instalamos R por primera vez en nuestro computador, lo que estamos instalando es lo que se conoce como "R Base", es decir, los elementos centrales del lenguaje de programación. Una de las ventajas de R es que se trata de un lenguaje extensible: la propia comunidad de usuarios puede desarrollar nuevas posibilidades para utilizarlo. La manera de compartir estos nuevos desarrollos es a través de "paquetes", que incluyen, entre otras cosas, código y datos.

En este taller usaremos tres paquetes: `gapminder`, `babynames` y `tidyverse`. `gapminder` y `babynames` son paquetes de datos que nos servirán para algunos de los ejercicios que realizaremos. `tidyverse`, por su parte, es un "megapaquete" que incluye otros paquetes en su interior. Todos los paquetes del Tidyverse comparten la misma visión sobre el trabajo con datos. Quizás ahora eso suene un poco enigmático, pero durante el taller explicaremos qué quiere decir. 

Vamos al grano: es importante que descargues esos paquetes antes del taller, porque no tenemos la posibilidad de ofrecer conexión a internet. Para instalarlos, 

1. copia el siguiente código

```r
install.packages("tidyverse")
install.packages("gapminder")
install.packages("babynames")
```

2. pégalo en RStudio

![](https://github.com/rivaquiroga/RLadies-Santiago/blob/master/images/install.packages.png)

3. y presiona 'enter'. El último paquete es un poco ms pesado que el resto, así que, dependiendo de tu conexión, podría tomar un minuto. El resultado se debería ver parecido a esto:

![](https://github.com/rivaquiroga/RLadies-Santiago/blob/master/images/paquetes_instalados.png)

## Descarga de otros archivos

Durante el taller, aprenderemos también a importar archivos y a unir planillas de datos. Para ello, descarga los siguientes archivos:

[Datos 2014](https://goo.gl/pNWbhd)

[Datos 2015](https://goo.gl/i5K8K9)

