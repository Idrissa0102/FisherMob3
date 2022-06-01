/**
* Name: Model1
* Based on the internal empty template. 
* Author: Idrissa SOW
* Tags: Définition de l'environnement
*/

model Simulation

import "Mobility.gaml"
import "Carte.gaml"
import "Biomasse.gaml"

/* Insert your model definition here */

global {
	
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
		layout #split;
		display carte_principale background: rgb(224,255,255) {
			species region;
			species coastline;
			species quai;
			species zonePeche;
			species unitePeche;
		}
		display Information_biomasse refresh: every(1#cycle) {
			chart "Biomasse evolution" type: series size: {1,0.5} position: {0, 0} {								
				data "Biomasse Initiale" value: biomasseInitiale color: #red;
				//data "biomasse Récupéré" value: bioRecup color: #blue;
			}
		}
	}
}
