# R-Ladies Santiago + ICP
# Sesión 1: Análisis de discursos políticos Latinoamericanos
# Riva Quroga (@rivaquiroga)

# NOTA: Lo que haremos en esta sesión supone un manejo básico de R y RStudio. Puedes revisar el siguiente tutorial introductorio si aún no están tan familiarizada con este lenguaje de programación: http://bit.ly/tutorial-intro-R. En él se aborda el proceso de instalación y algunas funciones básicas. 

#Si no los tienes ya, instala los siguientes paquetes:
# install.packages("readtext")
# install.packages("quanteda")
# install.packages("tidyverse") # o al menos `dplyr`, `ggplot2` y `readr`

# 1. Cargar los paquetes

library(readtext) # para importar los archivos de texto
library(quanteda) # para hacer el análisis
library(dplyr) # funciones para manipular datos + %>% 
library(ggplot2) # para editar los gráficos que por defecto entrega quanteda
library(readr) # para exportar las búsquedas de concordancias
# También puedes cargar todo el Tidyverse: library(tidyverse)


# 2. Crear un proyecto

# Para hacer el trabajo más eficiente, trabajaremos en un "proyecto" de RStudio. Para eso, debes ir a File > New Project > Existing Directory, y eliges la carpeta en que guardaste los materiales de esta sesión.

# 3. Importar los archivos

# Con el proyecto listo, ya podemos importar los textos con los que trabajaremos. Para ello, crearemos un objeto llamado `programa` al que le asignaremos como valor todos los textos que están en la subcarpeta `programas_elecciones2017`:

programas <- readtext("programas_elecciones2017/*")

# Miremos el dataframe que se creó
programas

# Si bien eso es suficiente para importar los archivos, la función readtext() tiene varios argumentos que pueden hacer el proceso de crear un corpus más efectivo y eficiente. Por ejemplo, nos permite crear variables a partir de información contenida en el nombre del archivo, es decir, de los metadatos de los textos que vamos a analizar. Además, podemos indicar información relativa a la codificación de los textos:

programas <- readtext("programas_elecciones2017/*",
                                     docvarsfrom = "filenames", 
                                     docvarnames = c("candidato", "eleccion", "coalicion"),   
                                     dvsep = "_",           
                                     encoding = "UTF-8") # ¡siempre UTF-8!

# Si mirarmos nuevamente el dataframe que creamos, ahora tenemos nuevas variables. Este es solo un ejemplo de lo importante que es utilizar sabiamente el nombre de los archivos. 

programas

# Para poder empezar el proceso de análisis con el paquete `quanteda`, necesitamos crear un tipo de objeto especial en R: un corpus. Para ello, utilizaremos la corpus(). Tenemos que indicar el objeto/dataframe que tiene nuestros datos y el nombre de la columna que contiene el texto:

corpus_programas <- corpus(programas, text_field = "text")  

# Demos una mirada al corpus
summary(corpus_programas)

# Sería mejor cambiar los nombres de los documentos (columna "Text"). Por defecto, en ellos se incluye el nombre del archivo. Mientras más metadatos tenga el nombre, más largos serán. Lo que haremos será reescribir esa variable

doc_id <- paste(programas$candidato, programas$eleccion, sep = "-") 
# es decir, creamos un objeto que pegue candidato y año, separados por un guion -

# sobrescribimos la variable
docnames(corpus_programas) <- doc_id  

#veamos cómo quedó
summary(corpus_programas) 

# Antes de empezar a analizar, pensemos qué hacer con este objeto corpus. Tenemos el script para volver a crearlo cada vez que queramos. Pero si ya está listo y no lo volveremos a modificar, podríamos guardarlo como un objeto de R y así está listo para cuando lo necesitemos en el futuro:

write_rds(corpus_programas, "corpus_programas.rds")

# En el futuro lo cargamos así:

corpus_programas <- readRDS("corpus_programas.rds")


# ANÁLISIS DE PALABRAS CLAVE: KEYNESS
discursos_2018 %>% 
  dfm(groups = "", remove = stopwords(""), remove_punct = , remove_numbers = ) %>% 
  textstat_keyness(target = "") %>% 
  textplot_keyness()

# Análisis de concordancias

kwic(corpus_programas, "", 3)
kwic(corpus_programas, "*", 3)
kwic(corpus_programas, "", 3, "regex")


# si quieres guardar los resultados, puedes hacerlo como csv, para ello, luego del código agrega un %>% y la función para escribir archivos delimitados por algo (¡no por comas!):

write_delim("nombredelarchivo.csv", delim = "|")  # lo abriremos en Libre Office para ver cómo queda. MUY MUY IMPORTANTE elegir sabiamente el delimitador

# ANÁLISIS DE DISPERSIÓN LÉXICA: para saber en qué parte de un discurso se ubica un determinado término. 

#Buscar palabras tal como aparecen
corpus_programas %>% 
  kwic("") %>% 
  textplot_xray()

#Usar comodines
corpus_programas %>% 
  kwic("*") %>% 
  textplot_xray()

# Frases
corpus_programas %>% 
  kwic(phrase("")) %>% 
  textplot_xray()

# Expresiones regurales
corpus_programas %>% 
  kwic("", valuetype = "regex") %>% 
  textplot_xray() 


