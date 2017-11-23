# TERCER MEETUP DE @RladiesSantiago 
# Taller de introducción al tidyverse a cargo de @rivaquiroga




# LOS PAQUETES
# Cada vez que iniciamos una sesión tenemos que indicarle a R qué paquetes vamos a utilizar

library(tidyverse) # aquí estamos llamando a todos los paquetes que lo conforman. Nosotras trabajaremos específicamente con tres: dplyr, ggplot y readr. 
library(gapminder) 

# MIRADA INICIAL A LOS DATOS

gapminder # el paquete que descargamos contiene un objeto con la base de datos. Al escribir su nombre se imprimen las 10 primeras líneas y la cantidad de columnas qu caben en el ancho de página.
View(gapminder) # muestra la base completa en otra pestaña
str(gapminder) # imprime información sobre el dataset y las variables
glimpse(gapminder) # imprime las primeras observaciones de cada variable
head(gapminder) # imprime las seis primeras líneas
tail(gapminder) # imprime las últimas seis líneas (muy útil para chequear si la base que cargamos está completa)


#COMPARAR CÓDIGOS: tidyverse / R base

# Imagina que queremos saber cuánto fue el PIB de los países de Asia en el 2007.  
# En R base lo podríamos averiguar así: 
sum(select(filter(gapminder, year == 2007, continent == "Asia"), gdpPercap)) # el código se entiende desde adentro hacia afuera. 

# Tidyverse: el código funciona como leemos: de izquierda a derecha y de arriba hacia abajo. Para ello, se utiliza el operador ' %>% ', que en inglés se llama "pipe" y se puede leer como "luego" o "a continuación".

gapminder %>% # tomar la base gapminder, luego
    filter(year == 2007, continent == "Asia") %>% # filtrar, luego
    select(gdpPercap) %>% #seleccionar la variable PIB, luego
    sum() # sumar 

# las dos formas de escribir el código llevan al mismo resultado.


# FILTRAR
# con la función filter() podemos filtrar casos

gapminder %>% 
    filter(country == "Chile")

# el objeto gapminder no ha cambiado. Si queremos mantener el filtro, tenemos que crear un objeto nuevo. Podemos hacerlo usando el operador <- 

gapminder_CL <- gapminder %>% 
    filter(country == "Chile")

# no se imprimió nada en la consola, ya que R no imprime nada cuando creamos un objeto. Imprimámoslo para ver cómo quedó:

gapminder_CL

# el nuevoobjeto solo contiene los datos filtrados


# Ahora que tenemos ese objeto, podemos hacer una gráfico usando ggplot, en el que indicamos cuáles son los datos, qué tipo de gráfico vamos a utilizar y cómo se van 'mapear' las variables (eje x e y, en este caso)

ggplot(data = gapminder_CL) + geom_line(mapping = aes(x = year, y = gdpPercap))

# una versión del mismo código, pero simplificada, sería la siguiente:  
ggplot(gapminder_CL) + geom_line(aes(year, gdpPercap)) # ggplot sabe que lo primero que indico son los datos, y que el primer y segundo argumento son las variables del eje x e y , así que no es necesario explicitar todo eso.

# La función ggplot también puede incluirse dentro del código que utilizamos antes para filtrar la base. Es decir, no tenemos por qué crear un objeto distinto con los datos de Chile para poder graficar solo esos datos. 

gapminder %>% 
    filter(country == "Chile") %>% 
    ggplot() + geom_line(aes(year, gdpPercap)) # la única diferencia es que luego de ggplot() no tengo que indicar cuáles son los datos, ya que los indiqué al principio del código


# También puedo filtrar por otras variables. Por ejemplo, por continente. En este ejemplo, seleccionamos Oceanía, que incluye dos países: Australia y Nueva Zelanda. 
gapminder %>% 
    filter(continent == "Oceania") %>% 
    ggplot() + geom_line(aes(year, gdpPercap)) #¡Algo pasa con este gráfico! Queda una sola línea muy extaña.

# Lo que ocurrió fue que no explicitamos cómo distinguir entre los datos de ambos países. Para eso, podemos agregar un argumento más en aes(): indicar que los países se distingan por color
gapminder %>% 
    filter(continent == "Oceania") %>% 
    ggplot() + geom_line(aes(year, gdpPercap, color = country))

#si queremos comparar más de un elemento, podemos crear un vector que los incluya. Al filtrar, indicamos que seleccione los países que se encuentran mencionados en ese vector:

