# Taller: primeros pasos en R

## Instalación de R y RStudio

En este taller utilizaremos R a través del IDE RStudio. ¿Qué es un IDE? IDE es el acrónimo de Integrated Development Environment, es decir, de un Entorno de Desarrollo Integrado. En palabras simples, se trata de un entorno que nos entrega herramientas para trabajar de manera más fácil con un determinado lenguaje de programación (en este caso, R). 

Para poder instalar R y RStudio, sigue los siguientes pasos:

- Descarga R desde https://cran.r-project.org/. Debes elegir la opción que corresponda según tu sistema operativo.
- Instala R en tu computador, tal como lo haces con cualquier programa. 
- Descarga RStudio desde https://www.rstudio.com/products/rstudio/download/. Elige la primera opción, es decir, "RStudio Desktop
Open Source License" (gratuita). 
- Instala RStudio en tu computador, tal como lo haces con cualquier programa. 

Si el quedó todo bien instalado, cuando abras RStudio deberías ver algo así:

![](https://github.com/rivaquiroga/RLadies-Santiago/blob/master/images/rstudio.png)

## Instalación de los paquetes de R que usaremos

Cuando instalamos R en nuestro computador queda lo que se conoce como R Base. 

En este taller usaremos con una serie de paquetes de R que nos permitirán expandir las posibilidades de R Base. Especficamente, trabajaremos con dos paquetes: `r tidyverse`

```r
install.packages("tidyverse")
install.packages("gapminder")
```
