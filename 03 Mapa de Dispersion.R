#                                              Aprende R desde Cero 
# Clase 04- Mapa de Ubicacion, dispercion de especies

# Universidad Nacional Amazonica Madre de Dios
# Gorky Florez Castillo
# Direccion: Grimanesa masifue 
# Correo electronico Personal: tuspres@gmail.com
# Correo Institucional :  gflorezc@unamad.edu.pe
# Telefono Personal: 958154521
# Estudiante de pre-grado
# Facultad de Ingenieria  
# Escuela profesional de Ingenieria Forestal y Medio Ambiente 

# Librerias
#------------------------------------------------------------------------
library(tidyverse)
library(rnaturalearth)                                   #Continentes
library(rnaturalearthdata)                               #Continentes especifico
library(sf)
library(raster)                                          # Extracion de Peru
library(reticulate)
library(maptools)
library(maps)
library(ggplot2)                                         # Graficos avanzados
library(ggspatial)                                       # Norte
library(rgeos)
library(sf)
library(purrr)
library(tidyverse)
library(ggrepel)
#------------------------------------------------------------------------
Poligono_C     <- st_read ("SHP_AVRACO/POLIGONO_AVRAKCO.shp")                       # Poligono
Vertices       <- st_read ("SHP_AVRACO/PUNTO_AVRAKO.shp")                           # Puntos
Puntos_In      <- st_read ("SHP_AVRACO/PUNTOS_INVENTARIOAVRAKCO.shp")               # Puntos
Rios           <- st_read ("SHP_AVRACO/Rios.shp")                                   # Lineas
Poligono_C_utm  <- st_transform(Poligono_C , crs = st_crs("+proj=longlat +datum=WGS84 +no_defs"))
Vertices_utm    <- st_transform(Vertices , crs = st_crs("+proj=longlat +datum=WGS84 +no_defs"))
Puntos_In_utm  <- st_transform(Puntos_In , crs = st_crs("+proj=longlat +datum=WGS84 +no_defs"))

Puntos_In_utm_C       <- st_centroid(Puntos_In_utm)                                       # Centros de cada pais
Puntos_In_utm_C       <- cbind(Puntos_In_utm, st_coordinates(st_centroid(Puntos_In_utm$geometry))) #Utilizamos la geometria

P1 <-ggplot() +
  geom_sf(data= Poligono_C_utm , fill="beige")+
  geom_sf(data= Vertices_utm , fill="red", size=4, shape=22)+
  geom_sf(data= Puntos_In_utm_C , aes(x=X, y=Y, fill=NOMBRE_COM), size=2, shape=22)+
  geom_sf(data= Rios , fill=NA, color="blue")+
  geom_text_repel(data = Vertices_utm, aes(x=NORTE_m, y=ESTE_m, label = Vertices), size = 3)+
  coord_sf(xlim = c(-69.95023,-69.90309), ylim = c(-12.88439,-12.83429),expand = FALSE)+
  theme_void()+
  annotation_scale(location = "bl", width_hint = 0.4, style="ticks") +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.75, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering)+
  labs(title = "Mapa de Dispersión ", 
       subtitle="Especies Forestales",caption="Gorky Florez",x="Longitud",y="Latitud",tag="")+
  labs(fill = "Especies forestales")
#------------------------------------------------------------------------
ggsave("Mapa de dispersion de Especies.png",
       plot = P1, width =  9,height = 8, dpi=900)





















