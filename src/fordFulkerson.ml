open Graph

(* A path is a list of nodes. *)
type path = id list




(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
*)
(*On fait un DFS*)
let find_path gr forbidden src dest = 
  (*fct pour explorer les arcs sortants de notre source, si il en existe pas alors on a fini de visité le node et on va chercher les autres*)

  let rec explore gr forbidden node dest pathacu = match node = dest with 
    | true -> Some (pathacu) 
    | false ->  begin match (out_arcs gr node) with (* init pathacu à [] lors de son appel *)
        |[] -> None (* Si on arrive au bout c'est qu'on a pas trouvé de chemin *)


        |x -> List.fold_left (fun acc e -> begin match acc with (* explorer tous les suivants et on note le noeud précédent comme visité *)
            |None -> explore gr (node::forbidden) e.tgt dest (e.tgt::pathacu)
            |Some y -> Some y
          end) None x
      end
  in
  match src with
  |node when node = dest -> Some [src]
  |src -> (explore gr forbidden src dest [src])


      (*
      match src with
        | tgt -> [src]
        | s -> match (out_arcs gr src) with begin (*deja visite prend la valeur arc*)
        |
          | [] -> [src]
          | x::xs -> find_path gr [x]
        end
      *)


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





       *)
