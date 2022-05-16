/**
* Name: Mobility
* Based on the internal empty template. 
* Author: Idrissa SOW
* Tags: 
*/


model Mobility

/* Insert your model definition here */

species unitePeche skills: [moving] {
	
	//Définition des variables 
	float step <- 10 #mn;
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
	
	list<point> quaiPeche <- [{334458.74725824257,782628.8613783105,0.0},{385367.6154990749,604898.1982981609,0.0},{380433.87402907206,635239.7271244419,0.0},{360852.6286328203,667777.9581647147,0.0},{348003.58581767563,688093.2080651321,0.0},{341921.93170620094,696561.9725581724,0.0},{318439.08465571335,726288.7005036252,0.0},{279962.8227315236,742527.7793151378,0.0},{305606.46633402386,750460.3385309521,0.0},{312519.9423048096,756839.1142571189,0.0},{348286.27728582243,810416.4906229244,0.0},{388247.0685340739,813785.9259948276,0.0},{356322.90766194416,835266.1268445058,0.0},{356715.2201640652,946523.5184152278,0.0},{408475.3247586143,984394.861393054,0.0},{451488.6919753274,985521.7972549673,0.0},{358448.58111819974,1007836.5411530479,0.0}];
    list<point> zone_Peche <- [{264768.43805610057,758613.5325372044,0.0},{312113.6791837746,783932.1210023777,0.0},{339299.4470260165,811113.2950564628,0.0}];
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