gapminder %>% 
    filter(country %in% c("Argentina", "Chile", "Uruguay")) %>% 
    ggplot() + geom_line(aes(year, gdpPercap)) #¡no olvidar agregar que distinga los países por color!:

gapminder %>% 
    filter(country %in% c("Argentina", "Chile", "Uruguay")) %>% 
    ggplot() + geom_line(aes(year, gdpPercap, colour = country))
# Ahí sí queda bien 


# Al filtrar podemos indicar también condiciones que se tengan que cumplir. Por ejemplo, filtrar los casos del año 2007 de los países en que el PIB per cápita haya sido inferior a mil dólares:

gapminder %>%
    filter(year == 2007, gdpPercap < 1000) 


# REORDENAR
# con arrange() podemos reordenar los casos. En esta base vienen por orden alfabético de los países. Podemos cambiar eso.

# ordenar los datos de América en 2007, según expectativa de vida:
gapminder %>%
    filter(year == 2007, continent == "Americas") %>% 
    arrange(lifeExp) #por defecto el orden es ascendente

# Puedo cambiarlo a descendente utilizando desc()
gapminder %>%
    filter(year == 2007, continent == "Americas") %>% 
    arrange(desc(lifeExp))

# NO NOS OLVIDEMOS DE HANS ROSLING
# En su video, Hans Rosling muestra la relación que existe entre PIB percápita y expectativa de vida. Creemos ese gráfico para el año 2007:

gapminder %>% 
    filter(year == 2007) %>% 
    ggplot() + geom_point(aes(gdpPercap, lifeExp, color = continent)) 

# los datos del PIB se encuentran muy concentrados hacia el lado izquierdo. Para poder ver mejor la relación, podemos ajustar la escala con la opción scale_x_log10()

gapminder %>% 
    filter(year == 2007) %>% 
    ggplot() + geom_point(aes(gdpPercap, lifeExp, color = continent)) + scale_x_log10() 

# Todavía podemos mejorar este gráfico: el valor mínimo de los años no se encuentra en cero. Para ajustarlo, utilizaremos + expand_limits(y = 0) 

gapminder %>% 
    filter(year == 2007) %>% 
    ggplot() + geom_point(aes(gdpPercap, lifeExp, color = continent)) + scale_x_log10() + expand_limits(y = 0) 

# ¿Y si quisiera ver los datos en gráficos distintos? Para eso puedo ocupar las opción +facet_wrap() e indicar en su interior la variable de interés.

gapminder %>% 
    filter(year == 2007) %>% 
    ggplot() + geom_point(aes(gdpPercap, lifeExp, color = continent)) + scale_x_log10() + expand_limits(y = 0) + facet_wrap(~continent)


# A nuestro gráfico aún le faltan algunas cosas importantes, como ponerle nombre a los ejes. Podemos hacerlo con +xlab() e +ylab().

gapminder %>% 
    filter(year == 2007) %>% 
    ggplot() + geom_point(aes(gdpPercap, lifeExp, color = continent)) + scale_x_log10() + expand_limits(y = 0)  +xlab("PIB per cápita") +ylab("Expectativa de vida (US$)")

# ¿Y el título? Lo pueden agregar con +ggtitle(). Igual que con xlab() e ylab(), tienen que ponerlo con comillas


# RESUMIR/SINTETIZAR y AGRUPAR
# La función summarize() sirve para resumir información en una nueva tabla.
# ¿cuál fue el promedio de la expectativa de vida el año 2007?

gapminder %>% 
    filter(year == 2007) %>% 
    summarize(media_exp_vida = mean(lifeExp)) #el nombre antes de "=" lo inventamos nosotros
    
# Este dato no es muy informativo, ya que resume demasiada información. Si pudieramos saber cuál fue la expectativa de vida por continente, podríamos comprender mejor los datos. Para eso, podemos utilizar group_by()

gapminder %>% 
    filter(year == 2007) %>% 
    group_by(continent) %>% #agrupa los datos por continente
    summarize(media_exp_vida = mean(lifeExp))

# Miremos más: en vez de ver solo un año, revisémoslos todos. Agrupemos por continente y luego por año:

gapminder %>% 
    group_by(continent, year) %>% 
    summarize(media_exp_vida = mean(lifeExp)) 

# si agregamos %>% View() al final, podemos ver todos los resultados

