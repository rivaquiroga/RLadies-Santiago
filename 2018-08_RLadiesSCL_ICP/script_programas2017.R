#Si no los tienes ya, instala los siguientes paquetes:
# install.packages("readtext")
# install.packages("quanteda")
# install.packages("tidyverse") # o al menos `dplyr`, `ggplot2` y `readr`


library(readtext) # para importar los archivos de texto
library(quanteda) # para hacer el análisis
library(dplyr) # funciones para manipular datos + %>% 
library(ggplot2) # para editar los gráficos que por defecto entrega quanteda
library(readr) # para exportar las búsquedas de concordancias

# También puedes cargar todo el Tidyverse: library(tidyverse)

# Versión rápida para importar los textos:
programas <- readtext("programas_elecciones2017/*")

# Pero mejor usar más argumentos

programas <- readtext("programas_elecciones2017/*",
                                     docvarsfrom = "filenames", 
                                     docvarnames = c("candidato", "eleccion", "coalicion"),   
                                     dvsep = "_",           
                                     encoding = "UTF-8") 

# Creamos el corpus, con la función corpus(). Tenemos que indicar en qué columna está el texto.
corpus_programas <- corpus(programas, text_field = "text")  

# Damos una mirada al corpus
summary(corpus_programas)

# Sería mejor cambiar los nombres de los documentos (columna "Text"). Piensen que mientras más variables incluyan en el nombre, más largos serán. Podemos hacerlo así: 

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

write_delim("nombredelarchivo.csv", delim = "|")  # lo abriremos en libreoffice para ver cómo queda. MUY IMPORTANTE elegir sabiamente el delimitador

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


