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

  (*TODO : Reverse le PATH ;-; *)
(*Problème actuel : Transformer un path (=String)(UPDATE: QUIPROQUO DANS MA TETE ENTRE 2 PATHS /home... et chemin graphe;; On annule tout) en int list*) (* je la fait en global parce que je sens qu'on va en avoir besoin ailleur aussi*)
    (* Le but est d'isoler tous les int du path*)
    
  (* Maintenant qu'on a peut trouver un chemin du puit vers la source, il faut trouver combien de flot on peut rajouter sur ce chemin *)
  (* Je pense qu'il faut donc faire un algo qui à partir d'un chemin (int list?) (plutot path option) retourne le label minimum des arcs traversé *)
  let flot_possible gr chemin = 
    
    (*fonction pour trouver le label d'un arc*)
    let label_arc gr s1 s2 = match find_arc gr s1 s2 with
    |None -> -1
    |Some a -> a.lbl
    in 
    let rec find_min gr chemin acc = match chemin with
    |[] -> acc
    |[_] -> acc
    |x::y::xs -> let label_arc_value = label_arc gr x y in
    begin match ((label_arc_value) < acc) with 
      |false -> find_min gr (y::xs) acc
      |true -> find_min gr (y::xs) label_arc_value
    end
    in
    match chemin with 
    |None -> -1
    |Some c -> find_min gr c max_int
    
    
    
  