gapminder %>% 
    group_by(continent, year) %>% 
    summarize(media_exp_vida = mean(lifeExp)) %>% 
    View()

# Podemos guardar estos datos en un archivo csv. Solo necesitamos una línea más de código

gapminder %>% 
    group_by(continent, year) %>% 
    summarize(media_exp_vida = mean(lifeExp)) %>% 
    write_csv("exp_vida.csv") #si creamos un proyecto en RStudio, se guardará en la misma carpeta 

# Si más adelante queremos leer esos datos en R, ocupamos el código inverso: read_csv() y creamos un objeto en R

exp_vida_continente <- read_csv("exp_vida.csv") #si ya no estamos dentro del proyecto, tendríamos que indicar toda la ruta del archivo.

# grafiquemos esos datos. Como creamos un objeto con ellos, podemos irnos directo a ggplot
ggplot(exp_vida_continente) + geom_line(aes(year, media_exp_vida, colour = continent)) + expand_limits(y = 0)
    
# podrían agregarle nombre a los ejes y título :)

# CREAR NUEVAS VARIABLES
# mutate() sirve para crear una nueva variable en función de una que ya existe

# primero, creemos un objeto nuevo que tenga solo los datos de Chile: gapminder_CL

gapminder_CL <- gapminder %>% 
    filter(country == "Chile")

# en esta base el PIB está calculado en dólares. Podríamos crear una nueva variable en la que se indique el valor en pesos. Asumamos que el dolar está a 640 (pueden cambiarlo por el valor del día si quieren ser más precisas):

gapminder_CL %>% 
    mutate(PIBpercap_pesos = 640 * gdpPercap)
# la variable nueva quedó en el extremo derecho de la tabla. Puede que no la vean, porque se muestran solo las columnas que caben en la ventana. En ese caso, puede utilizar agrgar %>% View() para mirarla:

gapminder_CL %>% 
    mutate(PIBpercap_pesos = 640 * gdpPercap) %>% 
    View()

# también podríamos recalcular la población, para que nos la muestre en millones. Agreguen %>% View() al final si no pueden ver la columna

gapminder_CL %>% 
    mutate(PIBpercap_pesos = 640 * gdpPercap, pop_millones = (pop / 1000000))

# quedaría mejor si redondéaramos el valor. Para eso podemos ocupar round(). En esta función tenemos que indicar dos cosas: qué queremos redondear y cuántos decimales incluir: 

gapminder_CL %>% 
    mutate(PIBpercap_pesos = 640 * gdpPercap, pob_millones = round((pop / 1000000),1))

# SELECCIONAR VARIABLES
# Después de ejecutar el código anterior nos quedamos con algunas variables duplicadas. Además, tenemos algunas variables que ya no son útiles: esta base solo tiene datos de Chile y todas sabemos en qué continente se encuentra. Con select() podemos seleccionar columnas. 

# reescribiremos nuestro objeto gapminder_CL

gapminder_CL <- gapminder_CL %>% 
    mutate(PIBpercap_pesos = 640 * gdpPercap, pob_millones = round(pop / 1000000, 1)) %>% 
    select(year, pob_millones, lifeExp, PIBpercap_pesos, gdpPercap)

# si revisamos gapminder_CL, ahora solo tiene los datos que nos interesan. Las columnas quedaron en el mismo orden en que las seleccionamos:

gapminder_CL

# IMPORTANTE: si uno no quisiera perder por el momento esas otras variables, podría crear un objeto nuevo, no reescribirlo. Es decir, asignarle otro nombre, no gapminder_CL


#RENOMBRAR VARIABLES
# con rename() podemos cambiarle el nombre a las variables. Si bien R nos deja poner ñ y tildes, al exportar los datos como csv habrá problemas. Así que sin ñ y sin tildes. La lógica de la función es: rename(nombrenuevo = nombreactual)

#cambiemos el nombre de las variables que están en inglés en gapminder_CL: year, lifeExp y gdpPercap. Para eso, reescribiremos el objeto gapminder_CL y agregaremos al final una línea para guardar el archivo: 

gapminder_CL <- gapminder_CL %>% 
    rename(ano = year, exp_vida = lifeExp, PIB_percap_dolares = gdpPercap) %>% 
    write_csv("gapminder_chile.csv")


# ¡Eso es todo por ahora! Sigan explorando la base y visualizando los datos con ggplot(). Prueben otros tipos de gráficos y, en caso de que no lo hayan hecho, vean los videos de Hans Rosling :)
