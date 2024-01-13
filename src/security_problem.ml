(* 
Histoire : Il y a plusieurs locaux de OcamlCorp qui ont reçu des cyberattaques de différents types, 
Heuresement, au ClubInfo on a des "cyber security prodigee" dans divers domaines et plein d'autre personne tout aussi efficace, 
Chaque local peut recevoir de l'aide de plusieurs personne spécialisé (en fonction de la criticité de l'attaque) dans le type de la cyberattaque qu'elle a reçu (web, reverse, pwn, osint, misc, social-engineering)
Chaque personne ne peut partir que à 1 local.
Chaque personne peut avoir plusieurs spécialité. (Sauf Baptiste il fait que du web)
Quelle est la configuration qui permet d'envoyer le + de personnes du club, ( dans le but d'avoir un maximum d'efficacité ($$$) )

*)


(*
Il faut dans un premier temps générer un/des graphes représentant notre problème :
Étape 1 : 
Il faut une liste de Node "personne" avec les spécialités, une liste de Node "locaux" avec la cause de la panne (même enum que spécialité)
Étape 2 : Construire le graphe : 
  -Le source relie chaque Node personne par un arc de 1
  -Chaque Node personne "émet" un arc vers les locaux où elle peut agir
  -Chaque Node local "émet" un arc plus ou moin grand (faille critique => on autorise + de monde à venir) vers le puit

Idée : on fait le FordFulkerson la dessus donc : 
  -Il y'a que 1 qui rentre dans une Personne donc elle ne peut choisir que un local
  -Il y'a que X qui sort du local donc elle ne peut avoir que X arc de personne entrante
  -En cherchant le flux max, on cherche à faire sortir le + de personne (du club). 

Le transformer en graphe résiduelle
Le mettre en input à notre Ford-Fulkerson
*)