/**
* Name: Model1
* Based on the internal empty template. 
* Author: Idrissa SOW
* Tags: Définition de l'environnement
*/

model Model1

import "Mobility.gaml"
import "Carte.gaml"
import "Biomasse.gaml"

/* Insert your model definition here */

global {
	
	//Définition des variables
	int nb_unitePeche <- 10;
	
	//Initialisation
	init {
		
		//Création de l'élèment unité de pêche
		create unitePeche number: nb_unitePeche {
			start_work <- rnd(min_work_start, max_work_start);
			end_work <- rnd (min_work_end, max_work_end);
			objective <- "resting";
			location <- any_location_in(one_of(petiteCoteQuai));
		}
	}
}



experiment main type: gui {
	output {
		display carte_principale background: rgb(224,255,255) {
			species region;
			species coastline;
			species quai;
			species zonePeche;
			species unitePeche;
		}
	}
}