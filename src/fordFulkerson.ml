(* A path is a list of nodes. *)
type path = id list

    fd


(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
*)

let find_path gr forbidden src dest =


(*

Grandes étapes de l'algo : 

Graphe vide au début
Répéter en boucle jusqu'à ce que le graphe G soit plein (Aucun chemin trouvé avec le BFS): 


BFS : 
- Il faut tenir une liste des cases visités en tant que source
- On part d'un premier noeud, on regarde avec out_arcs ( attention si c'est un out depuis le tgt  cf 3eme -), on trie les noeuds visités,
 on visite ceux qui sont pas visité, si on tombe sur le puit, on return le chemin seulement si ça augmente la capa total? pas avec ma méthode j'crois #analyse  si ca return un chemin ça augmente forcément la capa ah bah c'est relou x)
- Si il y a un arc avec le prochain il faut aussi ( 2 sens ) : 
    -src vers tgt, il faut que la capa de l'arc ne soit pas plein
    -tgt vers src, il faut que la capa de l'arc ne soit pas vide "faut faire out_arc sur le tgt et trier pour voir uniquement si y'a un arc avec la src ( proposition) ""
enfaite si on fait pas un graphe résiduel va falloir tout recalculer à chaque ité donc niveau opti c dla merde donc TU va le faire  e pense que les fonctions qu'on a codées dans tools etaient faites pour ça






    Faire le graphe résiduel , quand on parcours le residu, et qu'on trouve un chemin possible, c'est possible que si on le rempli ce soit pas optimal? (non parce que quand c'es)
    Trouver un chemin de la source au sink (BFS) 
    Ajuster les labels des arcs du graphe G


faudra faire les graphes intermédiaires (graphe résiduel ?)
jpense pas , j'réfléchi, déjà on peut commencer par faire find_path, mais après qu'est-ce qu'on fait de lui -> on l'utilise dans le graphe résiduel

*)
