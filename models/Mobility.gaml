/**
* Name: Mobility
* Based on the internal empty template. 
* Author: Idrissa SOW
* Tags: 
*/


model Mobility

import "Initialisation.gaml"

/* Insert your model definition here */

species unitePeche skills: [moving] {
	
	//Définition des variables 
	//float step <- 10 #s;
	int nb_unitePeche <- 10;
	date starting <- date("2022-01-01-00-00-00");
	int start_work;
	int end_work;
	int min_work_start <- 6;
	int max_work_start <- 8;
	int min_work_end <- 16;
	int max_work_end <- 20;
	string objective;
	point the_target <- nil;
	bool dejaPeche <- true;
	
	//Définition de l'icône
	image_file boat <- image_file("../includes/icon/boat.png");	
	
    list<point> petiteCoteQuai <- [{312519.9423048096,756839.1142571189},{334458.74725824257,782628.8613783105},{348286.27728582243,810416.4906229244}];
	list<point> petiteCoteZonePeche <-[{312113.6791837746,783932.1210023777},{339299.4470260165,811113.2950564628}];
	
	reflex time_to_work when: current_date.hour = start_work and objective = "resting" {
		objective <- "working";
		the_target <- any_location_in(one_of(petiteCoteZonePeche closest_to(self)));		
	}
	
	reflex time_to_go_home when: current_date.hour = end_work and objective = "working" {
		objective <- "resting";
		if (objective = "resting") {
			dejaPeche <- true;
		}
		the_target <- any_location_in(one_of(petiteCoteQuai closest_to(self)));
	}
	
	reflex move when: the_target != nil {
		do goto target: the_target;
		if the_target = location {
			the_target <- nil;
		}
	}
	
	aspect default {
		draw boat size: 9000;
	}
}
