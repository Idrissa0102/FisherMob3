/**
* Name: Carte
* Based on the internal empty template. 
* Author: Idrissa SOW
* Tags: 
*/


model Carte

/* Insert your model definition here */

global {
	
	//Définition des fichiers CSV contenant les coordonnées géographiques des quais et des zones de pêche
	file data_csv_file <- csv_file("../includes/gis/data.csv", ",", float);
	
	//Définition des fichiers shapefiles d'environnement
	file shapefile_coastline <- file("../includes/shapefile/world-coastline-110-million.shp");
	file shapefile_region <- file("../includes/shapefile/region.shp");
	
	//Définition des fichiers shapefiles d'information sur l'environnement
	file shapefile_temperature <- file("../includes/shapefile/temperature.shp");
	
	//Définition des fichiers shapefiles des sites de débarquement et des zones de pêche
	file shapefile_quai <- file("../includes/shapefile/principaux_sitesDebarquement.shp");  
	file shapefile_zonePeche <- file("../includes/shapefile/zonePeche.shp");
	
	//Définition de l'enveloppe d'environnement
	geometry shape <- envelope(shapefile_temperature);
	
	//Définition des icônes
	image_file anchor <- image_file("../includes/icon/anchor.png");
	image_file boat <- image_file("../includes/icon/boat.png");
	
	init {
		//Création des élèments region et coastline
		create region  from: shapefile_region with: [name:: read('NAME_1')];
		create coastline from: shapefile_coastline;
		
		//création de l'élèment quai de pêche ou encore site de débarquement
		create quai from: shapefile_quai with: [name:: read('Nom')]{
			matrix<float> data <- matrix(data_csv_file);
			loop i from: 0 to: data.rows - 1 {
				point poi_location_WGS84 <- {data[0,i], data[1,i]};
				point poi_location_GAMA <- point(to_GAMA_CRS(poi_location_WGS84, "EPSG:4326"));				
			} 
		}
				
		
	}
}

//Définition des species

//**Coastline**

species coastline {
	aspect default {
		draw shape color: #black border: #black;		
	}
}

//**Region**
species region {
	aspect default {
		draw shape color: #white border: #black;
		draw name size:10 color: #gray;		
	}
}

//**Quai**
species quai {
	aspect default {
		draw anchor size:10000;
		draw name size: 10 color: #black;
	}
}
