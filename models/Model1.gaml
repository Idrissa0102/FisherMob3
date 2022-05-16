/**
* Name: Model1
* Based on the internal empty template. 
* Author: Idrissa SOW
* Tags: Définition de l'environnement
*/

model Model1

import "Mobility.gaml"

/* Insert your model definition here */

global {
	
	//Définition des variables
	int nb_unitePeche <- 10;	
	
	//Définition des fichiers shapefiles d'environnement
	file shapefile_coastline <- file("../includes/shapefile/world-coastline-110-million.shp");
	file shapefile_region <- file("../includes/shapefile/region.shp");
	
	//Définition des fichiers shapefiles d'information sur l'environnement
	file shapefile_temperature <- file("../includes/shapefile/temperature.shp");
	
	//Définition des fichiers shapefiles des sites de débarquement et des zones de pêche
	file shapefile_quai <- file("../includes/shapefile/principaux_sitesDebarquement.shp");  
	file shapefile_zonePeche <- file("../includes/shapefile/zonePeche.shp");
	
	//Définition des icônes
	image_file anchor <- image_file("../includes/icon/anchor.png");
	image_file boat <- image_file("../includes/icon/boat.png");
	
	//Définition de l'enveloppe d'environnement
	geometry shape <- envelope(shapefile_temperature);
	
	//Initialisation
	init {
		//Création des élèments region et coastline
		create region  from: shapefile_region with: [name:: read('NAME_1')];
		create coastline from: shapefile_coastline;
		
		//création de l'élèment quai de pêche ou encore site de débarquement
		create quai from: shapefile_quai with: [name:: read('Nom')];
		
		//Création de l'élèment zone de pêche
		create zonePeche from: shapefile_zonePeche with: [name:: read('nom')];
		
		//Création de l'élèment unité de pêche
		create unitePeche number: nb_unitePeche {
			start_work <- rnd(min_work_start, max_work_start);
			end_work <- rnd (min_work_end, max_work_end);
			objective <- "resting";
			location <- any_location_in(one_of(petiteCoteQuai));
		}
	}
}

//Définition des species

//**Coastline**

species coastline {
	aspect default{
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

//**Zone de pêche**
species zonePeche {
	aspect default {
		draw circle(5000) color: #cyan;
		draw name size:10 color: #black;
	}
}

experiment main type: gui {
	output {
		display carte_principale background: rgb(224,255,255){
			species region;
			species coastline;
			species quai;
			species zonePeche;
			species unitePeche;
		}
	}
}