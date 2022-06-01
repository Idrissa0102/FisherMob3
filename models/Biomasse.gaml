/**
* Name: Biomasse
* Based on the internal empty template. 
* Author: Idrissa SOW
* Tags: 
*/


model Biomasse

import "Initialisation.gaml"
import "Mobility.gaml"

/* Insert your model definition here */

global {
	
	//Définition des fichiers CSV contenant les coordonnées géographiques des zones de pêche
	file data_csv_file <- csv_file("../includes/gis/data.csv", ",", float);
	
	//Définition des fichiers shapefiles des sites de débarquement et des zones de pêche
	file shapefile_quai <- file("../includes/shapefile/principaux_sitesDebarquement.shp");  
	file shapefile_zonePeche <- file("../includes/shapefile/zonePeche.shp");
	
	init {
		//Création de l'élèment zone de pêche
		create zonePeche from: shapefile_zonePeche with: [name:: read('nom')];
	}
}


//**Zone de pêche**
species zonePeche {
	aspect default {
		draw circle(5000) color: #cyan;
		draw name size:10 color: #black;
	}
	
	reflex when: biomasseInitiale > 0 {
		ask zonePeche {
			ask unitePeche overlapping(self) {
				biomasseInitiale <- biomasseInitiale - biomasseAcapture;
				bioCapture <- bioCapture + biomasseAcapture;
				self.dejaPeche <- false;
			}
		}
	} 
}